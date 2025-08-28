import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncupc/features/auth/models/user.dart';

class UserStorageService {
  static const _userKey = 'user_data';

  // Definir todas las claves que se usan
  static const _tokenKey = 'token';
  static const _refreshTokenKey = 'refreshToken';
  static const _nameKey = 'name';
  static const _profilePictureKey = 'profilePicture';
  static const _roleKey = 'role';

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(user.toJson());
    await prefs.setString(_userKey, jsonString);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_userKey);
    if (jsonString == null) return null;
    return User.fromJson(jsonDecode(jsonString));
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  // Métodos para manejar tokens y datos individuales
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  Future<void> saveRefreshToken(String refreshToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, refreshToken);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  Future<void> clearAllUserData() async {
    final prefs = await SharedPreferences.getInstance();

    // Lista de todas las claves que necesitas limpiar
    final keysToRemove = [
      _userKey,
      _tokenKey,
      _refreshTokenKey,
      _nameKey,
      _profilePictureKey,
      _roleKey,
    ];

    // Limpiar todas las claves de una vez
    await Future.wait(
      keysToRemove.map((key) => prefs.remove(key)),
    );
  }

  // Método para verificar si el usuario está logueado
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    return token != null && token.isNotEmpty;
  }

  // Método para obtener datos específicos (útil para debugging)
  Future<Map<String, String?>> getAllStoredData() async {
    final prefs = await SharedPreferences.getInstance();
    return {
      'user_data': prefs.getString(_userKey),
      'token': prefs.getString(_tokenKey),
      'refreshToken': prefs.getString(_refreshTokenKey),
      'name': prefs.getString(_nameKey),
      'profilePicture': prefs.getString(_profilePictureKey),
      'role': prefs.getString(_roleKey),
    };
  }
}
