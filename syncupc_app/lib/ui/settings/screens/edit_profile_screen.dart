import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/atoms/primary_button.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';
import 'package:syncupc/design_system/protons/colors.dart';
import 'package:syncupc/features/auth/controllers/edit_profile_controller.dart';
import 'package:syncupc/features/auth/providers/auth_providers.dart';
import 'package:syncupc/utils/popup_utils.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _phoneController = TextEditingController();

  bool _hasChanges = false;
  File? _profileImage;
  String? _originalPhone;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_checkChanges);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_checkChanges);
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 800,
      maxHeight: 800,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      final file = File(pickedFile.path);
      final fileSize = await file.length();

      // Validar tamaño (máx 5MB)
      if (fileSize > 5 * 1024 * 1024) {
        if (mounted) {
          PopupUtils.showWarning(
            context,
            message: 'Imagen muy grande',
            subtitle: 'El tamaño máximo es 5MB',
          );
        }
        return;
      }

      // Validar formato
      final ext = pickedFile.path.split('.').last.toLowerCase();
      if (!['jpg', 'jpeg', 'png', 'webp'].contains(ext)) {
        if (mounted) {
          PopupUtils.showWarning(
            context,
            message: 'Formato no soportado',
            subtitle: 'Solo se permiten JPG, JPEG, PNG y WEBP',
          );
        }
        return;
      }

      setState(() {
        _profileImage = file;
        _checkChanges();
      });
    }
  }

  void _checkChanges() {
    setState(() {
      _hasChanges = (_phoneController.text.trim() != (_originalPhone ?? '')) ||
          _profileImage != null;
    });
  }

  bool _isValidPhone(String phone) {
    // Formato colombiano: 3XX XXX XXXX (números móviles en Colombia)
    final cleanPhone = phone.replaceAll(RegExp(r'\s'), '');
    // Debe empezar con 3 y tener exactamente 10 dígitos
    return RegExp(r'^3[0-9]{9}$').hasMatch(cleanPhone);
  }

  Future<void> _handleUpdate() async {
    final phone = _phoneController.text.trim();

    // Validar número si no está vacío
    if (phone.isNotEmpty && !_isValidPhone(phone)) {
      PopupUtils.showWarning(
        context,
        message: 'Número inválido',
        subtitle: 'Ingresa un número móvil válido (Ej: 3001234567)',
      );
      return;
    }

    // Actualizar perfil
    await ref.read(editProfileControllerProvider.notifier).updateProfile(
          phoneNumber: phone.isNotEmpty ? phone : null,
          profileImage: _profileImage,
        );
  }

  Widget _buildReadOnlyField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.body2(label),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.neutral100,
              border: Border.all(color: AppColors.neutral300),
              borderRadius: BorderRadius.circular(8),
            ),
            child: AppText(value),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField(String label, TextEditingController controller,
      {String? hint}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText.body2(label),
          const SizedBox(height: 4),
          AppTextField(
            controller: controller,
            labelText: hint,
            keyboardType: TextInputType.phone,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final editState = ref.watch(editProfileControllerProvider);

    // Listener para manejar estados
    ref.listen(editProfileControllerProvider, (previous, current) {
      if (current.errorMessage != null) {
        PopupUtils.showError(
          context,
          message: current.errorMessage!,
          subtitle: 'Intenta de nuevo',
        );
        // Limpiar error después de mostrarlo
        Future.microtask(() {
          ref.read(editProfileControllerProvider.notifier).clearState();
        });
      }

      if (current.isSuccess && !current.isLoading) {
        PopupUtils.showSuccess(
          context,
          message: 'Perfil actualizado',
          subtitle: 'Los cambios se guardaron correctamente',
        );

        // Resetear estado local
        setState(() {
          _hasChanges = false;
          _profileImage = null;
          _originalPhone = _phoneController.text.trim();
        });

        // Limpiar estado del controller
        Future.microtask(() {
          ref.read(editProfileControllerProvider.notifier).clearState();
        });
      }
    });

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editar perfil"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 80),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 24),

                  // Avatar con opción de cambiar imagen
                  GestureDetector(
                    onTap: _pickProfileImage,
                    child: Stack(
                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: AppColors.neutral200,
                          backgroundImage: _profileImage != null
                              ? FileImage(_profileImage!)
                              : (user.photo.isNotEmpty
                                  ? NetworkImage(user.photo)
                                  : null),
                          child: _profileImage == null && user.photo.isEmpty
                              ? SvgPicture.asset('assets/images/camera.svg',
                                  height: 32)
                              : null,
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary500,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),
                  AppText.body2("Toca para cambiar foto",
                      color: AppColors.neutral700),
                  const SizedBox(height: 24),

                  // Campos de solo lectura
                  _buildReadOnlyField("Nombre", user.name),
                  _buildReadOnlyField("Rol", user.role),

                  // Campo editable
                  _buildEditableField(
                    "Número de teléfono",
                    _phoneController,
                    hint: "Ej: 3001234567",
                  ),

                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppText.body2(
                      "Solo puedes editar tu número de teléfono y foto de perfil",
                      color: AppColors.neutral600,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Botón flotante de actualizar
          if (_hasChanges)
            Positioned(
              left: 16,
              right: 16,
              bottom: 16,
              child: PrimaryButton(
                variant: ButtonVariant.filled,
                text: "Actualizar",
                isLoading: editState.isLoading,
                onPressed: editState.isLoading ? null : _handleUpdate,
              ),
            ),
        ],
      ),
    );
  }
}
