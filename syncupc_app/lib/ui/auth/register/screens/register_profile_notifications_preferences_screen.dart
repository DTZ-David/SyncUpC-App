// ignore_for_file: use_build_context_synchronously

import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/features/auth/controllers/register_controller.dart';
import 'package:syncupc/utils/loading_screens/loading_dialog_helpers.dart';
import 'package:syncupc/utils/loading_screens/loading_types.dart';
import '../../../../config/providers/register_providers.dart';
import '../../../../features/auth/providers/register_providers.dart';
import '../../../../utils/popup_utils.dart';

class RegisterProfileNotificationsPreferencesScreen extends ConsumerWidget {
  const RegisterProfileNotificationsPreferencesScreen({super.key});

  int getCurrentStep(BuildContext context) {
    final uri = GoRouterState.of(context).uri.toString();
    if (uri.contains('/step/2')) return 2;
    if (uri.contains('/step/3')) return 3;
    return 1;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentStep = getCurrentStep(context);
    final notifications = ref.watch(notificationsPreferenceProvider);
    final notifier = ref.read(notificationsPreferenceProvider.notifier);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 100),
            Center(
              child: StepIndicator(
                currentStep: currentStep - 1,
                totalSteps: 3,
              ),
            ),
            const SizedBox(height: 60),
            Center(
              child: AppText.heading1(
                "¿Quieres recibir notificaciones?",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: AppText.body1(
                "Te avisaremos cuando haya eventos nuevos, cambios o recordatorios. Tú decides.",
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 48),

            // Switch controlado por Riverpod
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Switch(
                  value: notifications,
                  onChanged: notifier.set,
                  activeColor: AppColors.primary500,
                ),
                const SizedBox(width: 8),
                AppText.body1("Marca para activar las notificaciones"),
              ],
            ),

            const SizedBox(height: 48),

            Padding(
              padding: const EdgeInsets.all(12),
              child: SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                  text: "Siguiente",
                  variant: ButtonVariant.filled,
                  onPressed: () async {
                    context.showLoadingDialog(type: LoadingType.simple);

                    final formData = ref.read(registerFormProvider);
                    final success = await ref
                        .read(registerControllerProvider.notifier)
                        .register(formData);

                    context.hideLoadingDialog();

                    if (success) {
                      context.go('/login');
                    } else {
                      final error =
                          ref.read(registerControllerProvider).errorMessage ??
                              'Error al registrar';

                      PopupUtils.showError(
                        context,
                        message: error,
                        subtitle: 'Por favor intenta de nuevo',
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
