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
    final fileBytes = await file.readAsBytes();
    final contentType = lookupMimeType(file.path) ?? 'image/jpeg';

    try {
      await _client.storage.from(bucket).uploadBinary(
            path,
            fileBytes,
            fileOptions: FileOptions(
              contentType: contentType,
              upsert: true, // sobreescribe si ya existe
            ),
          );

      // Retorna la URL pública
      return _client.storage.from(bucket).getPublicUrl(path);
    } catch (e) {
      print('Error subiendo imagen: $e');
      return null;
    }
  }

  /// Elimina una imagen
  Future<bool> deleteImage({
    required String bucket,
    required String path,
  }) async {
    try {
      await _client.storage.from(bucket).remove([path]);
      return true;
    } catch (e) {
      print('Error eliminando imagen: $e');
      return false;
    }
  }
}
