import '../register_event_exports.dart';

class Step3Details extends ConsumerWidget {
  final List<String> selectedCareers;
  final bool allowProfessors;
  final bool allowStudents;
  final bool allowGraduates;
  final bool allowGeneralPublic;
  final bool isVirtual;
  final TextEditingController linkController;
  final bool requiresRegistration;
  final int? maxCapacity;
  final bool isPublic;
  final Function(List<String>) onCareersChanged;
  final Function(bool) onProfessorsChanged;
  final Function(bool) onStudentsChanged;
  final Function(bool) onGraduatesChanged;
  final Function(bool) onGeneralPublicChanged;
  final Function(bool) onVirtualChanged;
  final Function(bool) onRegistrationChanged;
  final Function(int?) onMaxCapacityChanged;
  final Function(bool) onIsPublicChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step3Details({
    super.key,
    required this.selectedCareers,
    required this.allowProfessors,
    required this.allowStudents,
    required this.allowGraduates,
    required this.allowGeneralPublic,
    required this.isVirtual,
    required this.linkController,
    required this.requiresRegistration,
    required this.maxCapacity,
    required this.isPublic,
    required this.onCareersChanged,
    required this.onProfessorsChanged,
    required this.onStudentsChanged,
    required this.onGraduatesChanged,
    required this.onGeneralPublicChanged,
    required this.onVirtualChanged,
    required this.onRegistrationChanged,
    required this.onMaxCapacityChanged,
    required this.onIsPublicChanged,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: AppText.heading2(
            'Detalles del Evento',
          ),
        ),

        // Carreras
        SectionTitle('Carreras dirigidas *'),
        MultiCareerSelector(
          selectedCareers: selectedCareers,
          onCareersChanged: onCareersChanged,
        ),

        const SizedBox(height: 24),

        // Audiencia
        EventAudienceSelector(
          allowProfessors: allowProfessors,
          allowStudents: allowStudents,
          allowGraduates: allowGraduates,
          allowGeneralPublic: allowGeneralPublic,
          onProfessorsChanged: onProfessorsChanged,
          onStudentsChanged: onStudentsChanged,
          onGraduatesChanged: onGraduatesChanged,
          onGeneralPublicChanged: onGeneralPublicChanged,
        ),

        const SizedBox(height: 24),

        // Virtual
        SectionTitle('Modalidad del evento'),
        SwitchTile(
          label: "¿Evento Virtual?",
          value: isVirtual,
          onChanged: onVirtualChanged,
        ),

        if (isVirtual) ...[
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: AppTextField(
              controller: linkController,
              labelText: 'Link del evento virtual',
            ),
          ),
        ],

        const SizedBox(height: 24),

        // Registro
        SwitchTile(
          label: "¿Requiere Registro?",
          value: requiresRegistration,
          onChanged: onRegistrationChanged,
        ),

        const SizedBox(height: 16),

        // Público
        SwitchTile(
          label: "¿Evento Público?",
          value: isPublic,
          onChanged: onIsPublicChanged,
        ),

        const SizedBox(height: 24),

        // Capacidad
        SectionTitle('Capacidad máxima'),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: AppTextField(
            labelText: 'Número máximo de participantes (0 = sin límite)',
            keyboardType: TextInputType.number,
            onChanged: (value) {
              final capacity = int.tryParse(value);
              onMaxCapacityChanged(capacity);
            },
          ),
        ),

        const SizedBox(height: 40),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: PrimaryButton(
                  text: 'Atrás',
                  variant: ButtonVariant.outlined,
                  onPressed: onBack,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 2,
                child: PrimaryButton(
                  text: 'Siguiente',
                  variant: ButtonVariant.filled,
                  onPressed: onNext,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
