import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:syncupc/config/exports/design_system_barrel.dart';
import 'package:syncupc/features/attendance/services/attendance_services.dart';
import 'package:syncupc/features/auth/providers/auth_providers.dart';
import 'package:syncupc/features/home/providers/event_providers.dart';
import 'package:syncupc/utils/popup_utils.dart';

class QrScannerWithEventSelection extends ConsumerStatefulWidget {
  const QrScannerWithEventSelection({super.key});

  @override
  ConsumerState<QrScannerWithEventSelection> createState() =>
      _QrScannerWithEventSelectionState();
}

class _QrScannerWithEventSelectionState
    extends ConsumerState<QrScannerWithEventSelection> {
  MobileScannerController cameraController = MobileScannerController();
  bool _isProcessing = false;
  String? _selectedEventId;
  String? _selectedEventTitle;

  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }

  Future<void> _processQrCode(String qrData) async {
    if (_isProcessing) return;

    // Verificar que se haya seleccionado un evento
    if (_selectedEventId == null) {
      PopupUtils.showError(
        context,
        message: 'Selecciona un evento primero',
        subtitle: 'Debes elegir el evento antes de escanear',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      // El QR tiene formato: userId:eventId
      final parts = qrData.split(':');
      if (parts.length != 2) {
        throw Exception('Formato de QR inválido');
      }

      final scannedUserId = parts[0];
      final scannedEventId = parts[1];

      // Verificar que el QR sea para el evento seleccionado
      if (scannedEventId != _selectedEventId) {
        throw Exception(
            'Este QR no corresponde al evento seleccionado\nQR para evento: $scannedEventId\nEvento seleccionado: $_selectedEventId');
      }

      // Obtener el token del usuario actual (administrador)
      final token = ref.read(authTokenProvider);
      if (token == null) {
        throw Exception('No hay sesión activa');
      }

      // Confirmar asistencia usando el userId del QR
      final userName = await AttendanceService()
          .checkInWithUserId(token, _selectedEventId!, scannedUserId);

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

  void _showEventSelector() async {
    final eventsAsync = ref.read(getAllEventsProvider);

    eventsAsync.when(
      data: (events) {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText.heading3('Selecciona el evento'),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: events.length,
                    itemBuilder: (context, index) {
                      final event = events[index];
                      return ListTile(
                        title: AppText.body1(event.eventTitle),
                        subtitle: AppText.caption(event.campus.name),
                        trailing: _selectedEventId == event.id
                            ? const Icon(Icons.check_circle,
                                color: AppColors.primary200)
                            : null,
                        onTap: () {
                          setState(() {
                            _selectedEventId = event.id;
                            _selectedEventTitle = event.eventTitle;
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
      loading: () {
        PopupUtils.showError(
          context,
          message: 'Cargando eventos...',
          duration: const Duration(seconds: 1),
        );
      },
      error: (error, stack) {
        PopupUtils.showError(
          context,
          message: 'Error al cargar eventos',
          subtitle: error.toString(),
          duration: const Duration(seconds: 2),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppText.heading3('Escanear Asistencia'),
        backgroundColor: AppColors.primary200,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.event),
            onPressed: _showEventSelector,
            tooltip: 'Seleccionar evento',
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            color: AppColors.primary50,
            child: Column(
              children: [
                if (_selectedEventTitle != null) ...[
                  AppText.subtitle2(
                    _selectedEventTitle!,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                ] else ...[
                  AppText.subtitle2(
                    'Sin evento seleccionado',
                    maxLines: 2,
                    textAlign: TextAlign.center,
                    color: AppColors.neutral600,
                  ),
                  const SizedBox(height: 8),
                ],
                GestureDetector(
                  onTap: _showEventSelector,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: AppColors.primary200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.event, color: Colors.white, size: 16),
                        const SizedBox(width: 4),
                        AppText.body2(
                          'Seleccionar Evento',
                          color: Colors.white,
                        ),
                      ],
                    ),
                  ),
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
                            : (_selectedEventId != null
                                ? AppColors.primary200
                                : AppColors.neutral400),
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
                  _selectedEventId != null
                      ? 'Centra el código QR en el marco para escanearlo'
                      : 'Selecciona un evento antes de escanear',
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
