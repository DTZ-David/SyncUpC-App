import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 140),
            SvgPicture.asset(
              'assets/images/logo.svg',
              width: 80,
              height: 80,
              fit: BoxFit.contain,
              colorFilter:
                  ColorFilter.mode(AppColors.primary500, BlendMode.srcIn),
            ),
            Padding(
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
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppTextField(
                labelText: "Contraseña",
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 200),
              child: AppText.forgotPassword("¿Olvidaste tu contraseña?"),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 12, right: 12),
              child: PrimaryButton(
                text: "Iniciar Sesion",
                variant: ButtonVariant.filled,
                onPressed: () {
                  context.go('/');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
