// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'veilnet.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Veilnet {

 Conflux? get conflux; ConfluxSession? get session; IpLease? get ipLease;
/// Create a copy of Veilnet
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VeilnetCopyWith<Veilnet> get copyWith => _$VeilnetCopyWithImpl<Veilnet>(this as Veilnet, _$identity);

  /// Serializes this Veilnet to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Veilnet&&(identical(other.conflux, conflux) || other.conflux == conflux)&&(identical(other.session, session) || other.session == session)&&(identical(other.ipLease, ipLease) || other.ipLease == ipLease));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conflux,session,ipLease);

@override
String toString() {
  return 'Veilnet(conflux: $conflux, session: $session, ipLease: $ipLease)';
}


}

/// @nodoc
abstract mixin class $VeilnetCopyWith<$Res>  {
  factory $VeilnetCopyWith(Veilnet value, $Res Function(Veilnet) _then) = _$VeilnetCopyWithImpl;
@useResult
$Res call({
 Conflux? conflux, ConfluxSession? session, IpLease? ipLease
});


$ConfluxCopyWith<$Res>? get conflux;$ConfluxSessionCopyWith<$Res>? get session;$IpLeaseCopyWith<$Res>? get ipLease;

}
/// @nodoc
class _$VeilnetCopyWithImpl<$Res>
    implements $VeilnetCopyWith<$Res> {
  _$VeilnetCopyWithImpl(this._self, this._then);

  final Veilnet _self;
  final $Res Function(Veilnet) _then;

/// Create a copy of Veilnet
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? conflux = freezed,Object? session = freezed,Object? ipLease = freezed,}) {
  return _then(_self.copyWith(
conflux: freezed == conflux ? _self.conflux : conflux // ignore: cast_nullable_to_non_nullable
as Conflux?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as ConfluxSession?,ipLease: freezed == ipLease ? _self.ipLease : ipLease // ignore: cast_nullable_to_non_nullable
as IpLease?,
  ));
}
/// Create a copy of Veilnet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfluxCopyWith<$Res>? get conflux {
    if (_self.conflux == null) {
    return null;
  }

  return $ConfluxCopyWith<$Res>(_self.conflux!, (value) {
    return _then(_self.copyWith(conflux: value));
  });
}/// Create a copy of Veilnet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfluxSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $ConfluxSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of Veilnet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IpLeaseCopyWith<$Res>? get ipLease {
    if (_self.ipLease == null) {
    return null;
  }

  return $IpLeaseCopyWith<$Res>(_self.ipLease!, (value) {
    return _then(_self.copyWith(ipLease: value));
  });
}
}


/// Adds pattern-matching-related methods to [Veilnet].
extension VeilnetPatterns on Veilnet {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Veilnet value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Veilnet() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Veilnet value)  $default,){
final _that = this;
switch (_that) {
case _Veilnet():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Veilnet value)?  $default,){
final _that = this;
switch (_that) {
case _Veilnet() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( Conflux? conflux,  ConfluxSession? session,  IpLease? ipLease)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Veilnet() when $default != null:
return $default(_that.conflux,_that.session,_that.ipLease);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( Conflux? conflux,  ConfluxSession? session,  IpLease? ipLease)  $default,) {final _that = this;
switch (_that) {
case _Veilnet():
return $default(_that.conflux,_that.session,_that.ipLease);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( Conflux? conflux,  ConfluxSession? session,  IpLease? ipLease)?  $default,) {final _that = this;
switch (_that) {
case _Veilnet() when $default != null:
return $default(_that.conflux,_that.session,_that.ipLease);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Veilnet implements Veilnet {
   _Veilnet({this.conflux, this.session, this.ipLease});
  factory _Veilnet.fromJson(Map<String, dynamic> json) => _$VeilnetFromJson(json);

@override final  Conflux? conflux;
@override final  ConfluxSession? session;
@override final  IpLease? ipLease;

/// Create a copy of Veilnet
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VeilnetCopyWith<_Veilnet> get copyWith => __$VeilnetCopyWithImpl<_Veilnet>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VeilnetToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Veilnet&&(identical(other.conflux, conflux) || other.conflux == conflux)&&(identical(other.session, session) || other.session == session)&&(identical(other.ipLease, ipLease) || other.ipLease == ipLease));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,conflux,session,ipLease);

@override
String toString() {
  return 'Veilnet(conflux: $conflux, session: $session, ipLease: $ipLease)';
}


}

/// @nodoc
abstract mixin class _$VeilnetCopyWith<$Res> implements $VeilnetCopyWith<$Res> {
  factory _$VeilnetCopyWith(_Veilnet value, $Res Function(_Veilnet) _then) = __$VeilnetCopyWithImpl;
@override @useResult
$Res call({
 Conflux? conflux, ConfluxSession? session, IpLease? ipLease
});


@override $ConfluxCopyWith<$Res>? get conflux;@override $ConfluxSessionCopyWith<$Res>? get session;@override $IpLeaseCopyWith<$Res>? get ipLease;

}
/// @nodoc
class __$VeilnetCopyWithImpl<$Res>
    implements _$VeilnetCopyWith<$Res> {
  __$VeilnetCopyWithImpl(this._self, this._then);

  final _Veilnet _self;
  final $Res Function(_Veilnet) _then;

/// Create a copy of Veilnet
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? conflux = freezed,Object? session = freezed,Object? ipLease = freezed,}) {
  return _then(_Veilnet(
conflux: freezed == conflux ? _self.conflux : conflux // ignore: cast_nullable_to_non_nullable
as Conflux?,session: freezed == session ? _self.session : session // ignore: cast_nullable_to_non_nullable
as ConfluxSession?,ipLease: freezed == ipLease ? _self.ipLease : ipLease // ignore: cast_nullable_to_non_nullable
as IpLease?,
  ));
}

/// Create a copy of Veilnet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfluxCopyWith<$Res>? get conflux {
    if (_self.conflux == null) {
    return null;
  }

  return $ConfluxCopyWith<$Res>(_self.conflux!, (value) {
    return _then(_self.copyWith(conflux: value));
  });
}/// Create a copy of Veilnet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ConfluxSessionCopyWith<$Res>? get session {
    if (_self.session == null) {
    return null;
  }

  return $ConfluxSessionCopyWith<$Res>(_self.session!, (value) {
    return _then(_self.copyWith(session: value));
  });
}/// Create a copy of Veilnet
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$IpLeaseCopyWith<$Res>? get ipLease {
    if (_self.ipLease == null) {
    return null;
  }

  return $IpLeaseCopyWith<$Res>(_self.ipLease!, (value) {
    return _then(_self.copyWith(ipLease: value));
  });
}
}

// dart format on
