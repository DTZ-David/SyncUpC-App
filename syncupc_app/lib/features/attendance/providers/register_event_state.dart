// register_event_state.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/features/attendance/services/attendance_services.dart';
import '../../auth/providers/auth_providers.dart';

part 'register_event_state.g.dart';

@riverpod
class RegisterEventState extends _$RegisterEventState {
  @override
  RegisterEventStateData build() {
    return const RegisterEventStateData();
  }

  Future<void> registerToEvent(String eventId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final token = ref.read(authTokenProvider);
      final result = await AttendanceService().registerEvent(token!, eventId);

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        isRegistered: true, // ✅ Ahora está registrado
        result: result,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  Future<void> unregisterFromEvent(String eventId) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final token = ref.read(authTokenProvider);
      // Aquí llamarías al endpoint de des-registro cuando lo tengas
      await AttendanceService().unregisterEvent(token!, eventId);

      // Por ahora simulamos que funciona
      await Future.delayed(const Duration(seconds: 1));

      state = state.copyWith(
        isLoading: false,
        isSuccess: true,
        isRegistered: false,
        result: null,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      rethrow;
    }
  }

  void setInitialRegistrationStatus(bool isRegistered) {
    state = state.copyWith(isRegistered: isRegistered);
  }

  void reset() {
    state = const RegisterEventStateData();
  }
}

// Estado del provider
class RegisterEventStateData {
  final bool isLoading;
  final bool isSuccess;
  final bool isRegistered;
  final String? error;
  final Map<String, dynamic>? result;

  const RegisterEventStateData({
    this.isLoading = false,
    this.isSuccess = false,
    this.isRegistered = false,
    this.error,
    this.result,
  });

  RegisterEventStateData copyWith({
    bool? isLoading,
    bool? isSuccess,
    bool? isRegistered,
    String? error,
    Map<String, dynamic>? result,
  }) {
    return RegisterEventStateData(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      isRegistered: isRegistered ?? this.isRegistered,
      error: error ?? this.error,
      result: result ?? this.result,
    );
  }
}
