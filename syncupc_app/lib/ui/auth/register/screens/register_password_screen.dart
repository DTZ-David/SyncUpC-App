// ignore_for_file: use_build_context_synchronously

import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';
import 'package:syncupc/utils/loading_screens/loading_dialog_helpers.dart';
import 'package:syncupc/utils/loading_screens/loading_types.dart';

class RegisterPasswordScreen extends ConsumerWidget {
  const RegisterPasswordScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 140),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppText.heading1("Creemos una contraseña unica"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppText(
                  "Usa una combinación de letras, números y símbolos para mayor seguridad."),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppTextField(
                labelText: "Contraseña",
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppTextField(
                labelText: "Confirmar Contraseña",
                suffixIcon: Icon(Icons.remove_red_eye_outlined),
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black87,
                          ),
                      children: [
                        const TextSpan(
                            text:
                                "Recuerda que tu contraseña debe cumplir con ciertos  "),
                        TextSpan(
                          text: "requisitos de seguridad",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                          // Puedes agregar un gestureRecognizer si quieres que sea clickeable
                        ),
                      ],
                    ),
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 12, right: 12),
              child: PrimaryButton(
                text: "Siguiente",
                variant: ButtonVariant.filled,
                onPressed: () async {
                  context.showLoadingDialog(
                    type: LoadingType.custom,
                    title: "¡Vamos a crear tu cuenta!",
                    subtitle:
                        "Solo unos pasos más para empezar a explorar los mejores eventos cerca de ti.",
                  );
                  await Future.delayed(Duration(seconds: 2));
                  context.hideLoadingDialog();

                  // Navegar a siguiente pantalla
                  context.push('/register/step/1');
                },
              ),
            ),
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                child: Align(
                  alignment: Alignment.center,
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black87,
                          ),
                      children: [
                        const TextSpan(
                            text:
                                "Si necesitas más información, la puedes encontrar en nuestra "),
                        TextSpan(
                          text: "Política de Privacidad.",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                          // Puedes agregar un gestureRecognizer si quieres que sea clickeable
                        ),
                      ],
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
