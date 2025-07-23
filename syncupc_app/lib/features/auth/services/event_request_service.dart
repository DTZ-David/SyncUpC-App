import 'package:syncupc/config/constants/app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:syncupc/features/auth/models/event_request.dart';

class EventRequestService {
  Future<void> registerEvent(String token, EventRequest eventRequest) async {
    final url = Uri.parse('${AppConfig.baseUrl}/event/createevent');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(eventRequest.toJson()),
      );

      // Verificar códigos de éxito
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Éxito - retornar sin error
        return;
      }
      // Códigos de error específicos
      else if (response.statusCode == 400) {
        // Error de validación
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
        // Error genérico
        throw Exception('Error al crear evento (${response.statusCode})');
      }
    } on http.ClientException {
      throw Exception('Sin conexión a internet');
    } catch (e) {
      // Si ya es una excepción que lanzamos, la re-lanzamos
      if (e.toString().startsWith('Exception:')) {
        rethrow;
      }
      // Si es otro tipo de error, lo envolvemos
      throw Exception('Error inesperado: ${e.toString()}');
    }
  }
}
