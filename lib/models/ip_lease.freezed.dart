// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ip_lease.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$IpLease {

 String get id; DateTime get created_at; String get user_id; String get plane_id; String get conflux_id; String get cidr; DateTime get renewed_at;
/// Create a copy of IpLease
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$IpLeaseCopyWith<IpLease> get copyWith => _$IpLeaseCopyWithImpl<IpLease>(this as IpLease, _$identity);

  /// Serializes this IpLease to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is IpLease&&(identical(other.id, id) || other.id == id)&&(identical(other.created_at, created_at) || other.created_at == created_at)&&(identical(other.user_id, user_id) || other.user_id == user_id)&&(identical(other.plane_id, plane_id) || other.plane_id == plane_id)&&(identical(other.conflux_id, conflux_id) || other.conflux_id == conflux_id)&&(identical(other.cidr, cidr) || other.cidr == cidr)&&(identical(other.renewed_at, renewed_at) || other.renewed_at == renewed_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,created_at,user_id,plane_id,conflux_id,cidr,renewed_at);

@override
String toString() {
  return 'IpLease(id: $id, created_at: $created_at, user_id: $user_id, plane_id: $plane_id, conflux_id: $conflux_id, cidr: $cidr, renewed_at: $renewed_at)';
}


}

/// @nodoc
abstract mixin class $IpLeaseCopyWith<$Res>  {
  factory $IpLeaseCopyWith(IpLease value, $Res Function(IpLease) _then) = _$IpLeaseCopyWithImpl;
@useResult
$Res call({
 String id, DateTime created_at, String user_id, String plane_id, String conflux_id, String cidr, DateTime renewed_at
});




}
/// @nodoc
class _$IpLeaseCopyWithImpl<$Res>
    implements $IpLeaseCopyWith<$Res> {
  _$IpLeaseCopyWithImpl(this._self, this._then);

  final IpLease _self;
  final $Res Function(IpLease) _then;

/// Create a copy of IpLease
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? created_at = null,Object? user_id = null,Object? plane_id = null,Object? conflux_id = null,Object? cidr = null,Object? renewed_at = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,created_at: null == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as DateTime,user_id: null == user_id ? _self.user_id : user_id // ignore: cast_nullable_to_non_nullable
as String,plane_id: null == plane_id ? _self.plane_id : plane_id // ignore: cast_nullable_to_non_nullable
as String,conflux_id: null == conflux_id ? _self.conflux_id : conflux_id // ignore: cast_nullable_to_non_nullable
as String,cidr: null == cidr ? _self.cidr : cidr // ignore: cast_nullable_to_non_nullable
as String,renewed_at: null == renewed_at ? _self.renewed_at : renewed_at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [IpLease].
extension IpLeasePatterns on IpLease {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _IpLease value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _IpLease() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _IpLease value)  $default,){
final _that = this;
switch (_that) {
case _IpLease():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _IpLease value)?  $default,){
final _that = this;
switch (_that) {
case _IpLease() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime created_at,  String user_id,  String plane_id,  String conflux_id,  String cidr,  DateTime renewed_at)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _IpLease() when $default != null:
return $default(_that.id,_that.created_at,_that.user_id,_that.plane_id,_that.conflux_id,_that.cidr,_that.renewed_at);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime created_at,  String user_id,  String plane_id,  String conflux_id,  String cidr,  DateTime renewed_at)  $default,) {final _that = this;
switch (_that) {
case _IpLease():
return $default(_that.id,_that.created_at,_that.user_id,_that.plane_id,_that.conflux_id,_that.cidr,_that.renewed_at);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime created_at,  String user_id,  String plane_id,  String conflux_id,  String cidr,  DateTime renewed_at)?  $default,) {final _that = this;
switch (_that) {
case _IpLease() when $default != null:
return $default(_that.id,_that.created_at,_that.user_id,_that.plane_id,_that.conflux_id,_that.cidr,_that.renewed_at);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _IpLease implements IpLease {
   _IpLease({required this.id, required this.created_at, required this.user_id, required this.plane_id, required this.conflux_id, required this.cidr, required this.renewed_at});
  factory _IpLease.fromJson(Map<String, dynamic> json) => _$IpLeaseFromJson(json);

@override final  String id;
@override final  DateTime created_at;
@override final  String user_id;
@override final  String plane_id;
@override final  String conflux_id;
@override final  String cidr;
@override final  DateTime renewed_at;

/// Create a copy of IpLease
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$IpLeaseCopyWith<_IpLease> get copyWith => __$IpLeaseCopyWithImpl<_IpLease>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$IpLeaseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _IpLease&&(identical(other.id, id) || other.id == id)&&(identical(other.created_at, created_at) || other.created_at == created_at)&&(identical(other.user_id, user_id) || other.user_id == user_id)&&(identical(other.plane_id, plane_id) || other.plane_id == plane_id)&&(identical(other.conflux_id, conflux_id) || other.conflux_id == conflux_id)&&(identical(other.cidr, cidr) || other.cidr == cidr)&&(identical(other.renewed_at, renewed_at) || other.renewed_at == renewed_at));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,created_at,user_id,plane_id,conflux_id,cidr,renewed_at);

@override
String toString() {
  return 'IpLease(id: $id, created_at: $created_at, user_id: $user_id, plane_id: $plane_id, conflux_id: $conflux_id, cidr: $cidr, renewed_at: $renewed_at)';
}


}

/// @nodoc
abstract mixin class _$IpLeaseCopyWith<$Res> implements $IpLeaseCopyWith<$Res> {
  factory _$IpLeaseCopyWith(_IpLease value, $Res Function(_IpLease) _then) = __$IpLeaseCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime created_at, String user_id, String plane_id, String conflux_id, String cidr, DateTime renewed_at
});




}
/// @nodoc
class __$IpLeaseCopyWithImpl<$Res>
    implements _$IpLeaseCopyWith<$Res> {
  __$IpLeaseCopyWithImpl(this._self, this._then);

  final _IpLease _self;
  final $Res Function(_IpLease) _then;

/// Create a copy of IpLease
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? created_at = null,Object? user_id = null,Object? plane_id = null,Object? conflux_id = null,Object? cidr = null,Object? renewed_at = null,}) {
  return _then(_IpLease(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,created_at: null == created_at ? _self.created_at : created_at // ignore: cast_nullable_to_non_nullable
as DateTime,user_id: null == user_id ? _self.user_id : user_id // ignore: cast_nullable_to_non_nullable
as String,plane_id: null == plane_id ? _self.plane_id : plane_id // ignore: cast_nullable_to_non_nullable
as String,conflux_id: null == conflux_id ? _self.conflux_id : conflux_id // ignore: cast_nullable_to_non_nullable
as String,cidr: null == cidr ? _self.cidr : cidr // ignore: cast_nullable_to_non_nullable
as String,renewed_at: null == renewed_at ? _self.renewed_at : renewed_at // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
