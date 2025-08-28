import 'multi_career_selection.dart';
import 'register_event_exports.dart';

class EventBasicInfoForm extends ConsumerWidget {
  final TextEditingController titleController;
  final TextEditingController linkController;
  final TextEditingController descriptionController;
  final List<String> selectedCareers;
  final Function(List<String>) onCareersChanged;
  final bool isVirtual;
  final Function(bool) onVirtualChanged;
  final bool requiresRegistration;
  final Function(bool) onRegistrationChanged;
  // Nuevos parámetros
  final int? maxCapacity;
  final Function(int?) onMaxCapacityChanged;
  final bool isPublic;
  final Function(bool) onIsPublicChanged;

  const EventBasicInfoForm({
    super.key,
    required this.titleController,
    required this.linkController,
    required this.descriptionController,
    required this.selectedCareers,
    required this.onCareersChanged,
    required this.isVirtual,
    required this.onVirtualChanged,
    required this.requiresRegistration,
    required this.onRegistrationChanged,
    required this.maxCapacity,
    required this.onMaxCapacityChanged,
    required this.isPublic,
    required this.onIsPublicChanged,
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

        // Capacidad máxima
        SectionTitle("Capacidad máxima"),
        Padding(
          padding: const EdgeInsets.all(12),
          child: AppTextField(
            controller: TextEditingController(
              text: maxCapacity?.toString() ?? '',
            ),
            hintText: "Número máximo de participantes (0 = sin límite)",
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final capacity = int.tryParse(value);
              onMaxCapacityChanged(capacity);
            },
          ),
        ),

        // Evento público
        SwitchTile(
          value: isPublic,
          label: "¿Evento Público?",
          //subtitle: "Los eventos públicos son visibles para todos los usuarios",
          onChanged: onIsPublicChanged,
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
