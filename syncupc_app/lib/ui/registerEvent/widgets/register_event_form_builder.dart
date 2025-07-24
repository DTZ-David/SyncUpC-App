import 'package:syncupc/features/registerEvent/controllers/register_event_controller.dart';
import '../widgets/register_event_exports.dart';

class RegisterEventFormBuilder {
  List<Widget> buildFormSections({
    required BuildContext context,
    required TextEditingController titleController,
    required TextEditingController locationController,
    required TextEditingController addressController,
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
    required VoidCallback onCreateEvent,
    required WidgetRef ref,
  }) {
    return [
      _buildHeader(),
      _buildEventImagePicker(selectedImage, onImageSelected),
      _buildBasicInfoForm(
        titleController,
        locationController,
        addressController,
        linkController,
        descriptionController,
        selectedCareers,
        onCareersChanged,
        isVirtual,
        onVirtualChanged,
        requiresRegistration,
        onRegistrationChanged,
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
      _buildPermissionsSection(permissions),
      _buildCreateEventButton(onCreateEvent, ref),
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

  Widget _buildBasicInfoForm(
    TextEditingController titleController,
    TextEditingController locationController,
    TextEditingController addressController,
    TextEditingController linkController,
    TextEditingController descriptionController,
    List<String> selectedCareers,
    Function(List<String>) onCareersChanged,
    bool isVirtual,
    Function(bool) onVirtualChanged,
    bool requiresRegistration,
    Function(bool) onRegistrationChanged,
  ) {
    return EventBasicInfoForm(
      titleController: titleController,
      locationController: locationController,
      addressController: addressController,
      linkController: linkController,
      descriptionController: descriptionController,
      selectedCareers: selectedCareers,
      onCareersChanged: onCareersChanged,
      isVirtual: isVirtual,
      onVirtualChanged: onVirtualChanged,
      requiresRegistration: requiresRegistration,
      onRegistrationChanged: onRegistrationChanged,
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

  Widget _buildPermissionsSection(dynamic permissions) {
    return EventPermissionsSection(
      permissions: permissions,
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
