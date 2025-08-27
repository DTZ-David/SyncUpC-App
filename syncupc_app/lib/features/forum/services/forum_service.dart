import 'package:syncupc/config/constants/app.dart';
import 'package:http/http.dart' as http;
import 'package:syncupc/features/forum/models/comment_request_model.dart';
import 'dart:convert';

import '../models/forum_model.dart';
import '../models/forum_request_model.dart';

class ForumService {
  Future<List<ForumModel>> getForum(String token, String eventId) async {
    final url = Uri.parse('${AppConfig.baseUrl}/forum/getalltopicsforevent');

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
        final jsonData = json.decode(response.body);
        final List eventData = jsonData['data'];

        return eventData.map((e) => ForumModel.fromJson(e)).toList();
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

  Future<void> registerTopic(String token, ForumRequest forumRequest) async {
    final url = Uri.parse('${AppConfig.baseUrl}/forum/addtopic');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(forumRequest.toJson()),
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

  Future<void> addComment(String token, CommentRequest commentRequest) async {
    final url = Uri.parse('${AppConfig.baseUrl}/forum/addcomment');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(commentRequest.toJson()),
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

  Future<ForumModel> getForumById(String token, String forumId) async {
    final url = Uri.parse('${AppConfig.baseUrl}/forum/getforumbyid');

    try {
      final response = await http.post(
        url,
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          "forumId": forumId,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final jsonData = json.decode(response.body);
        final data = jsonData['data'];

        return ForumModel.fromJson(data);
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
