import 'package:syncupc/config/constants/app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AttendanceService {
  Future<String> checkIn(String token, String eventId) async {
    final url = Uri.parse('${AppConfig.baseUrl}/attendance/checkin');

    try {
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

      if (response.statusCode == 200 || response.statusCode == 201) {
        final responseData = json.decode(response.body);
        return responseData['data']['nombre'];
      } else if (response.statusCode == 400) {
        try {
          final errorData = json.decode(response.body);
          final message = errorData['message'] ?? 'Datos inválidos';
          throw Exception('Error de validación: $message');
        } catch (e) {
          throw Exception('Error de validación: Verifica los datos ingresados');
        }
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado: Tu sesión ha expirado');
      } else if (response.statusCode == 403) {
        throw Exception('No tienes permisos para crear eventos');
      } else if (response.statusCode == 500) {
        throw Exception('Error del servidor: Intenta más tarde');
      } else {
        throw Exception('Error al crear evento (${response.statusCode})');
      }
    } on http.ClientException {
      throw Exception('Sin conexión a internet');
    } catch (e) {
      if (e.toString().startsWith('Exception:')) {
        rethrow;
      }
      throw Exception('Error inesperado: ${e.toString()}');
    }
  }
}
