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
    required TextEditingController locationController,
    required TextEditingController addressController,
    required TextEditingController linkController,
    required TextEditingController descriptionController,
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
  }) async {
    final startDateTime = _combineDateAndTime(selectedDate, startTime);
    final endDateTime = _combineDateAndTime(selectedDate, endTime);

    if (endDateTime.isBefore(startDateTime) ||
        endDateTime.isAtSameMomentAs(startDateTime)) {
      _showError(
          context, 'La hora de fin debe ser después de la hora de inicio');
      return;
    }

    final imageUrls = await _uploadEventImage(context, selectedImage);
    if (imageUrls == null) return; // Error ya mostrado en _uploadEventImage

    final eventRequest = _buildEventRequest(
      titleController,
      locationController,
      addressController,
      linkController,
      descriptionController,
      selectedCareers,
      startDateTime,
      endDateTime,
      isVirtual,
      requiresRegistration,
      allowProfessors,
      allowStudents,
      allowGraduates,
      allowGeneralPublic,
      imageUrls,
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
    TextEditingController locationController,
    TextEditingController addressController,
    TextEditingController linkController,
    TextEditingController descriptionController,
    List<String> selectedCareers,
    DateTime startDateTime,
    DateTime endDateTime,
    bool isVirtual,
    bool requiresRegistration,
    bool allowProfessors,
    bool allowStudents,
    bool allowGraduates,
    bool allowGeneralPublic,
    List<String> imageUrls,
  ) {
    return EventRequest(
      eventTitle: titleController.text.trim(),
      eventObjective: descriptionController.text.trim(),
      eventLocation: locationController.text.trim(),
      address: addressController.text.trim(),
      startDate: startDateTime,
      endDate: endDateTime,
      registrationStart: startDateTime,
      registrationEnd: endDateTime,
      careerIds: selectedCareers,
      targetTeachers: allowProfessors,
      targetStudents: allowStudents,
      targetAdministrative: allowGraduates,
      targetGeneral: allowGeneralPublic,
      isVirtual: isVirtual,
      meetingUrl: linkController.text.trim().isEmpty
          ? null
          : linkController.text.trim(),
      maxCapacity: 0,
      requiresRegistration: requiresRegistration,
      isPublic: true,
      tags: [],
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
