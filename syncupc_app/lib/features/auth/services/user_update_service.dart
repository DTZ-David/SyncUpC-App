import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:syncupc/config/constants/app.dart';

class UserUpdateService {
  static const String _baseUrl = '${AppConfig.baseUrl}/user'; // Sin /api

  Future<Map<String, dynamic>> updateUser({
    required String token,
    String? profilePicture,
    String? name,
    String? email,
    String? phoneNumber,
  }) async {
    final url = Uri.parse('$_baseUrl/updateuser');

    final body = <String, dynamic>{};

    // Solo agregar campos que no son null
    if (profilePicture != null) body['profilePicture'] = profilePicture;
    if (name != null) body['name'] = name;
    if (email != null) body['email'] = email;
    if (phoneNumber != null) body['phoneNumber'] = phoneNumber;

    print('🔗 URL del request: $url');
    print('🔗 Body: ${jsonEncode(body)}');
    print('🔗 Token: ${token.substring(0, 20)}...');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      ).timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          throw Exception('La solicitud tardó demasiado. Verifica tu conexión');
        },
      );

      print('🔗 Response status: ${response.statusCode}');
      print('🔗 Response body: ${response.body}');

      // Verificar códigos de éxito
      if (response.statusCode == 200 || response.statusCode == 204) {
        if (response.body.isNotEmpty) {
          return jsonDecode(response.body);
        } else {
          return {'success': true};
        }
      }
      // Códigos de error específicos
      else if (response.statusCode == 400) {
        try {
          final errorData = jsonDecode(response.body);
          final message = errorData['message'] ?? 'Datos inválidos';
          throw Exception('Error de validación: $message');
        } catch (e) {
          throw Exception('Error de validación: Verifica los datos ingresados');
        }
      } else if (response.statusCode == 401) {
        throw Exception('No autorizado: Tu sesión ha expirado');
      } else if (response.statusCode == 403) {
        throw Exception('No tienes permisos para actualizar perfil');
      } else if (response.statusCode == 404) {
        throw Exception('Endpoint no encontrado: Verifica la URL del servidor');
      } else if (response.statusCode == 500) {
        throw Exception('Error del servidor: Intenta más tarde');
      } else {
        throw Exception('Error al actualizar usuario (${response.statusCode})');
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
