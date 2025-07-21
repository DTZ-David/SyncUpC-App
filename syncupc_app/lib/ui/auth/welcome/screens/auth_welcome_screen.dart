import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';

class AuthWelcomeScreen extends ConsumerWidget {
  const AuthWelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(children: [
              Container(
                height: 480,
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.primary50),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 140),
                child: Center(
                  child: SvgPicture.asset(
                    'assets/images/upc.svg',
                    width: 288,
                    height: 288,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ]),
            Padding(
                padding: EdgeInsets.all(12),
                child: AppText.heading1(
                  "Una Nueva Forma de Conectar a la Comunidad.",
                  textAlign: TextAlign.center,
                )),
            Padding(
              padding: const EdgeInsets.only(top: 1),
              child: AppText.body1(
                "Conectamos a las personas de una forma más auténtica y significativa.",
                textAlign: TextAlign.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12, top: 20),
              child: PrimaryButton(
                text: "Iniciar Sesión",
                variant: ButtonVariant.filled, // verde
                onPressed: () {
                  context.push('/login');
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: PrimaryButton(
                text: "Registrarse",
                variant: ButtonVariant.outlined, // blanco
                onPressed: () {
                  context.push('/registerEmail');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
