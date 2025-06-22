import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/protons/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/ui/home/widgets/confirmation_message.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  bool _hasScanned = false;

  @override
  void initState() {
    super.initState();

    // Simula el escaneo y redirige a los 5 segundos si no se ha escaneado nada
    Future.delayed(const Duration(seconds: 5), () async {
      if (!_hasScanned && mounted) {
        _hasScanned = true;

        // Mostramos el popup y esperamos a que se cierre
        await showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => const AttendanceConfirmationPopup(
            title: "QR Escaneado",
          ),
        );

        // Luego navegamos
        if (mounted) {
          context.go("/event_confirm");
        }
      }
    });
  }

  void _onDetect(BarcodeCapture capture) {
    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null || _hasScanned) return;

    _hasScanned = true;

    final String? code = barcode.rawValue;

    if (code != null) {
      context.pop(); // o context.go('/some_screen');
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
                  onTap: () => context.pop(),
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
                  "Ubica el QR dentro del\nrecuadro para escanear",
                  textAlign: TextAlign.center,
                  color: AppColors.primary200,
                ),
                const SizedBox(height: 40),
                Container(
                  width: 220,
                  height: 220,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.primary200,
                      width: 4,
                    ),
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
