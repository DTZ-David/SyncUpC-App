// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$addEventFavHash() => r'f3d2b4f7dc1863f85b10d16707865bf6dc899887';

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

/// See also [addEventFav].
@ProviderFor(addEventFav)
const addEventFavProvider = AddEventFavFamily();

/// See also [addEventFav].
class AddEventFavFamily extends Family<AsyncValue<void>> {
  /// See also [addEventFav].
  const AddEventFavFamily();

  /// See also [addEventFav].
  AddEventFavProvider call(
    String eventId,
  ) {
    return AddEventFavProvider(
      eventId,
    );
  }

  @override
  AddEventFavProvider getProviderOverride(
    covariant AddEventFavProvider provider,
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
  String? get name => r'addEventFavProvider';
}

/// See also [addEventFav].
class AddEventFavProvider extends AutoDisposeFutureProvider<void> {
  /// See also [addEventFav].
  AddEventFavProvider(
    String eventId,
  ) : this._internal(
          (ref) => addEventFav(
            ref as AddEventFavRef,
            eventId,
          ),
          from: addEventFavProvider,
          name: r'addEventFavProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addEventFavHash,
          dependencies: AddEventFavFamily._dependencies,
          allTransitiveDependencies:
              AddEventFavFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  AddEventFavProvider._internal(
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
    FutureOr<void> Function(AddEventFavRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddEventFavProvider._internal(
        (ref) => create(ref as AddEventFavRef),
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
  AutoDisposeFutureProviderElement<void> createElement() {
    return _AddEventFavProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddEventFavProvider && other.eventId == eventId;
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
mixin AddEventFavRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _AddEventFavProviderElement extends AutoDisposeFutureProviderElement<void>
    with AddEventFavRef {
  _AddEventFavProviderElement(super.provider);

  @override
  String get eventId => (origin as AddEventFavProvider).eventId;
}

String _$getSavedEventsHash() => r'94ddb12d12c24dbe44b438b0d70fdd07047aba4e';

/// See also [getSavedEvents].
@ProviderFor(getSavedEvents)
final getSavedEventsProvider = FutureProvider<List<EventModel>>.internal(
  getSavedEvents,
  name: r'getSavedEventsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getSavedEventsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetSavedEventsRef = FutureProviderRef<List<EventModel>>;
String _$removeSavedEventsHash() => r'649f1d191fdeda0d55f69df37a6311ecb3a41e65';

/// See also [removeSavedEvents].
@ProviderFor(removeSavedEvents)
const removeSavedEventsProvider = RemoveSavedEventsFamily();

/// See also [removeSavedEvents].
class RemoveSavedEventsFamily extends Family<AsyncValue<void>> {
  /// See also [removeSavedEvents].
  const RemoveSavedEventsFamily();

  /// See also [removeSavedEvents].
  RemoveSavedEventsProvider call(
    String eventId,
  ) {
    return RemoveSavedEventsProvider(
      eventId,
    );
  }

  @override
  RemoveSavedEventsProvider getProviderOverride(
    covariant RemoveSavedEventsProvider provider,
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
  String? get name => r'removeSavedEventsProvider';
}

/// See also [removeSavedEvents].
class RemoveSavedEventsProvider extends AutoDisposeFutureProvider<void> {
  /// See also [removeSavedEvents].
  RemoveSavedEventsProvider(
    String eventId,
  ) : this._internal(
          (ref) => removeSavedEvents(
            ref as RemoveSavedEventsRef,
            eventId,
          ),
          from: removeSavedEventsProvider,
          name: r'removeSavedEventsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$removeSavedEventsHash,
          dependencies: RemoveSavedEventsFamily._dependencies,
          allTransitiveDependencies:
              RemoveSavedEventsFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  RemoveSavedEventsProvider._internal(
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
    FutureOr<void> Function(RemoveSavedEventsRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RemoveSavedEventsProvider._internal(
        (ref) => create(ref as RemoveSavedEventsRef),
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
  AutoDisposeFutureProviderElement<void> createElement() {
    return _RemoveSavedEventsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RemoveSavedEventsProvider && other.eventId == eventId;
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
mixin RemoveSavedEventsRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _RemoveSavedEventsProviderElement
    extends AutoDisposeFutureProviderElement<void> with RemoveSavedEventsRef {
  _RemoveSavedEventsProviderElement(super.provider);

  @override
  String get eventId => (origin as RemoveSavedEventsProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
