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
    // Nuevos parámetros
    required String? selectedCampusId,
    required String? selectedSpaceId,
    required List<String> selectedEventTypes,
    required List<String> selectedEventCategories,
  }) {
    // Validación del título
    if (titleController.text.trim().isEmpty) {
      _showError(context, 'El título del evento es obligatorio');
      return false;
    }

    // Validación de campus
    if (selectedCampusId == null || selectedCampusId.isEmpty) {
      _showError(context, 'Debe seleccionar un campus');
      return false;
    }

    // Validación de espacio
    if (selectedSpaceId == null || selectedSpaceId.isEmpty) {
      _showError(context, 'Debe seleccionar un espacio');
      return false;
    }

    // Validación de tipos de evento
    if (selectedEventTypes.isEmpty) {
      _showError(context, 'Debe seleccionar al menos un tipo de evento');
      return false;
    }

    // Validación de categorías
    if (selectedEventCategories.isEmpty) {
      _showError(context, 'Debe seleccionar al menos una categoría');
      return false;
    }

    // Validación de carreras
    if (selectedCareers.isEmpty) {
      _showError(context, 'Debe seleccionar al menos una carrera');
      return false;
    }

    // Validación de audiencia
    if (!allowProfessors &&
        !allowStudents &&
        !allowGraduates &&
        !allowGeneralPublic) {
      _showError(context, 'Debe seleccionar al menos un tipo de audiencia');
      return false;
    }

    // Validación de fecha
    if (selectedDate == null) {
      _showError(context, 'Debe seleccionar una fecha para el evento');
      return false;
    }

    // Validación de horarios
    if (startTime == null || endTime == null) {
      _showError(context, 'Debe seleccionar hora de inicio y fin');
      return false;
    }

    // Validación de que la hora de fin no sea anterior a la de inicio
    if (!_isEndTimeValid(startTime, endTime)) {
      _showError(context, 'La hora de fin debe ser posterior a la hora de inicio');
      return false;
    }

    // Validación de fecha futura
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final eventDate =
        DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    if (eventDate.isBefore(today)) {
      _showError(context, 'La fecha del evento no puede ser en el pasado');
      return false;
    }

    // Validación de link para eventos virtuales
    if (isVirtual && linkController.text.trim().isEmpty) {
      _showError(context, 'Debe proporcionar un enlace para eventos virtuales');
      return false;
    }

    // Validación de descripción
    if (descriptionController.text.trim().isEmpty) {
      _showError(context, 'La descripción del evento es obligatoria');
      return false;
    }

    return true;
  }

  bool _isEndTimeValid(String startTime, String endTime) {
    // Convertir las horas a un formato comparable
    final startHour = _convertTo24Hour(startTime);
    final endHour = _convertTo24Hour(endTime);

    return endHour > startHour;
  }

  int _convertTo24Hour(String time) {
    // Formato: "8:00 AM" o "1:00 PM"
    final parts = time.split(' ');
    final timeParts = parts[0].split(':');
    final hour = int.parse(timeParts[0]);
    final isPM = parts[1] == 'PM';

    if (isPM && hour != 12) {
      return hour + 12;
    } else if (!isPM && hour == 12) {
      return 0;
    }
    return hour;
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
