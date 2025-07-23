import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/auth/models/auth_state.dart';
import 'package:syncupc/features/auth/models/user.dart';
import 'package:syncupc/features/auth/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'login_controller.g.dart';

@Riverpod(keepAlive: true)
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
      await prefs.setString('refreshToken', user.refreshToken);
      await prefs.setString('name', user.name);
      await prefs.setString('profilePicture', user.photo);
      await prefs.setString('role', user.role);
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

  Future<bool> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final refreshToken = prefs.getString('refreshToken');
    final name = prefs.getString('name');
    final photo = prefs.getString('profilePicture');
    final role = prefs.getString('role');

    // 🔒 Verificamos que haya datos mínimos para construir el User
    if (refreshToken == null || name == null || photo == null || role == null) {
      return false;
    }

    try {
      // 🔄 Llamada al backend para refrescar token
      final data = await _authService.refreshAccessToken(refreshToken);

      final newToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];

      // Guardamos los nuevos tokens
      await prefs.setString('token', newToken);
      await prefs.setString('refreshToken', newRefreshToken);

      final user = User(
        token: newToken,
        refreshToken: newRefreshToken,
        name: name,
        photo: photo,
        role: role,
      );

      state = state.copyWith(
        user: user,
        isAuthenticated: true,
      );

      return true; // 👈 Éxito
    } catch (e) {
      // Si algo falla, hacemos logout silencioso
      await prefs.clear(); // opcional
      state = state.copyWith(
        user: null,
        isAuthenticated: false,
      );

      return false; // 👈 Fallo
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
