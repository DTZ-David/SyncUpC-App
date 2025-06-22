// Loading Screen Personalizado (como el de la imagen)
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/config/exports/routing.dart';

class CustomLoadingScreen extends ConsumerWidget {
  final String title;
  final String subtitle;
  final Color? backgroundColor;
  final Color? textColor;
  final Color? indicatorColor;

  const CustomLoadingScreen({
    super.key,
    this.title = "¡Vamos a crear tu cuenta!",
    this.subtitle =
        "Solo unos pasos más para empezar a explorar los mejores eventos cerca de ti.",
    this.backgroundColor,
    this.textColor,
    this.indicatorColor,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.primary50,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),

              // Título principal
              AppText.heading1(
                title,
                textAlign: TextAlign.center,
                color: textColor ?? Colors.black,
              ),

              const SizedBox(height: 40),

              // Indicador de carga personalizado
              _buildCustomLoadingIndicator(),

              const SizedBox(height: 40),

              // Subtítulo
              AppText.body1(
                subtitle,
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

  Widget _buildCustomLoadingIndicator() {
    return SizedBox(
      width: 48,
      height: 48,
      child: CircularProgressIndicator(
        strokeWidth: 3,
        valueColor: AlwaysStoppedAnimation<Color>(
          indicatorColor ?? Colors.black54,
        ),
      ),
    );
  }
}
