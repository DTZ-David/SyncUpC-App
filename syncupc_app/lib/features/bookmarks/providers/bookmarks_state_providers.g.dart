// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bookmarks_state_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$initializeBookmarksHash() =>
    r'84ff4a29bc73ec481b3cd7a41e394851f444a488';

/// See also [initializeBookmarks].
@ProviderFor(initializeBookmarks)
final initializeBookmarksProvider = AutoDisposeFutureProvider<void>.internal(
  initializeBookmarks,
  name: r'initializeBookmarksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$initializeBookmarksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef InitializeBookmarksRef = AutoDisposeFutureProviderRef<void>;
String _$bookmarksStateHash() => r'98b26de41ac2eaa024e9eac6fe2f4b652b4a2a2e';

/// See also [BookmarksState].
@ProviderFor(BookmarksState)
final bookmarksStateProvider =
    NotifierProvider<BookmarksState, Set<String>>.internal(
  BookmarksState.new,
  name: r'bookmarksStateProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$bookmarksStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$BookmarksState = Notifier<Set<String>>;
String _$bookmarkToggleHash() => r'7ef7112b88a2b093c6715d0d992f100c50aedd44';

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

abstract class _$BookmarkToggle
    extends BuildlessAutoDisposeAsyncNotifier<void> {
  late final String eventId;

  FutureOr<void> build(
    String eventId,
  );
}

/// See also [BookmarkToggle].
@ProviderFor(BookmarkToggle)
const bookmarkToggleProvider = BookmarkToggleFamily();

/// See also [BookmarkToggle].
class BookmarkToggleFamily extends Family<AsyncValue<void>> {
  /// See also [BookmarkToggle].
  const BookmarkToggleFamily();

  /// See also [BookmarkToggle].
  BookmarkToggleProvider call(
    String eventId,
  ) {
    return BookmarkToggleProvider(
      eventId,
    );
  }

  @override
  BookmarkToggleProvider getProviderOverride(
    covariant BookmarkToggleProvider provider,
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
  String? get name => r'bookmarkToggleProvider';
}

/// See also [BookmarkToggle].
class BookmarkToggleProvider
    extends AutoDisposeAsyncNotifierProviderImpl<BookmarkToggle, void> {
  /// See also [BookmarkToggle].
  BookmarkToggleProvider(
    String eventId,
  ) : this._internal(
          () => BookmarkToggle()..eventId = eventId,
          from: bookmarkToggleProvider,
          name: r'bookmarkToggleProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$bookmarkToggleHash,
          dependencies: BookmarkToggleFamily._dependencies,
          allTransitiveDependencies:
              BookmarkToggleFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  BookmarkToggleProvider._internal(
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
  FutureOr<void> runNotifierBuild(
    covariant BookmarkToggle notifier,
  ) {
    return notifier.build(
      eventId,
    );
  }

  @override
  Override overrideWith(BookmarkToggle Function() create) {
    return ProviderOverride(
      origin: this,
      override: BookmarkToggleProvider._internal(
        () => create()..eventId = eventId,
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
  AutoDisposeAsyncNotifierProviderElement<BookmarkToggle, void>
      createElement() {
    return _BookmarkToggleProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is BookmarkToggleProvider && other.eventId == eventId;
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
mixin BookmarkToggleRef on AutoDisposeAsyncNotifierProviderRef<void> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _BookmarkToggleProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<BookmarkToggle, void>
    with BookmarkToggleRef {
  _BookmarkToggleProviderElement(super.provider);

  @override
  String get eventId => (origin as BookmarkToggleProvider).eventId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
