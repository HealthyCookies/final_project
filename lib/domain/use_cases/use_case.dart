import 'package:freezed_annotation/freezed_annotation.dart';

/// R - return type, T - param type
abstract interface class UseCase<R, T> {
  @mustBeOverridden
  R execute(T param);
}
