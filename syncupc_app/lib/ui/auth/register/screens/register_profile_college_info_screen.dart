import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';
import 'package:syncupc/features/auth/providers/register_providers.dart';

import '../widgets/custom_dropDown_button.dart';

class RegisterProfileCollegeInfoScreen extends ConsumerWidget {
  const RegisterProfileCollegeInfoScreen({super.key});

  int getCurrentStep(BuildContext context) {
    final uri = GoRouterState.of(context).uri.toString();
    if (uri.contains('/step/2')) return 2;
    if (uri.contains('/step/3')) return 3;
    return 1;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String? selectedCareer;
    final List<DropdownItem<String>> careers = [
      DropdownItem(
        value: 'ing_sistemas',
        title: 'Ingeniería de Sistemas',
        subtitle: 'Desarrollo de software y tecnología',
      ),
      DropdownItem(
        value: 'ing_industrial',
        title: 'Ingeniería Industrial',
        subtitle: 'Optimización de procesos industriales',
      ),
      DropdownItem(
        value: 'medicina',
        title: 'Medicina',
        subtitle: 'Ciencias de la salud',
      ),
      DropdownItem(
        value: 'psicologia',
        title: 'Psicología',
        subtitle: 'Estudio del comportamiento humano',
      ),
    ];
    final phoneController = TextEditingController();
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
                    "¡Otra información importante!",
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: AppText.body2(
                    "Celular",
                    color: AppColors.neutral900,
                  ),
                ),
                AppTextField(
                  controller: phoneController,
                  labelText: "Escribe aquí tu número de telefono",
                ),
                const SizedBox(height: 24),
                CustomDropdown<String>(
                  labelText: 'Carrera',
                  hintText: 'Selecciona tu carrera',
                  isRequired: true,
                  selectedValue: selectedCareer,
                  items: careers,
                  onChanged: (String? career) {},
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      text: "Siguiente",
                      variant: ButtonVariant.filled,
                      onPressed: () {
                        ref
                            .read(registerFormProvider.notifier)
                            .setPhoneNumber(phoneController.text.trim());
                        ref
                            .read(registerFormProvider.notifier)
                            .setFaculty("685ad08eb1262f0763410dc5");
                        ref
                            .read(registerFormProvider.notifier)
                            .setCareer("665f4d2d1c9d440001fcf001");
                        context.push('/register/step/3');
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
