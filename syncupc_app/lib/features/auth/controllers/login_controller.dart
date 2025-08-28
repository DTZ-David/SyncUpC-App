// ignore_for_file: avoid_print

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/auth/models/auth_state.dart';
import 'package:syncupc/features/auth/models/user.dart';
import 'package:syncupc/features/auth/services/login_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/user_storage_service.dart';

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

      // Usar UserStorageService para guardar todos los datos
      final storageService = UserStorageService();

      // Guardar el usuario completo
      await storageService.saveUser(user);

      // Guardar datos individuales (manteniendo tu lógica actual)
      final prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.setString('token', user.token),
        prefs.setString('refreshToken', user.refreshToken),
        prefs.setString('name', user.name),
        prefs.setString('profilePicture', user.photo),
        prefs.setString('role', user.role),
      ]);

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
    try {
      // 🔥 Usar UserStorageService primero
      final storageService = UserStorageService();
      final user = await storageService.getUser();

      if (user == null || user.refreshToken.isEmpty) {
        print('🔒 No hay usuario guardado o falta refresh token');
        return false;
      }

      // 🔄 Intentar refrescar el token
      final data = await _authService.refreshAccessToken(user.refreshToken);

      final newToken = data['accessToken'];
      final newRefreshToken = data['refreshToken'];

      // Crear usuario actualizado
      final updatedUser = User(
        token: newToken,
        refreshToken: newRefreshToken,
        name: user.name,
        photo: user.photo,
        role: user.role,
      );

      // 🔥 Guardar el usuario actualizado usando AMBOS métodos para consistencia
      await storageService.saveUser(updatedUser);

      final prefs = await SharedPreferences.getInstance();
      await Future.wait([
        prefs.setString('token', newToken),
        prefs.setString('refreshToken', newRefreshToken),
        prefs.setString('name', user.name),
        prefs.setString('profilePicture', user.photo),
        prefs.setString('role', user.role),
      ]);

      // Actualizar estado
      state = state.copyWith(
        user: updatedUser,
        isAuthenticated: true,
      );

      print('🔐 Usuario cargado exitosamente: ${user.name}');
      return true;
    } catch (e) {
      print('❌ Error al cargar usuario: $e');
      // Si falla, limpiar todo
      final storageService = UserStorageService();
      await storageService.clearAllUserData();

      state = state.copyWith(
        user: null,
        isAuthenticated: false,
      );

      return false;
    }
  }

  Future<void> logout() async {
    try {
      state = state.copyWith(isLoading: true);

      // Opcional: Llamar al endpoint de logout del backend
      // await _authService.logout();

      // Limpiar TODOS los datos almacenados
      final storageService = UserStorageService();
      await storageService.clearAllUserData();

      // Actualizar el estado
      state = state.copyWith(
        user: null,
        isAuthenticated: false,
        isLoading: false,
        errorMessage: null,
      );
    } catch (e) {
      // Aún así limpiamos los datos locales aunque falle algo
      final storageService = UserStorageService();
      await storageService.clearAllUserData();

      state = state.copyWith(
        user: null,
        isAuthenticated: false,
        isLoading: false,
        errorMessage: 'Error al cerrar sesión: ${e.toString()}',
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
