// ignore_for_file: use_build_context_synchronously
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';
import 'package:syncupc/features/auth/providers/register_providers.dart';
import 'package:syncupc/utils/loading_screens/loading_dialog_helpers.dart';
import 'package:syncupc/utils/loading_screens/loading_types.dart';

class RegisterPasswordScreen extends ConsumerStatefulWidget {
  const RegisterPasswordScreen({super.key});

  @override
  ConsumerState<RegisterPasswordScreen> createState() =>
      _RegisterPasswordScreenState();
}

class _RegisterPasswordScreenState
    extends ConsumerState<RegisterPasswordScreen> {
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();

  final _passwordRegex = RegExp(r'^(?=.*\d).{8,}$');

  void _showError(String msg) => ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(msg),
          backgroundColor: Colors.red,
        ),
      );

  Future<void> _handleNext() async {
    final pass = _passwordCtrl.text;
    final confirm = _confirmCtrl.text;

    if (pass.isEmpty || confirm.isEmpty) {
      _showError('Completa ambos campos de contraseña.');
      return;
    }

    if (!_passwordRegex.hasMatch(pass)) {
      _showError(
          'La contraseña debe tener mínimo 8 caracteres y al menos un número.');
      return;
    }

    if (pass != confirm) {
      _showError('Las contraseñas no coinciden.');
      return;
    }

    ref.read(registerFormProvider.notifier).setPassword(pass);

    context.showLoadingDialog(
      type: LoadingType.custom,
      title: "¡Vamos a crear tu cuenta!",
      subtitle:
          "Solo unos pasos más para empezar a explorar los mejores eventos cerca de ti.",
    );
    await Future.delayed(const Duration(seconds: 2));
    context.hideLoadingDialog();

    context.push('/register/step/1');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 140),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Align(
                alignment: Alignment.centerLeft,
                child: AppText.heading1("Creemos una contraseña única"),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(12),
              child: AppText(
                "Usa una combinación de letras, números y símbolos para mayor seguridad.",
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppTextField(
                labelText: "Contraseña",
                controller: _passwordCtrl,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AppTextField(
                labelText: "Confirmar contraseña",
                controller: _confirmCtrl,
                obscureText: true,
                keyboardType: TextInputType.visiblePassword,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
              child: PrimaryButton(
                text: "Siguiente",
                variant: ButtonVariant.filled,
                onPressed: _handleNext,
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
