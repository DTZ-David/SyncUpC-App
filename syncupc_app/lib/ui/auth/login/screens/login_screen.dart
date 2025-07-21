import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';
import 'package:syncupc/features/auth/controllers/login_controller.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({super.key});

  // Controladores como propiedades de la clase
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(loginControllerProvider);

    ref.listen(loginControllerProvider, (previous, current) {
      if (current.errorMessage != null &&
          current.errorMessage != previous?.errorMessage &&
          !current.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppText(current.errorMessage!),
            backgroundColor: AppColors.error,
            duration: const Duration(seconds: 3),
          ),
        );

        WidgetsBinding.instance.addPostFrameCallback((_) {
          ref.read(loginControllerProvider.notifier).clearError();
        });
      }
    });

    void handleLogin() {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      if (email.isEmpty || password.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: AppText('Por favor completa todos los campos'),
            backgroundColor: AppColors.error,
          ),
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
                )),
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
                text: "Iniciar Sesion",
                variant: ButtonVariant.filled,
                isLoading: authState.isLoading, // 🎯 Usar el loading del botón
                onPressed: handleLogin,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
