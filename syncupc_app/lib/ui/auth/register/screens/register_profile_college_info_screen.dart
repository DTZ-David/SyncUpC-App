import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/atoms/text_field.dart';
import 'package:syncupc/features/auth/providers/register_providers.dart';
import 'package:syncupc/utils/popup_utils.dart';

import '../../../../design_system/molecules/drop_down.dart';
import '../../../../design_system/models/dropdown_item.dart';
import '../../../../features/auth/providers/career_provider.dart';

class RegisterProfileCollegeInfoScreen extends ConsumerStatefulWidget {
  const RegisterProfileCollegeInfoScreen({super.key});

  @override
  ConsumerState<RegisterProfileCollegeInfoScreen> createState() =>
      _RegisterProfileCollegeInfoScreenState();
}

class _RegisterProfileCollegeInfoScreenState
    extends ConsumerState<RegisterProfileCollegeInfoScreen> {
  late final TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    phoneController = TextEditingController();

    // Si ya hay un número guardado en el estado, lo cargamos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final formState = ref.read(registerFormProvider);
      if (formState.phoneNumber.isNotEmpty) {
        phoneController.text = formState.phoneNumber;
      }
    });
  }

  @override
  void dispose() {
    phoneController.dispose();
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
    final careersAsync = ref.watch(getAllCareersProvider);

    final formState = ref.watch(registerFormProvider);
    final formNotifier = ref.read(registerFormProvider.notifier);

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
                    currentStep: currentStep - 1,
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
                  onChanged: (value) {
                    // Actualizamos el estado en tiempo real
                    formNotifier.setPhoneNumber(value.trim());
                  },
                ),
                const SizedBox(height: 24),

                // Dropdown de carrera
                careersAsync.when(
                  data: (careers) {
                    final items = careers
                        .map(
                          (career) => DropdownItem(
                            value: career.id,
                            title: career.name,
                          ),
                        )
                        .toList();

                    return DropdownMolecule<String>(
                      labelText: 'Carrera',
                      hintText: 'Selecciona tu carrera',
                      isRequired: true,
                      selectedValue: formState.careerId,
                      items: items,
                      onChanged: (val) {
                        if (val != null) {
                          formNotifier.setCareer(val);
                        }
                      },
                    );
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => AppText.body2(
                    'Error al cargar carreras',
                    color: Colors.red,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 40),
                  child: SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      text: "Siguiente",
                      variant: ButtonVariant.filled,
                      onPressed: () {
                        final phone = phoneController.text.trim();
                        final careerId = formState.careerId;

                        if (phone.isEmpty) {
                          PopupUtils.showWarning(
                            context,
                            message: 'Campo vacío',
                            subtitle: 'Por favor ingresa tu número de teléfono',
                          );
                          return;
                        }

                        if (careerId.isEmpty) {
                          PopupUtils.showWarning(
                            context,
                            message: 'Carrera no seleccionada',
                            subtitle: 'Por favor selecciona tu carrera',
                          );
                          return;
                        }

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
