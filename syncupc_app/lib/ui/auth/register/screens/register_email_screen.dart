import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';
import 'package:syncupc/utils/popup_utils.dart'; // Importar para mostrar alertas

import '../../../../features/auth/providers/register_providers.dart';

class RegisterEmailScreen extends ConsumerStatefulWidget {
  const RegisterEmailScreen({super.key});

  @override
  ConsumerState<RegisterEmailScreen> createState() => _RegisterEmailScreenState();
}

class _RegisterEmailScreenState extends ConsumerState<RegisterEmailScreen> {
  late final TextEditingController _emailController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  // 🔥 Función para validar email
  bool _isValidEmail(String email) {
    final RegExp emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  // 🔥 Función específica para validar email de unicesar (opcional)
  bool _isValidUnicesar(String email) {
    return email.toLowerCase().endsWith('@unicesar.edu.co');
  }

  // 🔥 Función para manejar el siguiente paso
  void _handleNext() async {
    if (_isLoading) return;

    final email = _emailController.text.trim();

      // 🔥 Validación de campo vacío
      if (email.isEmpty) {
        PopupUtils.showWarning(
          context,
          message: 'Campo vacío',
          subtitle: 'Por favor ingresa tu email',
        );
        return;
      }

      // 🔥 Validación de formato de email
      if (!_isValidEmail(email)) {
        PopupUtils.showWarning(
          context,
          message: 'Email inválido',
          subtitle: 'Por favor ingresa un email con formato válido',
        );
        return;
      }

      if (!_isValidUnicesar(email)) {
        PopupUtils.showWarning(
          context,
          message: 'Email no válido',
          subtitle: 'Debe ser un email de @unicesar.edu.co',
        );
        return;
      }

    // 🚀 Si todas las validaciones pasan, proceder
    setState(() => _isLoading = true);

    try {
      ref.read(registerFormProvider.notifier).setEmail(email);
      await Future.delayed(const Duration(milliseconds: 300)); // Pequeña pausa para UX
      if (mounted) {
        context.push('/registerPassword');
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {

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
                controller: _emailController,
                labelText:
                    "Escribe aqui tu email              | @unicesar.edu.co",
                // 🔥 Configuración adicional para email
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50, left: 12, right: 12),
              child: PrimaryButton(
                text: "Siguiente",
                variant: ButtonVariant.filled,
                isLoading: _isLoading,
                onPressed: _isLoading ? null : _handleNext,
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
