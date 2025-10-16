import '../register_event_exports.dart';
import '../event_location_selector.dart';
import '../event_type_selector.dart';

class Step2LocationType extends StatelessWidget {
  final String? selectedCampusId;
  final String? selectedSpaceId;
  final List<String> selectedEventTypes;
  final List<String> selectedEventCategories;
  final Function(String?) onCampusChanged;
  final Function(String?) onSpaceChanged;
  final Function(List<String>) onEventTypesChanged;
  final Function(List<String>) onEventCategoriesChanged;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const Step2LocationType({
    super.key,
    required this.selectedCampusId,
    required this.selectedSpaceId,
    required this.selectedEventTypes,
    required this.selectedEventCategories,
    required this.onCampusChanged,
    required this.onSpaceChanged,
    required this.onEventTypesChanged,
    required this.onEventCategoriesChanged,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: AppText.heading2(
            'Ubicación y Tipo de Evento',
          ),
        ),

        EventLocationSelector(
          selectedCampusId: selectedCampusId,
          selectedSpaceId: selectedSpaceId,
          onCampusChanged: onCampusChanged,
          onSpaceChanged: onSpaceChanged,
        ),

        const SizedBox(height: 24),

        EventTypeSelector(
          selectedEventTypes: selectedEventTypes,
          selectedEventCategories: selectedEventCategories,
          onEventTypesChanged: onEventTypesChanged,
          onEventCategoriesChanged: onEventCategoriesChanged,
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
