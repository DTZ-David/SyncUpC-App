import 'package:syncupc/features/registerEvent/controllers/register_event_controller.dart';
import 'package:syncupc/features/registerEvent/models/event_request.dart';
import 'package:syncupc/utils/popup_utils.dart';
import '../../../utils/upload_image.dart';
import 'register_event_exports.dart';

class RegisterEventService {
  Future<void> createEvent({
    required BuildContext context,
    required WidgetRef ref,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required TextEditingController linkController,
    required File? selectedImage,
    required List<String> selectedCareers,
    required DateTime selectedDate,
    required String startTime,
    required String endTime,
    required bool isVirtual,
    required bool requiresRegistration,
    required bool allowProfessors,
    required bool allowStudents,
    required bool allowGraduates,
    required bool allowGeneralPublic,
    // Nuevos parámetros requeridos
    required String selectedCampusId,
    required String selectedSpaceId,
    required List<String> selectedEventTypes,
    required List<String> selectedEventCategories,
    // Parámetros opcionales
    int? maxCapacity,
    bool isPublic = true,
  }) async {
    final startDateTime = _combineDateAndTime(selectedDate, startTime);
    final endDateTime = _combineDateAndTime(selectedDate, endTime);

    if (endDateTime.isBefore(startDateTime) ||
        endDateTime.isAtSameMomentAs(startDateTime)) {
      _showError(
          context, 'La hora de fin debe ser después de la hora de inicio');
      return;
    }

    // Validaciones adicionales para los nuevos campos
    if (selectedCampusId.isEmpty) {
      _showError(context, 'Debe seleccionar un campus');
      return;
    }

    if (selectedSpaceId.isEmpty) {
      _showError(context, 'Debe seleccionar un espacio');
      return;
    }

    if (selectedEventTypes.isEmpty) {
      _showError(context, 'Debe seleccionar al menos un tipo de evento');
      return;
    }

    if (selectedEventCategories.isEmpty) {
      _showError(context, 'Debe seleccionar al menos una categoría');
      return;
    }

    final imageUrls = await _uploadEventImage(context, selectedImage);
    if (imageUrls == null) return; // Error ya mostrado en _uploadEventImage

    final eventRequest = _buildEventRequest(
      titleController,
      descriptionController,
      linkController,
      selectedCareers,
      startDateTime,
      endDateTime,
      isVirtual,
      requiresRegistration,
      allowProfessors,
      allowStudents,
      allowGraduates,
      allowGeneralPublic,
      selectedCampusId,
      selectedSpaceId,
      selectedEventTypes,
      selectedEventCategories,
      imageUrls,
      maxCapacity ?? 0,
      isPublic,
    );

    final controller = ref.read(registerEventControllerProvider.notifier);
    await controller.registerEvent(eventRequest);

    // if (requiresRegistration && eventId != null && eventId.isNotEmpty) {
    //   // await showDialog(
    //   //   context: context,
    //   //   barrierDismissible: false, // ← Para que no se cierre tocando fuera
    //   //   builder: (_) => QrPopupDialog(eventId: eventId),
    //   // );
    //   return;
    // } else {
    //   _showError(context, 'No se pudo crear el evento. Intenta nuevamente.');
    //   return;
    // }
  }

  DateTime _combineDateAndTime(DateTime date, String time) {
    final timeParts = time.split(RegExp(r'[:\s]'));
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);
    final isPM = timeParts[2].toLowerCase() == 'pm';

    if (isPM && hour != 12) hour += 12;
    if (!isPM && hour == 12) hour = 0;

    return DateTime(date.year, date.month, date.day, hour, minute);
  }

  Future<List<String>?> _uploadEventImage(
    BuildContext context,
    File? selectedImage,
  ) async {
    List<String> imageUrls = [];

    if (selectedImage != null) {
      final storageService = SupabaseStorageService();
      final path = 'event_${DateTime.now().millisecondsSinceEpoch}.jpg';

      final imageUrl = await storageService.uploadImage(
        file: selectedImage,
        bucket: 'eventpictures',
        path: path,
      );

      if (imageUrl != null) {
        imageUrls.add(imageUrl);
      } else {
        _showError(context, 'No se pudo subir la imagen del evento');
        return null;
      }
    }

    return imageUrls;
  }

  EventRequest _buildEventRequest(
    TextEditingController titleController,
    TextEditingController descriptionController,
    TextEditingController linkController,
    List<String> selectedCareers,
    DateTime startDateTime,
    DateTime endDateTime,
    bool isVirtual,
    bool requiresRegistration,
    bool allowProfessors,
    bool allowStudents,
    bool allowGraduates,
    bool allowGeneralPublic,
    String selectedCampusId,
    String selectedSpaceId,
    List<String> selectedEventTypes,
    List<String> selectedEventCategories,
    List<String> imageUrls,
    int maxCapacity,
    bool isPublic,
  ) {
    return EventRequest(
      eventTitle: titleController.text.trim(),
      eventObjective: descriptionController.text.trim(),
      campusId: selectedCampusId,
      spaceId: selectedSpaceId,
      startDate: startDateTime,
      endDate: endDateTime,
      careerIds: selectedCareers,
      targetTeachers: allowProfessors,
      targetStudents: allowStudents,
      targetAdministrative: allowGraduates,
      targetGeneral: allowGeneralPublic,
      isVirtual: isVirtual,
      meetingUrl: linkController.text.trim().isEmpty
          ? null
          : linkController.text.trim(),
      maxCapacity: maxCapacity,
      requiresRegistration: requiresRegistration,
      isPublic: isPublic,
      eventTypesId: selectedEventTypes,
      eventCategoryId: selectedEventCategories,
      imageUrls: imageUrls,
      additionalDetails: null,
    );
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
