import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/config/exports/routing.dart';

part 'register_providers.g.dart';

@riverpod
class NotificationsPreference extends _$NotificationsPreference {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void set(bool value) => state = value;
}

class PermissionNotifier extends StateNotifier<PermissionState> {
  PermissionNotifier() : super(const PermissionState());

  void toggleForo(bool value) => state = state.copyWith(foro: value);
  void toggleCompartir(bool value) => state = state.copyWith(compartir: value);
  void toggleFavoritos(bool value) => state = state.copyWith(favoritos: value);
  void toggleConfirmar(bool value) => state = state.copyWith(confirmar: value);
}

final permissionProvider =
    StateNotifierProvider<PermissionNotifier, PermissionState>((ref) {
  return PermissionNotifier();
});

class PermissionState {
  final bool foro;
  final bool compartir;
  final bool favoritos;
  final bool confirmar;

  const PermissionState({
    this.foro = false,
    this.compartir = false,
    this.favoritos = false,
    this.confirmar = false,
  });

  PermissionState copyWith({
    bool? foro,
    bool? compartir,
    bool? favoritos,
    bool? confirmar,
  }) {
    return PermissionState(
      foro: foro ?? this.foro,
      compartir: compartir ?? this.compartir,
      favoritos: favoritos ?? this.favoritos,
      confirmar: confirmar ?? this.confirmar,
    );
  }
}
