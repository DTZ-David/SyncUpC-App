import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';

class RegisterEmailScreen extends ConsumerWidget {
  const RegisterEmailScreen({super.key});

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
                child: AppText.heading1("Registrate"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppText(
                  "Crea tu cuenta para descubrir y asistir a eventos cerca de ti. Es rápido, fácil y gratuito."),
            ),
            SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppText("Email"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppTextField(
                labelText:
                    "Escribe aqui tu email              | @unicesar.edu.co",
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 12, right: 12),
              child: PrimaryButton(
                text: "Siguiente",
                variant: ButtonVariant.filled,
                onPressed: () {
                  context.push('/registerPassword');
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
                            decoration: TextDecoration.underline,
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
