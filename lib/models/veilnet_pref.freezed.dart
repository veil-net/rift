// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'veilnet_pref.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VeilnetPref {

 String? get name; String? get planeID;
/// Create a copy of VeilnetPref
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VeilnetPrefCopyWith<VeilnetPref> get copyWith => _$VeilnetPrefCopyWithImpl<VeilnetPref>(this as VeilnetPref, _$identity);

  /// Serializes this VeilnetPref to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VeilnetPref&&(identical(other.name, name) || other.name == name)&&(identical(other.planeID, planeID) || other.planeID == planeID));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,planeID);

@override
String toString() {
  return 'VeilnetPref(name: $name, planeID: $planeID)';
}


}

/// @nodoc
abstract mixin class $VeilnetPrefCopyWith<$Res>  {
  factory $VeilnetPrefCopyWith(VeilnetPref value, $Res Function(VeilnetPref) _then) = _$VeilnetPrefCopyWithImpl;
@useResult
$Res call({
 String? name, String? planeID
});




}
/// @nodoc
class _$VeilnetPrefCopyWithImpl<$Res>
    implements $VeilnetPrefCopyWith<$Res> {
  _$VeilnetPrefCopyWithImpl(this._self, this._then);

  final VeilnetPref _self;
  final $Res Function(VeilnetPref) _then;

/// Create a copy of VeilnetPref
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? planeID = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,planeID: freezed == planeID ? _self.planeID : planeID // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VeilnetPref].
extension VeilnetPrefPatterns on VeilnetPref {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VeilnetPref value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VeilnetPref() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VeilnetPref value)  $default,){
final _that = this;
switch (_that) {
case _VeilnetPref():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VeilnetPref value)?  $default,){
final _that = this;
switch (_that) {
case _VeilnetPref() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? planeID)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VeilnetPref() when $default != null:
return $default(_that.name,_that.planeID);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? planeID)  $default,) {final _that = this;
switch (_that) {
case _VeilnetPref():
return $default(_that.name,_that.planeID);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? planeID)?  $default,) {final _that = this;
switch (_that) {
case _VeilnetPref() when $default != null:
return $default(_that.name,_that.planeID);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VeilnetPref implements VeilnetPref {
   _VeilnetPref({this.name, this.planeID});
  factory _VeilnetPref.fromJson(Map<String, dynamic> json) => _$VeilnetPrefFromJson(json);

@override final  String? name;
@override final  String? planeID;

/// Create a copy of VeilnetPref
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VeilnetPrefCopyWith<_VeilnetPref> get copyWith => __$VeilnetPrefCopyWithImpl<_VeilnetPref>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VeilnetPrefToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VeilnetPref&&(identical(other.name, name) || other.name == name)&&(identical(other.planeID, planeID) || other.planeID == planeID));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,planeID);

@override
String toString() {
  return 'VeilnetPref(name: $name, planeID: $planeID)';
}


}

/// @nodoc
abstract mixin class _$VeilnetPrefCopyWith<$Res> implements $VeilnetPrefCopyWith<$Res> {
  factory _$VeilnetPrefCopyWith(_VeilnetPref value, $Res Function(_VeilnetPref) _then) = __$VeilnetPrefCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? planeID
});




}
/// @nodoc
class __$VeilnetPrefCopyWithImpl<$Res>
    implements _$VeilnetPrefCopyWith<$Res> {
  __$VeilnetPrefCopyWithImpl(this._self, this._then);

  final _VeilnetPref _self;
  final $Res Function(_VeilnetPref) _then;

/// Create a copy of VeilnetPref
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? planeID = freezed,}) {
  return _then(_VeilnetPref(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,planeID: freezed == planeID ? _self.planeID : planeID // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
