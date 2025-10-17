import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/features/attendance/services/attendance_services.dart';
import 'package:syncupc/features/auth/providers/auth_providers.dart';
import 'package:syncupc/utils/popup_utils.dart';

class QrScannerAttendanceScreen extends ConsumerStatefulWidget {
  final String eventId;
  final String eventTitle;

  const QrScannerAttendanceScreen({
    super.key,
    required this.eventId,
    required this.eventTitle,
  });

  @override
  ConsumerState<QrScannerAttendanceScreen> createState() =>
      _QrScannerAttendanceScreenState();
}

class _QrScannerAttendanceScreenState
    extends ConsumerState<QrScannerAttendanceScreen> {
  MobileScannerController cameraController = MobileScannerController();
  bool _isProcessing = false;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> _processQrCode(String qrData) async {
    if (_isProcessing) return;

    setState(() => _isProcessing = true);

    try {
      // El QR tiene formato: userId:eventId
      final parts = qrData.split(':');
      if (parts.length != 2) {
        throw Exception('Formato de QR inválido');
      }

      final scannedUserId = parts[0];
      final scannedEventId = parts[1];

      // Verificar que el QR sea para este evento
      if (scannedEventId != widget.eventId) {
        throw Exception('Este QR no corresponde a este evento');
      }

      // Obtener el token del usuario actual (administrador)
      final token = ref.read(authTokenProvider);
      if (token == null) {
        throw Exception('No hay sesión activa');
      }

      // Confirmar asistencia usando el userId del QR
      final userName = await AttendanceService()
          .checkInWithUserId(token, widget.eventId, scannedUserId);

      if (mounted) {
        PopupUtils.showSuccess(
          context,
          message: '¡Asistencia confirmada!',
          subtitle: 'Usuario: $userName',
          duration: const Duration(seconds: 2),
        );

        // Esperar un momento antes de permitir escanear otro QR
        await Future.delayed(const Duration(seconds: 2));
      }
    } catch (e) {
      if (mounted) {
        PopupUtils.showError(
          context,
          message: 'Error al confirmar asistencia',
          subtitle: e.toString().replaceAll('Exception: ', ''),
          duration: const Duration(seconds: 3),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isProcessing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.heading3('Escanear Asistencia'),
        backgroundColor: AppColors.primary200,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary50,
            child: Column(
              children: [
                AppText.subtitle2(
                  widget.eventTitle,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                AppText.body2(
                  'Escanea el código QR del participante',
                  color: AppColors.neutral600,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                MobileScanner(
                  controller: cameraController,
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    for (final barcode in barcodes) {
                      if (barcode.rawValue != null && !_isProcessing) {
                        _processQrCode(barcode.rawValue!);
                        break;
                      }
                    }
                  },
                ),
                // Overlay con marco de escaneo
                Center(
                  child: Container(
                    width: 250,
                    height: 250,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: _isProcessing
                            ? AppColors.neutral400
                            : AppColors.primary200,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                if (_isProcessing)
                  Container(
                    color: Colors.black54,
                    child: const Center(
                      child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: Icon(
                        cameraController.torchEnabled
                            ? Icons.flash_on
                            : Icons.flash_off,
                        color: AppColors.primary200,
                      ),
                      onPressed: () => cameraController.toggleTorch(),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.cameraswitch,
                        color: AppColors.primary200,
                      ),
                      onPressed: () => cameraController.switchCamera(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                AppText.caption(
                  'Centra el código QR en el marco para escanearlo',
                  textAlign: TextAlign.center,
                  color: AppColors.neutral600,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
