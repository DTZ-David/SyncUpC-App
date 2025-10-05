// services/auth_service.dart
import 'package:syncupc/config/constants/app.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final url = Uri.parse('${AppConfig.baseUrl}/user/loginapp');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'email': username,
          'password': password,
        }),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('La solicitud tardó demasiado. Verifica tu conexión');
        },
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

  Future<Map<String, dynamic>> refreshAccessToken(String refreshToken) async {
    final url = Uri.parse('${AppConfig.baseUrl}/user/refresh-token');

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'refreshToken': refreshToken}),
    ).timeout(
      const Duration(seconds: 30),
      onTimeout: () {
        throw Exception('La solicitud tardó demasiado. Verifica tu conexión');
      },
    );

    if (response.statusCode == 200) {
      return json.decode(response.body)['data'];
    } else {
      throw Exception('No se pudo refrescar el token');
    }
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
