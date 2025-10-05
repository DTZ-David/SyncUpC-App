import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/protons/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/features/attendance/providers/attendance_providers.dart';
import 'package:syncupc/ui/home/widgets/confirmation_message.dart';
import 'package:syncupc/utils/popup_utils.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  bool _hasScanned = false;
  bool _isProcessing = false;

  void _onDetect(BarcodeCapture capture) async {
    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null || _hasScanned || _isProcessing) return;

    final String? code = barcode.rawValue;
    if (code == null) return;

    setState(() {
      _isProcessing = true;
    });

    debugPrint("Código escaneado: $code");

    try {
      final eventTitle = await ref.read(checkInProvider(code).future);

      // Si llegamos aquí, el escaneo fue exitoso
      _hasScanned = true;

      // Muestra el popup de confirmación
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AttendanceConfirmationPopup(
          title: "QR Escaneado",
        ),
      );

      if (mounted) {
        context.go("/event_confirm", extra: eventTitle);
      }
    } catch (error) {
      // Manejar diferentes tipos de errores
      if (mounted) {
        _showErrorPopup("El evento no ha iniciado o ya finalizo");
        // Resetear para permitir otro intento
        setState(() {
          _isProcessing = false;
        });
      }
    }
  }

  void _showErrorPopup(String message) {
    PopupUtils.showInfo(
      context,
      message: message,
      subtitle: 'Por favor intenta de nuevo',
    );
  }

  // 🔥 Función para manejar el retroceso de forma segura
  void _handleBack() {
    try {
      // 🔥 Verificar si puede hacer pop
      if (context.canPop()) {
        context.pop();
      } else {
        // 🔥 Si no puede hacer pop, navegar al home
        context.go('/');
      }
    } catch (e) {
      // 🔥 Como fallback, siempre navegar al home
      debugPrint('Error en navegación: $e');
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          MobileScanner(
            fit: BoxFit.cover,
            onDetect: _onDetect,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: _handleBack, // 🔥 Usar la función segura
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.arrow_back,
                        color: AppColors.primary200),
                  ),
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.body2(
                  _isProcessing
                      ? "Procesando QR..."
                      : "Ubica el QR dentro del\nrecuadro para escanear",
                  textAlign: TextAlign.center,
                  color: AppColors.primary200,
                ),
                const SizedBox(height: 40),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 220,
                      height: 220,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: _isProcessing
                              ? Colors.orange
                              : AppColors.primary200,
                          width: 4,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    if (_isProcessing)
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const CircularProgressIndicator(
                          color: AppColors.primary200,
                          strokeWidth: 3,
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
