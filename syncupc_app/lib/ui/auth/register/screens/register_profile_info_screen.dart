import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';
import 'package:syncupc/features/auth/providers/register_providers.dart';
import 'package:syncupc/utils/popup_utils.dart';

class RegisterProfileInfoScreen extends ConsumerStatefulWidget {
  const RegisterProfileInfoScreen({super.key});

  @override
  ConsumerState<RegisterProfileInfoScreen> createState() =>
      _RegisterProfileInfoScreenState();
}

class _RegisterProfileInfoScreenState
    extends ConsumerState<RegisterProfileInfoScreen> {
  late final TextEditingController nameController;
  late final TextEditingController lastNameController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    lastNameController = TextEditingController();

    // Cargar valores guardados si existen
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final formState = ref.read(registerFormProvider);
      if (formState.firstName.isNotEmpty) {
        nameController.text = formState.firstName;
      }
      if (formState.lastName.isNotEmpty) {
        lastNameController.text = formState.lastName;
      }
    });
  }

  @override
  void dispose() {
    nameController.dispose();
    lastNameController.dispose();
    super.dispose();
  }

  int getCurrentStep(BuildContext context) {
    final uri = GoRouterState.of(context).uri.toString();
    if (uri.contains('/step/2')) return 2;
    if (uri.contains('/step/3')) return 3;
    return 1;
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = getCurrentStep(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 100),
                Center(
                  child: StepIndicator(
                    currentStep: currentStep - 1, // 0-based
                    totalSteps: 3,
                  ),
                ),
                const SizedBox(height: 60),
                Center(
                  child: AppText.heading1(
                    "¿Cómo te llamas?",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: AppText.body1(
                    "Queremos saber cómo dirigirnos. No te preocupes, puedes cambiar esto luego.",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppText.body2(
                    "Tu nombre",
                    color: AppColors.neutral900,
                  ),
                ),
                AppTextField(
                  controller: nameController,
                  labelText: "Escribe aquí tu nombre",
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppText.body2(
                    "Tu apellido",
                    color: AppColors.neutral900,
                  ),
                ),
                AppTextField(
                  controller: lastNameController,
                  labelText: "Escribe aquí tu apellido",
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      text: "Siguiente",
                      variant: ButtonVariant.filled,
                      onPressed: () {
                        final name = nameController.text.trim();
                        final lastName = lastNameController.text.trim();

                        if (name.isEmpty) {
                          PopupUtils.showWarning(
                            context,
                            message: 'Campo vacío',
                            subtitle: 'Por favor ingresa tu nombre',
                          );
                          return;
                        }

                        if (lastName.isEmpty) {
                          PopupUtils.showWarning(
                            context,
                            message: 'Campo vacío',
                            subtitle: 'Por favor ingresa tu apellido',
                          );
                          return;
                        }

                        ref.read(registerFormProvider.notifier).setFirstName(name);
                        ref.read(registerFormProvider.notifier).setLastName(lastName);

                        context.push('/register/step/2');
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
