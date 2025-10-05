// ignore_for_file: avoid_print

import 'dart:io';
import 'package:mime/mime.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseStorageService {
  final SupabaseClient _client = Supabase.instance.client;

  /// Sube una imagen a Supabase Storage
  /// [file] es la imagen local
  /// [bucket] debe ser 'profilepictures' o 'eventpictures'
  /// [path] es el nombre/ruta interna del archivo (ej: user_123.jpg)
  Future<String?> uploadImage({
    required File file,
    required String bucket,
    required String path,
  }) async {
    try {
      print('📤 Iniciando upload a Supabase...');
      print('📤 Bucket: $bucket');
      print('📤 Path: $path');
      print('📤 File path: ${file.path}');

      // Verificar que el archivo existe
      if (!await file.exists()) {
        print('❌ Error: El archivo no existe');
        return null;
      }

      final fileBytes = await file.readAsBytes();
      print('📤 Bytes leídos: ${fileBytes.length}');

      final contentType = lookupMimeType(file.path) ?? 'image/jpeg';
      print('📤 Content type: $contentType');

      print('📤 Iniciando upload...');
      await _client.storage.from(bucket).uploadBinary(
            path,
            fileBytes,
            fileOptions: FileOptions(
              contentType: contentType,
              upsert: true, // sobreescribe si ya existe
            ),
          );

      print('✅ Upload completado, obteniendo URL pública...');

      // Retorna la URL pública
      final publicUrl = _client.storage.from(bucket).getPublicUrl(path);
      print('✅ URL pública generada: $publicUrl');

      return publicUrl;
    } catch (e) {
      print('❌ Error completo en upload: $e');
      print('❌ Tipo de error: ${e.runtimeType}');

      // Si es un error específico de Supabase, mostrar más detalles
      if (e is StorageException) {
        print('❌ StorageException - Message: ${e.message}');
        print('❌ StorageException - Status Code: ${e.statusCode}');
      }

      return null;
    }
  }

  /// Elimina una imagen
  Future<bool> deleteImage({
    required String bucket,
    required String path,
  }) async {
    try {
      print('🗑️ Eliminando imagen: $bucket/$path');
      await _client.storage.from(bucket).remove([path]);
      print('✅ Imagen eliminada exitosamente');
      return true;
    } catch (e) {
      print('❌ Error eliminando imagen: $e');
      return false;
    }
  }
}
