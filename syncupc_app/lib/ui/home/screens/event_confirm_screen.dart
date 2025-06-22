import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/utils/loading_screens/loading_dialog_helpers.dart';
import 'package:syncupc/utils/loading_screens/loading_types.dart';

class EventConfirm extends ConsumerWidget {
  const EventConfirm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 250, right: 12, left: 12),
            child: AppText.heading1(
                "Estas registrando tu asistencia para Seminario Summer Camp 2025"),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: AppText.body1(
                "Esta es tu asistencia de Entrada, debes registrar la de salida una vez el evento finalice."),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: PrimaryButton(
              text: "Acepto",
              variant: ButtonVariant.filled,
              onPressed: () async {
                await showAutoLoadingDialog(
                  context,
                  type: LoadingType.success,
                  onComplete: () {
                    context.go('/');
                  },
                );
              },
            ),
          ),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
                              "Si necesitas mas informacion, puedes consultar  "),
                      TextSpan(
                        text: "Politica de Aceptacion de Eventos.",
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
    );
  }
}
