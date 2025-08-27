// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forum_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getalltopicsforeventHash() =>
    r'ba8892d14bbaa9c4c38dc95b007939f917b06ee3';

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

/// See also [getalltopicsforevent].
@ProviderFor(getalltopicsforevent)
const getalltopicsforeventProvider = GetalltopicsforeventFamily();

/// See also [getalltopicsforevent].
class GetalltopicsforeventFamily extends Family<AsyncValue<List<ForumModel>>> {
  /// See also [getalltopicsforevent].
  const GetalltopicsforeventFamily();

  /// See also [getalltopicsforevent].
  GetalltopicsforeventProvider call(
    String eventId,
  ) {
    return GetalltopicsforeventProvider(
      eventId,
    );
  }

  @override
  GetalltopicsforeventProvider getProviderOverride(
    covariant GetalltopicsforeventProvider provider,
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
  String? get name => r'getalltopicsforeventProvider';
}

/// See also [getalltopicsforevent].
class GetalltopicsforeventProvider
    extends AutoDisposeFutureProvider<List<ForumModel>> {
  /// See also [getalltopicsforevent].
  GetalltopicsforeventProvider(
    String eventId,
  ) : this._internal(
          (ref) => getalltopicsforevent(
            ref as GetalltopicsforeventRef,
            eventId,
          ),
          from: getalltopicsforeventProvider,
          name: r'getalltopicsforeventProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getalltopicsforeventHash,
          dependencies: GetalltopicsforeventFamily._dependencies,
          allTransitiveDependencies:
              GetalltopicsforeventFamily._allTransitiveDependencies,
          eventId: eventId,
        );

  GetalltopicsforeventProvider._internal(
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
    FutureOr<List<ForumModel>> Function(GetalltopicsforeventRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetalltopicsforeventProvider._internal(
        (ref) => create(ref as GetalltopicsforeventRef),
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
  AutoDisposeFutureProviderElement<List<ForumModel>> createElement() {
    return _GetalltopicsforeventProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetalltopicsforeventProvider && other.eventId == eventId;
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
mixin GetalltopicsforeventRef
    on AutoDisposeFutureProviderRef<List<ForumModel>> {
  /// The parameter `eventId` of this provider.
  String get eventId;
}

class _GetalltopicsforeventProviderElement
    extends AutoDisposeFutureProviderElement<List<ForumModel>>
    with GetalltopicsforeventRef {
  _GetalltopicsforeventProviderElement(super.provider);

  @override
  String get eventId => (origin as GetalltopicsforeventProvider).eventId;
}

String _$registerForumTopicHash() =>
    r'e3e3efe20a01c658b68d3b070a6b9df35dfb987b';

/// See also [registerForumTopic].
@ProviderFor(registerForumTopic)
const registerForumTopicProvider = RegisterForumTopicFamily();

/// See also [registerForumTopic].
class RegisterForumTopicFamily extends Family<AsyncValue<void>> {
  /// See also [registerForumTopic].
  const RegisterForumTopicFamily();

  /// See also [registerForumTopic].
  RegisterForumTopicProvider call(
    ForumRequest request,
  ) {
    return RegisterForumTopicProvider(
      request,
    );
  }

  @override
  RegisterForumTopicProvider getProviderOverride(
    covariant RegisterForumTopicProvider provider,
  ) {
    return call(
      provider.request,
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
  String? get name => r'registerForumTopicProvider';
}

/// See also [registerForumTopic].
class RegisterForumTopicProvider extends AutoDisposeFutureProvider<void> {
  /// See also [registerForumTopic].
  RegisterForumTopicProvider(
    ForumRequest request,
  ) : this._internal(
          (ref) => registerForumTopic(
            ref as RegisterForumTopicRef,
            request,
          ),
          from: registerForumTopicProvider,
          name: r'registerForumTopicProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$registerForumTopicHash,
          dependencies: RegisterForumTopicFamily._dependencies,
          allTransitiveDependencies:
              RegisterForumTopicFamily._allTransitiveDependencies,
          request: request,
        );

  RegisterForumTopicProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final ForumRequest request;

  @override
  Override overrideWith(
    FutureOr<void> Function(RegisterForumTopicRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegisterForumTopicProvider._internal(
        (ref) => create(ref as RegisterForumTopicRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _RegisterForumTopicProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterForumTopicProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RegisterForumTopicRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `request` of this provider.
  ForumRequest get request;
}

class _RegisterForumTopicProviderElement
    extends AutoDisposeFutureProviderElement<void> with RegisterForumTopicRef {
  _RegisterForumTopicProviderElement(super.provider);

  @override
  ForumRequest get request => (origin as RegisterForumTopicProvider).request;
}

String _$addcommentHash() => r'c854aa2f0337258c43be34b05885808f956f6898';

/// See also [addcomment].
@ProviderFor(addcomment)
const addcommentProvider = AddcommentFamily();

/// See also [addcomment].
class AddcommentFamily extends Family<AsyncValue<void>> {
  /// See also [addcomment].
  const AddcommentFamily();

  /// See also [addcomment].
  AddcommentProvider call(
    CommentRequest request,
  ) {
    return AddcommentProvider(
      request,
    );
  }

  @override
  AddcommentProvider getProviderOverride(
    covariant AddcommentProvider provider,
  ) {
    return call(
      provider.request,
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
  String? get name => r'addcommentProvider';
}

/// See also [addcomment].
class AddcommentProvider extends AutoDisposeFutureProvider<void> {
  /// See also [addcomment].
  AddcommentProvider(
    CommentRequest request,
  ) : this._internal(
          (ref) => addcomment(
            ref as AddcommentRef,
            request,
          ),
          from: addcommentProvider,
          name: r'addcommentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$addcommentHash,
          dependencies: AddcommentFamily._dependencies,
          allTransitiveDependencies:
              AddcommentFamily._allTransitiveDependencies,
          request: request,
        );

  AddcommentProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.request,
  }) : super.internal();

  final CommentRequest request;

  @override
  Override overrideWith(
    FutureOr<void> Function(AddcommentRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AddcommentProvider._internal(
        (ref) => create(ref as AddcommentRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        request: request,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _AddcommentProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AddcommentProvider && other.request == request;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, request.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin AddcommentRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `request` of this provider.
  CommentRequest get request;
}

class _AddcommentProviderElement extends AutoDisposeFutureProviderElement<void>
    with AddcommentRef {
  _AddcommentProviderElement(super.provider);

  @override
  CommentRequest get request => (origin as AddcommentProvider).request;
}

String _$getForumByIdHash() => r'41349ff5d15b819ea85d05434fa150b247d6351d';

/// See also [getForumById].
@ProviderFor(getForumById)
const getForumByIdProvider = GetForumByIdFamily();

/// See also [getForumById].
class GetForumByIdFamily extends Family<AsyncValue<ForumModel>> {
  /// See also [getForumById].
  const GetForumByIdFamily();

  /// See also [getForumById].
  GetForumByIdProvider call(
    String forumId,
  ) {
    return GetForumByIdProvider(
      forumId,
    );
  }

  @override
  GetForumByIdProvider getProviderOverride(
    covariant GetForumByIdProvider provider,
  ) {
    return call(
      provider.forumId,
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
  String? get name => r'getForumByIdProvider';
}

/// See also [getForumById].
class GetForumByIdProvider extends AutoDisposeFutureProvider<ForumModel> {
  /// See also [getForumById].
  GetForumByIdProvider(
    String forumId,
  ) : this._internal(
          (ref) => getForumById(
            ref as GetForumByIdRef,
            forumId,
          ),
          from: getForumByIdProvider,
          name: r'getForumByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getForumByIdHash,
          dependencies: GetForumByIdFamily._dependencies,
          allTransitiveDependencies:
              GetForumByIdFamily._allTransitiveDependencies,
          forumId: forumId,
        );

  GetForumByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.forumId,
  }) : super.internal();

  final String forumId;

  @override
  Override overrideWith(
    FutureOr<ForumModel> Function(GetForumByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetForumByIdProvider._internal(
        (ref) => create(ref as GetForumByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        forumId: forumId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ForumModel> createElement() {
    return _GetForumByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetForumByIdProvider && other.forumId == forumId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, forumId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetForumByIdRef on AutoDisposeFutureProviderRef<ForumModel> {
  /// The parameter `forumId` of this provider.
  String get forumId;
}

class _GetForumByIdProviderElement
    extends AutoDisposeFutureProviderElement<ForumModel> with GetForumByIdRef {
  _GetForumByIdProviderElement(super.provider);

  @override
  String get forumId => (origin as GetForumByIdProvider).forumId;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
