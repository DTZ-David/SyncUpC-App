// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isRegisteringHash() => r'9dbef81135d73deb604131b6cb3830239ff55093';

/// See also [isRegistering].
@ProviderFor(isRegistering)
final isRegisteringProvider = AutoDisposeProvider<bool>.internal(
  isRegistering,
  name: r'isRegisteringProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isRegisteringHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef IsRegisteringRef = AutoDisposeProviderRef<bool>;
String _$registerSuccessHash() => r'031e71c8f15bf3b7dc24bc2681e2e32a796d861c';

/// See also [registerSuccess].
@ProviderFor(registerSuccess)
final registerSuccessProvider = AutoDisposeProvider<bool>.internal(
  registerSuccess,
  name: r'registerSuccessProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$registerSuccessHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RegisterSuccessRef = AutoDisposeProviderRef<bool>;
String _$registerErrorMessageHash() =>
    r'4fb4637fc261c498ba0af8afefa7030b19f9f31b';

/// See also [registerErrorMessage].
@ProviderFor(registerErrorMessage)
final registerErrorMessageProvider = AutoDisposeProvider<String?>.internal(
  registerErrorMessage,
  name: r'registerErrorMessageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$registerErrorMessageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef RegisterErrorMessageRef = AutoDisposeProviderRef<String?>;
String _$registerFormHash() => r'23343632825706a355eb3957d15f5242f1accb79';

/// See also [RegisterForm].
@ProviderFor(RegisterForm)
final registerFormProvider =
    NotifierProvider<RegisterForm, RegisterUserRequest>.internal(
  RegisterForm.new,
  name: r'registerFormProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$registerFormHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RegisterForm = Notifier<RegisterUserRequest>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
