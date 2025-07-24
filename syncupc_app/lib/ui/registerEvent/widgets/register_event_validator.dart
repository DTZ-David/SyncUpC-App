import 'package:flutter/material.dart';
import 'package:syncupc/utils/popup_utils.dart';

class RegisterEventValidator {
  bool validateForm({
    required BuildContext context,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required DateTime? selectedDate,
    required String? startTime,
    required String? endTime,
    required List<String> selectedCareers,
    required bool allowProfessors,
    required bool allowStudents,
    required bool allowGraduates,
    required bool allowGeneralPublic,
    required bool isVirtual,
    required TextEditingController linkController,
  }) {
    if (titleController.text.trim().isEmpty) {
      PopupUtils.showError(
        context,
        message: 'El título del evento es obligatorio',
        subtitle: 'Por favor ingresa un título para tu evento',
        duration: const Duration(seconds: 2),
      );
      return false;
    }

    if (descriptionController.text.trim().isEmpty) {
      _showError(context, 'La descripción del evento es obligatoria');
      return false;
    }

    if (selectedDate == null) {
      _showError(context, 'Selecciona la fecha del evento');
      return false;
    }

    if (startTime == null || endTime == null) {
      _showError(context, 'Selecciona la hora de inicio y fin del evento');
      return false;
    }

    if (selectedCareers.isEmpty) {
      _showError(context, 'Selecciona al menos una carrera');
      return false;
    }

    if (!allowProfessors &&
        !allowStudents &&
        !allowGraduates &&
        !allowGeneralPublic) {
      _showError(context, 'Selecciona al menos un tipo de público');
      return false;
    }

    if (isVirtual && linkController.text.trim().isEmpty) {
      _showError(context, 'El enlace es obligatorio para eventos virtuales');
      return false;
    }

    return true;
  }

  void _showError(BuildContext context, String message) {
    PopupUtils.showError(
      context,
      message: message,
      subtitle: 'Por favor revisa la información ingresada',
      duration: const Duration(seconds: 3),
    );
  }
}
