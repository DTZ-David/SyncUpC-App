import '../register_event_exports.dart';
import 'package:syncupc/features/registerEvent/controllers/register_event_controller.dart';

class Step4DateTime extends ConsumerWidget {
  final DateTime? selectedDate;
  final String? startTime;
  final String? endTime;
  final Function(DateTime?) onDateChanged;
  final Function(String?) onStartTimeChanged;
  final Function(String?) onEndTimeChanged;
  final VoidCallback onBack;
  final VoidCallback onCreate;
  final WidgetRef ref;

  const Step4DateTime({
    super.key,
    required this.selectedDate,
    required this.startTime,
    required this.endTime,
    required this.onDateChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
    required this.onBack,
    required this.onCreate,
    required this.ref,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerState = ref.watch(registerEventControllerProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(16),
          child: AppText.heading2(
            'Fecha y Hora del Evento',
          ),
        ),
        EventDateTimePicker(
          selectedDate: selectedDate,
          startTime: startTime,
          endTime: endTime,
          onDateChanged: onDateChanged,
          onStartTimeChanged: onStartTimeChanged,
          onEndTimeChanged: onEndTimeChanged,
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
                  text: registerState.isLoading ? "Creando..." : "Crear Evento",
                  variant: ButtonVariant.filled,
                  onPressed: registerState.isLoading ? null : onCreate,
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
