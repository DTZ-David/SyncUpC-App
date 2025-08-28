import 'package:syncupc/config/constants/app.dart';
import 'package:http/http.dart' as http;
import 'package:syncupc/features/home/models/category_request.dart';
import 'dart:convert';

class EventCategoryService {
  Future<List<EventCategoryRequest>> getAllCategories(String token) async {
    final url = Uri.parse('${AppConfig.baseUrl}/event/getalleventcategories');

    try {
      final response = await http.get(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        final List eventData = jsonData['data'];

        return eventData.map((e) => EventCategoryRequest.fromJson(e)).toList();
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
