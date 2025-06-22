// Loading Screen Simple (pantalla en blanco)
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/protons/colors.dart';

class SimpleLoadingScreen extends ConsumerWidget {
  final Color? backgroundColor;
  final Color? indicatorColor;
  final bool showIndicator;

  const SimpleLoadingScreen({
    super.key,
    this.backgroundColor,
    this.indicatorColor,
    this.showIndicator = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.backgroundAccent,
      body: SafeArea(
        child: Center(
          child: showIndicator
              ? _buildCustomLoadingIndicator()
              : const SizedBox.shrink(),
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
          indicatorColor ?? AppColors.primary500,
        ),
      ),
    );
  }
}
