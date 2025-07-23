import 'register_event_exports.dart';

class EventAudienceSelector extends StatelessWidget {
  final bool allowProfessors;
  final bool allowStudents;
  final bool allowGraduates;
  final bool allowGeneralPublic;
  final Function(bool) onProfessorsChanged;
  final Function(bool) onStudentsChanged;
  final Function(bool) onGraduatesChanged;
  final Function(bool) onGeneralPublicChanged;

  const EventAudienceSelector({
    super.key,
    required this.allowProfessors,
    required this.allowStudents,
    required this.allowGraduates,
    required this.allowGeneralPublic,
    required this.onProfessorsChanged,
    required this.onStudentsChanged,
    required this.onGraduatesChanged,
    required this.onGeneralPublicChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SectionTitle("Publico"),
        SwitchTile(
          value: allowProfessors,
          label: "Profesores",
          onChanged: onProfessorsChanged,
        ),
        SwitchTile(
          value: allowStudents,
          label: "Estudiantes",
          onChanged: onStudentsChanged,
        ),
        SwitchTile(
          value: allowGraduates,
          label: "Egresados",
          onChanged: onGraduatesChanged,
        ),
        SwitchTile(
          value: allowGeneralPublic,
          label: "Publico General",
          onChanged: onGeneralPublicChanged,
        ),
      ],
    );
  }
}
