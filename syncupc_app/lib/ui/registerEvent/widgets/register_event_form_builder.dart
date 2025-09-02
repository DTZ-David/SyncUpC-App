import 'package:syncupc/features/registerEvent/controllers/register_event_controller.dart';
import '../widgets/register_event_exports.dart';
import 'event_location_selector.dart';
import 'event_type_selector.dart';

class RegisterEventFormBuilder {
  List<Widget> buildFormSections({
    required BuildContext context,
    required TextEditingController titleController,
    required TextEditingController linkController,
    required TextEditingController descriptionController,
    required File? selectedImage,
    required List<String> selectedCareers,
    required DateTime? selectedDate,
    required String? startTime,
    required String? endTime,
    required bool isVirtual,
    required bool requiresRegistration,
    required bool allowProfessors,
    required bool allowStudents,
    required bool allowGraduates,
    required bool allowGeneralPublic,
    // Nuevos parámetros
    required String? selectedCampusId,
    required String? selectedSpaceId,
    required List<String> selectedEventTypes,
    required List<String> selectedEventCategories,
    required int? maxCapacity,
    required bool isPublic,
    required dynamic permissions,
    required Function(File?) onImageSelected,
    required Function(List<String>) onCareersChanged,
    required Function(DateTime?) onDateChanged,
    required Function(String?) onStartTimeChanged,
    required Function(String?) onEndTimeChanged,
    required Function(bool) onVirtualChanged,
    required Function(bool) onRegistrationChanged,
    required Function(bool) onProfessorsChanged,
    required Function(bool) onStudentsChanged,
    required Function(bool) onGraduatesChanged,
    required Function(bool) onGeneralPublicChanged,
    // Nuevos callbacks
    required Function(String?) onCampusChanged,
    required Function(String?) onSpaceChanged,
    required Function(List<String>) onEventTypesChanged,
    required Function(List<String>) onEventCategoriesChanged,
    required Function(int?) onMaxCapacityChanged,
    required Function(bool) onIsPublicChanged,
    required VoidCallback onCreateEvent,
    required WidgetRef ref,
  }) {
    return [
      _buildHeader(),
      _buildEventImagePicker(selectedImage, onImageSelected),
      _buildLocationSelector(
        selectedCampusId,
        selectedSpaceId,
        onCampusChanged,
        onSpaceChanged,
      ),
      _buildBasicInfoForm(
        titleController,
        linkController,
        descriptionController,
        selectedCareers,
        onCareersChanged,
        isVirtual,
        onVirtualChanged,
        requiresRegistration,
        onRegistrationChanged,
        maxCapacity,
        onMaxCapacityChanged,
        isPublic,
        onIsPublicChanged,
      ),
      _buildEventTypeSelector(
        selectedEventTypes,
        selectedEventCategories,
        onEventTypesChanged,
        onEventCategoriesChanged,
      ),
      _buildAudienceSelector(
        allowProfessors,
        allowStudents,
        allowGraduates,
        allowGeneralPublic,
        onProfessorsChanged,
        onStudentsChanged,
        onGraduatesChanged,
        onGeneralPublicChanged,
      ),
      _buildDateTimePicker(
        selectedDate,
        startTime,
        endTime,
        onDateChanged,
        onStartTimeChanged,
        onEndTimeChanged,
      ),
      _buildCreateEventButton(onCreateEvent, ref)
    ];
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.only(top: 40, left: 12, right: 12),
      child: AppText.heading1("Registro de eventos"),
    );
  }

  Widget _buildEventImagePicker(
    File? selectedImage,
    Function(File?) onImageSelected,
  ) {
    return EventImagePicker(
      selectedImage: selectedImage,
      onImageSelected: onImageSelected,
    );
  }

  Widget _buildLocationSelector(
    String? selectedCampusId,
    String? selectedSpaceId,
    Function(String?) onCampusChanged,
    Function(String?) onSpaceChanged,
  ) {
    return EventLocationSelector(
      selectedCampusId: selectedCampusId,
      selectedSpaceId: selectedSpaceId,
      onCampusChanged: onCampusChanged,
      onSpaceChanged: onSpaceChanged,
    );
  }

  final maxCapacityController = TextEditingController();

  Widget _buildBasicInfoForm(
    TextEditingController titleController,
    TextEditingController linkController,
    TextEditingController descriptionController,
    List<String> selectedCareers,
    Function(List<String>) onCareersChanged,
    bool isVirtual,
    Function(bool) onVirtualChanged,
    bool requiresRegistration,
    Function(bool) onRegistrationChanged,
    int? maxCapacity,
    Function(int?) onMaxCapacityChanged,
    bool isPublic,
    Function(bool) onIsPublicChanged,
  ) {
    // Actualizar el texto del controller cuando sea necesario
    if (maxCapacityController.text != (maxCapacity?.toString() ?? '')) {
      maxCapacityController.text = maxCapacity?.toString() ?? '';
    }

    return EventBasicInfoForm(
      titleController: titleController,
      linkController: linkController,
      descriptionController: descriptionController,
      maxCapacityController: maxCapacityController, // Pasar el controller
      selectedCareers: selectedCareers,
      onCareersChanged: onCareersChanged,
      isVirtual: isVirtual,
      onVirtualChanged: onVirtualChanged,
      requiresRegistration: requiresRegistration,
      onRegistrationChanged: onRegistrationChanged,
      maxCapacity: maxCapacity,
      onMaxCapacityChanged: onMaxCapacityChanged,
      isPublic: isPublic,
      onIsPublicChanged: onIsPublicChanged,
    );
  }

  Widget _buildEventTypeSelector(
    List<String> selectedEventTypes,
    List<String> selectedEventCategories,
    Function(List<String>) onEventTypesChanged,
    Function(List<String>) onEventCategoriesChanged,
  ) {
    return EventTypeSelector(
      selectedEventTypes: selectedEventTypes,
      selectedEventCategories: selectedEventCategories,
      onEventTypesChanged: onEventTypesChanged,
      onEventCategoriesChanged: onEventCategoriesChanged,
    );
  }

  Widget _buildAudienceSelector(
    bool allowProfessors,
    bool allowStudents,
    bool allowGraduates,
    bool allowGeneralPublic,
    Function(bool) onProfessorsChanged,
    Function(bool) onStudentsChanged,
    Function(bool) onGraduatesChanged,
    Function(bool) onGeneralPublicChanged,
  ) {
    return EventAudienceSelector(
      allowProfessors: allowProfessors,
      allowStudents: allowStudents,
      allowGraduates: allowGraduates,
      allowGeneralPublic: allowGeneralPublic,
      onProfessorsChanged: onProfessorsChanged,
      onStudentsChanged: onStudentsChanged,
      onGraduatesChanged: onGraduatesChanged,
      onGeneralPublicChanged: onGeneralPublicChanged,
    );
  }

  Widget _buildDateTimePicker(
    DateTime? selectedDate,
    String? startTime,
    String? endTime,
    Function(DateTime?) onDateChanged,
    Function(String?) onStartTimeChanged,
    Function(String?) onEndTimeChanged,
  ) {
    return EventDateTimePicker(
      selectedDate: selectedDate,
      startTime: startTime,
      endTime: endTime,
      onDateChanged: onDateChanged,
      onStartTimeChanged: onStartTimeChanged,
      onEndTimeChanged: onEndTimeChanged,
    );
  }

  Widget _buildCreateEventButton(VoidCallback onCreateEvent, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Consumer(
        builder: (context, ref, child) {
          final registerState = ref.watch(registerEventControllerProvider);

          return PrimaryButton(
            text: registerState.isLoading ? "Creando..." : "Crear Evento",
            variant: ButtonVariant.filled,
            onPressed: registerState.isLoading ? null : onCreateEvent,
          );
        },
      ),
    );
  }
}
