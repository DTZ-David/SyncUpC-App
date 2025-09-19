// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attendance_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$checkInHash() => r'36baa6c4792be6d0c9e951aa21c194ea8645c5af';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [checkIn].
@ProviderFor(checkIn)
const checkInProvider = CheckInFamily();

/// See also [checkIn].
class CheckInFamily extends Family<AsyncValue<String>> {
  /// See also [checkIn].
  const CheckInFamily();

  /// See also [checkIn].
  CheckInProvider call(
    String eventId,
  ) {
    return CheckInProvider(
      eventId,
    );
  }

  @override
  CheckInProvider getProviderOverride(
    covariant CheckInProvider provider,
  ) {
    return call(
      provider.eventId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'checkInProvider';
}

/// See also [checkIn].
class CheckInProvider extends AutoDisposeFutureProvider<String> {
  /// See also [checkIn].
  CheckInProvider(
    String eventId,
  ) : this._internal(
          (ref) => checkIn(
            ref as CheckInRef,
            eventId,
          ),
          from: checkInProvider,
          name: r'checkInProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$checkInHash,
          dependencies: CheckInFamily._dependencies,
          allTransitiveDependencies: CheckInFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  CheckInProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    FutureOr<String> Function(CheckInRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CheckInProvider._internal(
        (ref) => create(ref as CheckInRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<String> createElement() {
    return _CheckInProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CheckInProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CheckInRef on AutoDisposeFutureProviderRef<String> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _CheckInProviderElement extends AutoDisposeFutureProviderElement<String>
    with CheckInRef {
  _CheckInProviderElement(super.provider);

  @override
  String get eventId => (origin as CheckInProvider).eventId;
}

String _$registerEventHash() => r'b8ef409ab36239d6b42ea28df83ce5cdb9a988e8';

/// See also [registerEvent].
@ProviderFor(registerEvent)
const registerEventProvider = RegisterEventFamily();

/// See also [registerEvent].
class RegisterEventFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [registerEvent].
  const RegisterEventFamily();

  /// See also [registerEvent].
  RegisterEventProvider call(
    String eventId,
  ) {
    return RegisterEventProvider(
      eventId,
    );
  }

  @override
  RegisterEventProvider getProviderOverride(
    covariant RegisterEventProvider provider,
  ) {
    return call(
      provider.eventId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'registerEventProvider';
}

/// See also [registerEvent].
class RegisterEventProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [registerEvent].
  RegisterEventProvider(
    String eventId,
  ) : this._internal(
          (ref) => registerEvent(
            ref as RegisterEventRef,
            eventId,
          ),
          from: registerEventProvider,
          name: r'registerEventProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$registerEventHash,
          dependencies: RegisterEventFamily._dependencies,
          allTransitiveDependencies:
              RegisterEventFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  RegisterEventProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(RegisterEventRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegisterEventProvider._internal(
        (ref) => create(ref as RegisterEventRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _RegisterEventProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterEventProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RegisterEventRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _RegisterEventProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with RegisterEventRef {
  _RegisterEventProviderElement(super.provider);

  @override
  String get eventId => (origin as RegisterEventProvider).eventId;
}

String _$unregisterEventHash() => r'7344c7c7cc6d107f884f6557eba1b882abaa58c1';

/// See also [unregisterEvent].
@ProviderFor(unregisterEvent)
const unregisterEventProvider = UnregisterEventFamily();

/// See also [unregisterEvent].
class UnregisterEventFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [unregisterEvent].
  const UnregisterEventFamily();

  /// See also [unregisterEvent].
  UnregisterEventProvider call(
    String eventId,
  ) {
    return UnregisterEventProvider(
      eventId,
    );
  }

  @override
  UnregisterEventProvider getProviderOverride(
    covariant UnregisterEventProvider provider,
  ) {
    return call(
      provider.eventId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'unregisterEventProvider';
}

/// See also [unregisterEvent].
class UnregisterEventProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [unregisterEvent].
  UnregisterEventProvider(
    String eventId,
  ) : this._internal(
          (ref) => unregisterEvent(
            ref as UnregisterEventRef,
            eventId,
          ),
          from: unregisterEventProvider,
          name: r'unregisterEventProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$unregisterEventHash,
          dependencies: UnregisterEventFamily._dependencies,
          allTransitiveDependencies:
              UnregisterEventFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  UnregisterEventProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.eventId,
  }) : super.internal();

  final String eventId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(UnregisterEventRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UnregisterEventProvider._internal(
        (ref) => create(ref as UnregisterEventRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        eventId: eventId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _UnregisterEventProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UnregisterEventProvider && other.eventId == eventId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, eventId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UnregisterEventRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _UnregisterEventProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with UnregisterEventRef {
  _UnregisterEventProviderElement(super.provider);

  @override
  String get eventId => (origin as UnregisterEventProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
