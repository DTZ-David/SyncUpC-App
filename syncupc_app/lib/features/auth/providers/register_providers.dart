import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/auth/controllers/register_controller.dart';
import 'package:syncupc/features/auth/models/register_user_request.dart';
import '../models/notification_preferences.dart';

part 'register_providers.g.dart';

@Riverpod(keepAlive: true)
class RegisterForm extends _$RegisterForm {
  @override
  RegisterUserRequest build() => RegisterUserRequest(
        firstName: '',
        lastName: '',
        email: '',
        password: '',
        phoneNumber: '',
        profilePhotoUrl: '',
        careerId: '',
      );

  // setters de paso en paso ↓
  void setFirstName(String v) => state = state.copyWith(firstName: v.trim());

  void setLastName(String v) => state = state.copyWith(lastName: v.trim());

  void setEmail(String v) => state = state.copyWith(email: v.trim());

  void setPassword(String v) => state = state.copyWith(password: v);

  void setPhoneNumber(String v) =>
      state = state.copyWith(phoneNumber: v.trim());

  void setCareer(String id) => state = state.copyWith(careerId: id);

  void setNotificationPrefs(NotificationPreferences prefs) =>
      state = state.copyWith(notificationPreferences: prefs);

  void reset() => state = build();
}

/* ─────────────────────────────────────────
   AUXILIAR PROVIDERS  ➜ estado del registro
   ───────────────────────────────────────── */

@riverpod
bool isRegistering(Ref ref) {
  return ref.watch(registerControllerProvider).isLoading;
}

@riverpod
bool registerSuccess(Ref ref) {
  return ref.watch(registerControllerProvider).isSuccess;
}

@riverpod
String? registerErrorMessage(Ref ref) {
  return ref.watch(registerControllerProvider).errorMessage;
}
