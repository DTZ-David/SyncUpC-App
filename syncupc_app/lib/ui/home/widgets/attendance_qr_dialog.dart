import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/utils/popup_utils.dart';

class AttendanceQrDialog extends ConsumerStatefulWidget {
  final String eventId;
  final String eventTitle;
  final String userId;

  const AttendanceQrDialog({
    super.key,
    required this.eventId,
    required this.eventTitle,
    required this.userId,
  });

  @override
  ConsumerState<AttendanceQrDialog> createState() => _AttendanceQrDialogState();
}

class _AttendanceQrDialogState extends ConsumerState<AttendanceQrDialog> {
  final GlobalKey _qrKey = GlobalKey();
  bool _isDownloading = false;

  Future<void> _downloadQr() async {
    setState(() => _isDownloading = true);

    try {
      // Capturar el widget como imagen
      RenderRepaintBoundary boundary =
          _qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      // Guardar en directorio temporal
      final directory = await getTemporaryDirectory();
      final filePath =
          '${directory.path}/qr_${widget.eventId}_${DateTime.now().millisecondsSinceEpoch}.png';
      final file = File(filePath);
      await file.writeAsBytes(pngBytes);

      // Guardar en galería
      final result = await GallerySaver.saveImage(filePath);

      if (result == true && mounted) {
        PopupUtils.showSuccess(
          context,
          message: 'QR descargado exitosamente',
          subtitle: 'Revisa tu galería de imágenes',
          duration: const Duration(seconds: 2),
        );
      } else if (mounted) {
        PopupUtils.showError(
          context,
          message: 'Error al guardar el QR',
          subtitle: 'Por favor intenta de nuevo',
          duration: const Duration(seconds: 2),
        );
      }
    } catch (e) {
      print('Error al descargar QR: $e');
      if (mounted) {
        PopupUtils.showError(
          context,
          message: 'Error al descargar el QR',
          subtitle: e.toString(),
          duration: const Duration(seconds: 2),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isDownloading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Generar el contenido del QR: userId-eventId
    final qrData = '${widget.userId}:${widget.eventId}';

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: AppText.heading2(
                    'Tu código QR de asistencia',
                    maxLines: 2,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),
            AppText.body2(
              'Guarda este código QR para confirmar tu asistencia al evento',
              textAlign: TextAlign.center,
              color: AppColors.neutral600,
            ),
            const SizedBox(height: 24),
            RepaintBoundary(
              key: _qrKey,
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.neutral200),
                ),
                child: Column(
                  children: [
                    QrImageView(
                      data: qrData,
                      version: QrVersions.auto,
                      size: 200.0,
                      backgroundColor: Colors.white,
                    ),
                    const SizedBox(height: 12),
                    AppText.caption(
                      widget.eventTitle,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      color: AppColors.neutral700,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            PrimaryButton(
              text: 'Descargar QR',
              variant: ButtonVariant.filled,
              isLoading: _isDownloading,
              isDisabled: _isDownloading,
              onPressed: _downloadQr,
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: AppText.body2(
                'Cerrar',
                color: AppColors.primary200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
