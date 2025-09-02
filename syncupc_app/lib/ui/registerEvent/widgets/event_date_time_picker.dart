import 'register_event_exports.dart';

class EventDateTimePicker extends StatelessWidget {
  final DateTime? selectedDate;
  final String? startTime;
  final String? endTime;
  final Function(DateTime?) onDateChanged;
  final Function(String?) onStartTimeChanged;
  final Function(String?) onEndTimeChanged;

  const EventDateTimePicker({
    super.key,
    required this.selectedDate,
    required this.startTime,
    required this.endTime,
    required this.onDateChanged,
    required this.onStartTimeChanged,
    required this.onEndTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final timeOptions = [
      '8:00 AM',
      '9:00 AM',
      '10:00 AM',
      '11:00 AM',
      '12:00 PM',
      '1:00 PM',
      '2:00 PM',
      '3:00 PM',
      '4:00 PM',
      '5:00 PM',
      '6:00 PM',
      '7:00 PM',
    ];

    return Column(
      children: [
        // Fecha
        SectionTitle("Selecciona la fecha"),
        Padding(
          padding: const EdgeInsets.all(12),
          child: GestureDetector(
            onTap: () async {
              final pickedDate = await showDatePicker(
                context: context,
                initialDate: selectedDate ?? DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(2100),
                locale: const Locale('es', ''),
              );
              if (pickedDate != null) {
                onDateChanged(pickedDate);
              }
            },
            child: AbsorbPointer(
              child: AppTextField(
                hintText: selectedDate != null
                    ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                    : "Fecha",
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(
                    'assets/images/calendar_event.svg',
                    colorFilter: const ColorFilter.mode(
                      AppColors.neutral800,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // Hora
        SectionTitle("Selecciona la hora"),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              TimeDropdown(
                value: startTime,
                items: timeOptions,
                onChanged: onStartTimeChanged,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: AppText.body2("A"),
              ),
              TimeDropdown(
                value: endTime,
                items: timeOptions,
                onChanged: onEndTimeChanged,
              ),
            ],
          ),
        ),
        SizedBox(height: 40)
      ],
    );
  }
}
