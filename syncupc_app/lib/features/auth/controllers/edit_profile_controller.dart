import 'dart:io';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/auth/controllers/login_controller.dart';
import 'package:syncupc/features/auth/models/user.dart';
import 'package:syncupc/features/auth/services/user_update_service.dart';
import 'package:syncupc/utils/upload_image.dart';

part 'edit_profile_controller.g.dart';

@riverpod
class EditProfileController extends _$EditProfileController {
  late final UserUpdateService _userUpdateService;
  late final SupabaseStorageService _storageService;

  @override
  EditProfileState build() {
    _userUpdateService = UserUpdateService();
    _storageService = SupabaseStorageService();
    return EditProfileState();
  }

  Future<void> updateProfile({
    String? phoneNumber,
    File? profileImage,
  }) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      // Obtener datos del usuario actual
      final authState = ref.read(loginControllerProvider);
      final user = authState.user;

      if (user == null || user.token.isEmpty) {
        throw Exception('Usuario no autenticado');
      }

      String? imageUrl;

      // Subir imagen a Supabase si hay una nueva
      if (profileImage != null) {
        print('🖼️ Iniciando subida de imagen...');
        print('🖼️ Archivo existe: ${await profileImage.exists()}');
        print('🖼️ Tamaño del archivo: ${await profileImage.length()} bytes');

        // Usar el nombre del usuario como ID para la imagen (sanitizado)
        final sanitizedName = user.name
            .replaceAll(' ', '_') // Espacios por guiones bajos
            .replaceAll(
                RegExp(r'[^a-zA-Z0-9_-]'), '') // Solo letras, números, _ y -
            .toLowerCase(); // Minúsculas para consistencia
        final imagePath =
            '${sanitizedName}_${DateTime.now().millisecondsSinceEpoch}.jpg';
        print('🖼️ Path de destino: $imagePath');
        print('🖼️ Bucket: profilepictures');

        imageUrl = await _storageService.uploadImage(
          file: profileImage,
          bucket: 'profilepictures',
          path: imagePath,
        );

        print('🖼️ Resultado de subida: $imageUrl');

        if (imageUrl == null) {
          print('❌ Error: imageUrl es null');
          throw Exception('Error al subir la imagen');
        } else {
          print('✅ Imagen subida exitosamente: $imageUrl');
        }
      }

      // Actualizar en el backend
      await _userUpdateService.updateUser(
        token: user.token,
        profilePicture: imageUrl, // Solo se envía si hay nueva imagen
        phoneNumber: phoneNumber, // Solo se envía si hay nuevo número
      );

      // Si la imagen se actualizó, actualizar los datos locales
      if (imageUrl != null) {
        // Crear usuario actualizado con nueva foto
        final updatedUser = User(
          name: user.name,
          photo: imageUrl,
          token: user.token,
          refreshToken: user.refreshToken,
          role: user.role,
        );

        // Actualizar el estado del LoginController
        ref.read(loginControllerProvider.notifier).updateUserData(updatedUser);
      }

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
    }
  }

  void clearState() {
    state = EditProfileState();
  }
}

class EditProfileState {
  final bool isLoading;
  final String? errorMessage;
  final bool isSuccess;

  EditProfileState({
    this.isLoading = false,
    this.errorMessage,
    this.isSuccess = false,
  });

  EditProfileState copyWith({
    bool? isLoading,
    String? errorMessage,
    bool? isSuccess,
  }) {
    return EditProfileState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
