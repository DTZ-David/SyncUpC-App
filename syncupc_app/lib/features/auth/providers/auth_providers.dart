import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/auth/controllers/login_controller.dart';
import 'package:syncupc/features/auth/models/user.dart';

part 'auth_providers.g.dart';

// Provider para obtener el usuario actual
@riverpod
User? currentUser(Ref ref) {
  final authState = ref.watch(loginControllerProvider);
  return authState.user;
}

// Provider para verificar si está autenticado
@riverpod
bool isAuthenticated(Ref ref) {
  final authState = ref.watch(loginControllerProvider);
  return authState.isAuthenticated;
}

// Provider para obtener el token
@riverpod
String? authToken(Ref ref) {
  final authState = ref.watch(loginControllerProvider);
  return authState.user?.token;
}

// Provider para obtener el rol del usuario
@riverpod
String? userRole(Ref ref) {
  final authState = ref.watch(loginControllerProvider);
  return authState.user?.role;
}
