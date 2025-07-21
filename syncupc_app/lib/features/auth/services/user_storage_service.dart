import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncupc/features/auth/models/user.dart';

class UserStorageService {
  static const _key = 'user_data';

  Future<void> saveUser(User user) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = jsonEncode(user.toJson());
    await prefs.setString(_key, jsonString);
  }

  Future<User?> getUser() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);
    if (jsonString == null) return null;
    return User.fromJson(jsonDecode(jsonString));
  }

  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
