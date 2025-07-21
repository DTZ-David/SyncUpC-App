import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:syncupc/config/constants/app.dart';
import 'package:syncupc/features/auth/models/register_user_request.dart';

class RegisterService {
  Future<void> registerUser(RegisterUserRequest request) async {
    final url = Uri.parse('${AppConfig.baseUrl}/user/registerstudent');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(request.toJson()),
      );

      if (response.statusCode == 201 || response.statusCode == 200) {
        // Registro exitoso, podrías devolver datos si el backend los envía
        return;
      } else if (response.statusCode == 400) {
        throw Exception('Datos inválidos. Verifica los campos');
      } else if (response.statusCode == 409) {
        throw Exception('Ya existe un usuario con ese correo');
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint no encontrado');
      } else if (response.statusCode >= 500) {
        throw Exception('Error interno del servidor');
      } else {
        throw Exception('Error desconocido: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('No se pudo conectar al servidor');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error inesperado: $e');
    }
  }
}
