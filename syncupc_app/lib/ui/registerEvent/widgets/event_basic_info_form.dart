import 'multi_career_selection.dart';
import 'register_event_exports.dart';

class EventBasicInfoForm extends ConsumerWidget {
  final TextEditingController titleController;
  final TextEditingController locationController;
  final TextEditingController addressController;
  final TextEditingController linkController;
  final TextEditingController descriptionController;
  final List<String> selectedCareers; // Cambiado a List
  final Function(List<String>) onCareersChanged; // Cambiado para recibir lista
  final bool isVirtual;
  final Function(bool) onVirtualChanged;
  final bool requiresRegistration;
  final Function(bool) onRegistrationChanged;

  const EventBasicInfoForm({
    super.key,
    required this.titleController,
    required this.locationController,
    required this.addressController,
    required this.linkController,
    required this.descriptionController,
    required this.selectedCareers,
    required this.onCareersChanged,
    required this.isVirtual,
    required this.onVirtualChanged,
    required this.requiresRegistration,
    required this.onRegistrationChanged,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        // Título
        SectionTitle("Titulo del evento"),
        Padding(
          padding: const EdgeInsets.all(12),
          child: AppTextField(
            controller: titleController,
            hintText: "Escribe aqui",
          ),
        ),

        // Ubicación
        SectionTitle("Ubicación del evento"),
        Padding(
          padding: const EdgeInsets.all(12),
          child: AppTextField(
            controller: locationController,
            hintText: "Ubicacion",
          ),
        ),

        // Dirección
        SectionTitle("Dirección"),
        Padding(
          padding: const EdgeInsets.all(12),
          child: AppTextField(
            controller: addressController,
            hintText: "Ubicacion",
          ),
        ),

        // Selector múltiple de carreras
        MultiCareerSelector(
          selectedCareers: selectedCareers,
          onCareersChanged: onCareersChanged,
        ),

        // Virtual
        SwitchTile(
          value: isVirtual,
          label: "¿Es Virtual?",
          onChanged: onVirtualChanged,
        ),

        // Link de sesión
        if (isVirtual)
          Padding(
            padding: const EdgeInsets.all(12),
            child: AppTextField(
              controller: linkController,
              hintText: "Enlace de la sesión",
            ),
          ),

        // Requiere registro
        SwitchTile(
          value: requiresRegistration,
          label: "¿Requiere Registro?",
          onChanged: onRegistrationChanged,
        ),

        // Descripción
        SectionTitle("Descripción del evento"),
        Padding(
          padding: const EdgeInsets.all(12),
          child: AppTextField(
            controller: descriptionController,
            hintText: "Describe el evento...",
            maxLines: 6,
            keyboardType: TextInputType.multiline,
          ),
        ),
      ],
    );
  }
}
