// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_info_notifier.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$DailyInfoState {
  List<Meal> get meals => throw _privateConstructorUsedError;
  bool get loading => throw _privateConstructorUsedError;

  /// Create a copy of DailyInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DailyInfoStateCopyWith<DailyInfoState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DailyInfoStateCopyWith<$Res> {
  factory $DailyInfoStateCopyWith(
          DailyInfoState value, $Res Function(DailyInfoState) then) =
      _$DailyInfoStateCopyWithImpl<$Res, DailyInfoState>;
  @useResult
  $Res call({List<Meal> meals, bool loading});
}

/// @nodoc
class _$DailyInfoStateCopyWithImpl<$Res, $Val extends DailyInfoState>
    implements $DailyInfoStateCopyWith<$Res> {
  _$DailyInfoStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DailyInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meals = null,
    Object? loading = null,
  }) {
    return _then(_value.copyWith(
      meals: null == meals
          ? _value.meals
          : meals // ignore: cast_nullable_to_non_nullable
              as List<Meal>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$DailyInfoStateImplCopyWith<$Res>
    implements $DailyInfoStateCopyWith<$Res> {
  factory _$$DailyInfoStateImplCopyWith(_$DailyInfoStateImpl value,
          $Res Function(_$DailyInfoStateImpl) then) =
      __$$DailyInfoStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Meal> meals, bool loading});
}

/// @nodoc
class __$$DailyInfoStateImplCopyWithImpl<$Res>
    extends _$DailyInfoStateCopyWithImpl<$Res, _$DailyInfoStateImpl>
    implements _$$DailyInfoStateImplCopyWith<$Res> {
  __$$DailyInfoStateImplCopyWithImpl(
      _$DailyInfoStateImpl _value, $Res Function(_$DailyInfoStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of DailyInfoState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? meals = null,
    Object? loading = null,
  }) {
    return _then(_$DailyInfoStateImpl(
      meals: null == meals
          ? _value._meals
          : meals // ignore: cast_nullable_to_non_nullable
              as List<Meal>,
      loading: null == loading
          ? _value.loading
          : loading // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$DailyInfoStateImpl implements _DailyInfoState {
  const _$DailyInfoStateImpl(
      {required final List<Meal> meals, required this.loading})
      : _meals = meals;

  final List<Meal> _meals;
  @override
  List<Meal> get meals {
    if (_meals is EqualUnmodifiableListView) return _meals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_meals);
  }

  @override
  final bool loading;

  @override
  String toString() {
    return 'DailyInfoState(meals: $meals, loading: $loading)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DailyInfoStateImpl &&
            const DeepCollectionEquality().equals(other._meals, _meals) &&
            (identical(other.loading, loading) || other.loading == loading));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_meals), loading);

  /// Create a copy of DailyInfoState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DailyInfoStateImplCopyWith<_$DailyInfoStateImpl> get copyWith =>
      __$$DailyInfoStateImplCopyWithImpl<_$DailyInfoStateImpl>(
          this, _$identity);
}

abstract class _DailyInfoState implements DailyInfoState {
  const factory _DailyInfoState(
      {required final List<Meal> meals,
      required final bool loading}) = _$DailyInfoStateImpl;

  @override
  List<Meal> get meals;
  @override
  bool get loading;

  /// Create a copy of DailyInfoState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DailyInfoStateImplCopyWith<_$DailyInfoStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
