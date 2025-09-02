import 'package:syncupc/config/constants/app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceService {
  Future<String> checkIn(String token, String eventId) async {
    final url = Uri.parse('${AppConfig.baseUrl}/attendance/checkin');

    try {
      print("🔍 Enviando request a: $url");
      print("🔍 EventId: $eventId");

      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "eventId": eventId,
        }),
      );

      print("🔍 Status Code: ${response.statusCode}");
      print("🔍 Response Body: ${response.body}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        return responseData['data']['nombre'];
      } else if (response.statusCode == 400) {
        try {
          final errorData = json.decode(response.body);
          // IMPORTANTE: Usar 'Message' con mayúscula como viene del backend
          final message =
              errorData['Message'] ?? errorData['message'] ?? 'Datos inválidos';
          throw Exception(message); // Solo el mensaje, sin prefijo
        } catch (e) {
          if (e.toString().startsWith('Exception:')) {
            rethrow;
          }
          throw Exception('Error de validación: Verifica los datos ingresados');
        }
      } else if (response.statusCode == 401) {
        throw Exception('401');
      } else if (response.statusCode == 403) {
        throw Exception('403');
      } else if (response.statusCode == 500) {
        throw Exception('Error del servidor: Intenta más tarde');
      } else {
        throw Exception(
            'Error al registrar asistencia (${response.statusCode})');
      }
    } on http.ClientException {
      throw Exception('Sin conexión a internet');
    } catch (e) {
      print("🔍 Error en service: $e");
      if (e.toString().startsWith('Exception:')) {
        rethrow;
      }
      throw Exception('Error inesperado: ${e.toString()}');
    }
  }
}
