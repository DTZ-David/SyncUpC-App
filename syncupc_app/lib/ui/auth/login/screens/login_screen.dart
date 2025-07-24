import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';
import 'package:syncupc/features/auth/controllers/login_controller.dart';
import 'package:syncupc/utils/popup_utils.dart'; // Asegúrate de importar esto

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(loginControllerProvider);

    ref.listen(loginControllerProvider, (previous, current) {
      if (current.errorMessage != null &&
          current.errorMessage != previous?.errorMessage &&
          !current.isLoading) {
        PopupUtils.showError(
          context,
          message: current.errorMessage!,
          subtitle: 'Intenta de nuevo',
        );

        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(loginControllerProvider.notifier).clearError();
        });
      }

      if (current.isAuthenticated &&
          current.isAuthenticated != previous?.isAuthenticated) {
        context.go('/');
      }
    });

    void handleLogin() {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        PopupUtils.showWarning(
          context,
          message: 'Campos vacíos',
          subtitle: 'Por favor completa todos los campos',
        );
        return;
      }

      ref.read(loginControllerProvider.notifier).login(email, password);
    }

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 140),
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 80,
              height: 80,
              fit: BoxFit.contain,
              colorFilter:
                  ColorFilter.mode(AppColors.primary500, BlendMode.srcIn),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 60, bottom: 30),
              child: AppText.heading1(
                "Iniciar Sesión",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppTextField(
                labelText:
                    "Escribe aqui tu email              | @unicesar.edu.co",
                controller: _emailController,
                enabled: !authState.isLoading,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppTextField(
                labelText: "Contraseña",
                controller: _passwordController,
                enabled: !authState.isLoading,
                obscureText: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 200),
              child: AppText.forgotPassword("¿Olvidaste tu contraseña?"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 12, right: 12),
              child: PrimaryButton(
                text: "Iniciar Sesión",
                variant: ButtonVariant.filled,
                isLoading: authState.isLoading,
                onPressed: handleLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
