import 'register_event_exports.dart';

class EventPermissionsSection extends ConsumerWidget {
  final dynamic permissions; // Reemplaza con el tipo correcto

  const EventPermissionsSection({
    super.key,
    required this.permissions,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final permissionNotifier = ref.read(permissionProvider.notifier);

    return Column(
      children: [
        SectionTitle("Permisos"),
        SwitchTile(
          value: permissions.confirmar,
          label: "Solicitar confirmar entrada/salida",
          onChanged: permissionNotifier.toggleConfirmar,
        ),
      ],
    );
  }
}
