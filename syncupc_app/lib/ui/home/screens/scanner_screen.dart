import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncupc/design_system/atoms/app_text.dart';
import 'package:syncupc/design_system/protons/colors.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/features/attendance/providers/attendance_providers.dart';
import 'package:syncupc/ui/home/widgets/confirmation_message.dart';

class ScannerScreen extends ConsumerStatefulWidget {
  const ScannerScreen({super.key});

  @override
  ConsumerState<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends ConsumerState<ScannerScreen> {
  bool _hasScanned = false;

  void _onDetect(BarcodeCapture capture) async {
    final barcode = capture.barcodes.firstOrNull;
    if (barcode == null || _hasScanned) return;

    final String? code = barcode.rawValue;
    if (code == null) return;

    _hasScanned = true;

    debugPrint("Código escaneado: $code");

    final eventTitle = await ref.read(checkInProvider(code).future);
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
