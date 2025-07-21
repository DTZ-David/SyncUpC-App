import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/auth/models/auth_state.dart';
import 'package:syncupc/features/auth/models/user.dart';
import 'package:syncupc/features/auth/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_controller.g.dart';

@riverpod
class LoginController extends _$LoginController {
  late final LoginService _authService;

  @override
  AuthState build() {
    _authService = LoginService();
    return AuthState();
  }

  Future<void> login(String username, String password) async {
    state = state.copyWith(
      isLoading: true,
      errorMessage: null,
    );

    try {
      final response = await _authService.login(username, password);
      final user = User.fromJson(response);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', user.token);
      await prefs.setString('refreshToken', response['refreshToken'] ?? '');

      state = state.copyWith(
        user: user,
        isLoading: false,
        isAuthenticated: true,
        errorMessage: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
        isAuthenticated: false,
        user: null,
      );
    }
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    try {
      await _authService.logout();

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('token');
      await prefs.remove('refreshToken');

      state = AuthState(); // Reset
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Error al cerrar sesión',
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
