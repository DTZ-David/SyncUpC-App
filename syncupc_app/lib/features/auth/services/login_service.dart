// services/auth_service.dart
import 'package:syncupc/config/constants/app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('${AppConfig.baseUrl}/user/loginapp');
    username = "hector.castano@unicesar.edu.co";
    password = "dtz12345";
    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': username,
          'password': password,
        }),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = json.decode(response.body);
        return responseData;
      } else if (response.statusCode == 401) {
        throw Exception('Credenciales incorrectas');
      } else if (response.statusCode == 404) {
        throw Exception('Servicio no encontrado');
      } else if (response.statusCode >= 500) {
        throw Exception('Error del servidor');
      } else {
        throw Exception('Error desconocido: ${response.statusCode}');
      }
    } on http.ClientException {
      throw Exception('Sin conexión a internet');
    } catch (e) {
      if (e is Exception) rethrow;
      throw Exception('Error inesperado: $e');
    }
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
