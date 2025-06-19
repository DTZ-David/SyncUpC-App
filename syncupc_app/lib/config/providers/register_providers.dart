import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'register_providers.g.dart';

@riverpod
class NotificationsPreference extends _$NotificationsPreference {
  @override
  bool build() => false;

  void toggle() => state = !state;
  void set(bool value) => state = value;
}
