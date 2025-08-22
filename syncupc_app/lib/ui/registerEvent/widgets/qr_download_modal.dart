import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gallery_saver_plus/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:io';

import '../../../utils/popup_utils.dart';

class QrPopupDialog extends StatelessWidget {
  final String eventId;
  final GlobalKey globalKey = GlobalKey();

  QrPopupDialog({super.key, required this.eventId});

  Future<void> _saveQrToGallery(BuildContext context) async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image originalImage = await boundary.toImage(pixelRatio: 3.0);

      // Fondo blanco
      final recorder = ui.PictureRecorder();
      final canvas = Canvas(recorder);
      final paint = Paint()..color = Colors.white;
      canvas.drawRect(
        Rect.fromLTWH(0, 0, originalImage.width.toDouble(),
            originalImage.height.toDouble()),
        paint,
      );
      canvas.drawImage(originalImage, Offset.zero, Paint());
      ui.Image finalImage = await recorder
          .endRecording()
          .toImage(originalImage.width, originalImage.height);

      ByteData? byteData =
          await finalImage.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final directory = await getTemporaryDirectory();
      final file = File(
          '${directory.path}/qr_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(pngBytes);

      final bool? success = await GallerySaver.saveImage(file.path);
      if (context.mounted) {
        Navigator.of(context).pop();

        if (success == true) {
          PopupUtils.showSuccess(
            context,
            message: 'QR guardado en la galería',
            subtitle: 'Tu evento ha sido actualizado',
            duration: const Duration(seconds: 2),
          );
        } else {
          PopupUtils.showError(
            context,
            message: 'No se pudo guardar el QR',
            subtitle: 'Ocurrió un error al intentar guardar la imagen',
            duration: const Duration(seconds: 2),
          );
        }
      }
    } catch (e) {
      PopupUtils.showError(
        context,
        message: e.toString(),
        subtitle: 'Ocurrió un error al intentar guardar la imagen',
        duration: const Duration(seconds: 2),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              "Tu código QR de asistencia",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            RepaintBoundary(
              key: globalKey,
              child: QrImageView(
                data: eventId,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () => _saveQrToGallery(context),
              icon: const Icon(Icons.download),
              label: const Text("Descargar QR"),
            ),
          ],
        ),
      ),
    );
  }
}
