import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/registerEvent/models/event_request.dart';
import 'package:syncupc/features/auth/providers/auth_providers.dart';
import 'package:syncupc/features/registerEvent/services/event_request_service.dart';
import '../../auth/models/register_state.dart';

part 'register_event_controller.g.dart';

@riverpod
class RegisterEventController extends _$RegisterEventController {
  late final EventRequestService _registerService;

  @override
  RegisterState build() {
    _registerService = EventRequestService();
    return const RegisterState();
  }

  Future<bool> registerEvent(EventRequest request) async {
    final token = ref.read(authTokenProvider);

    if (token == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'No hay token de autenticación',
      );
      return false;
    }

    state = state.copyWith(
      isLoading: true,
      isSuccess: false,
      errorMessage: null,
    );

    try {
      // Llamar al servicio
      await _registerService.registerEvent(token, request);

      // Si llegamos aquí, fue exitoso
      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        errorMessage: null, // Asegurar que no hay error
      );

      return true;
    } catch (e) {
      // Manejo de errores más específico
      String errorMessage = 'Error inesperado al crear el evento';

      if (e.toString().contains('Sin conexión a internet')) {
        errorMessage = 'Sin conexión a internet. Verifica tu conexión.';
      } else if (e.toString().contains('Error al registrar:')) {
        errorMessage = e.toString().replaceFirst('Exception: ', '');
      } else {
        errorMessage = 'Error al crear el evento. Intenta nuevamente.';
      }

      state = state.copyWith(
        isLoading: false,
        isSuccess: false,
        errorMessage: errorMessage,
      );

      return false;
    }
  }

  void clearError() => state = state.copyWith(errorMessage: null);
  void resetSuccess() => state = state.copyWith(isSuccess: false);
}
