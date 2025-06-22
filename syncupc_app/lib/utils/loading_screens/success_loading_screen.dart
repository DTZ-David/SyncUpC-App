import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';

class SuccessLoadingScreen extends ConsumerWidget {
  final Color? backgroundColor;
  final Color? textColor;
  final Color? indicatorColor;

  const SuccessLoadingScreen({
    super.key,
    this.backgroundColor,
    this.textColor,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.backgroundPrimary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Mensaje principal
              AppText.heading2(
                "Hemos registrado tu asistencia, ya puedes continuar.",
                textAlign: TextAlign.center,
                color: textColor ?? Colors.black,
              ),

              const SizedBox(height: 32),

              // Indicador de carga
              SizedBox(
                width: 48,
                height: 48,
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    indicatorColor ?? AppColors.primary200,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Subtexto
              AppText.body3(
                "Redirigiéndote...",
                textAlign: TextAlign.center,
                color: textColor ?? Colors.black87,
              ),

              const Spacer(flex: 3),
            ],
          ),
        ),
      ),
    );
  }
}
