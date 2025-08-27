import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing_for_provider.dart';
import 'package:syncupc/ui/settings/widgets/settings_option.dart';

import '../../../features/auth/services/user_storage_service.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            // Título principal
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 22, left: 12, right: 12),
                child: AppText(
                  "Configuraciones",
                  style: const TextStyle(
                    fontFamily: 'Nunito',
                    fontWeight: FontWeight.w600,
                    fontSize: 22,
                  ),
                ),
              ),
            ),
            _buildSectionTitle("Cuenta"),
            SettingsOption(
              icon: "assets/images/edit.svg",
              title: 'Editar perfil',
              onTap: () {
                context.push('/edit_profile');
              },
            ),
            SettingsOption(
              icon: "assets/images/lock.svg",
              title: 'Cambiar Contraseña',
              onTap: () {},
            ),
            SettingsOption(
              icon: "assets/images/historial.svg",
              title: 'Historial de participación y certificados',
              onTap: () {
                context.push('/history');
              },
            ),
            _buildSectionTitle("Notificaciones"),
            SettingsOption(
              icon: "assets/images/notifications.svg",
              title: 'Activar/Desactivar notificaciones',
              onTap: () {},
            ),
            SettingsOption(
              icon: "assets/images/clock_settings.svg",
              title: 'Horario Preferido',
              onTap: () {},
            ),
            _buildSectionTitle("Tema de la App"),
            SettingsOption(
              icon: "assets/images/edit.svg",
              title: 'Tema',
              onTap: () {},
            ),
            _buildSectionTitle("Salir"),
            SettingsOption(
              icon: "assets/images/logout.svg",
              title: 'Cerrar Sesión',
              onTap: () async {
                final userStorage = UserStorageService();
                await userStorage.clearUser();
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(top: 22, left: 12, right: 12),
        child: AppText(
          title,
          style: const TextStyle(
            fontFamily: 'Nunito',
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
