import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/auth/services/register_service.dart';

import '../models/register_state.dart';
import '../models/register_user_request.dart';

part 'register_controller.g.dart';

@riverpod
class RegisterController extends _$RegisterController {
  late final RegisterService _registerService;

  @override
  RegisterState build() {
    _registerService = RegisterService();
    return const RegisterState();
  }

  /// Ahora SÍ devuelve bool y NO recibe parámetros
  Future<bool> register(RegisterUserRequest request) async {
    state = state.copyWith(
      isLoading: true,
      isSuccess: false,
      errorMessage: null,
    );

    try {
      await _registerService.registerUser(request);

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
      );
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }

  void clearError() => state = state.copyWith(errorMessage: null);
  void resetSuccess() => state = state.copyWith(isSuccess: false);
}
