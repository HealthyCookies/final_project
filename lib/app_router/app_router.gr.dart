// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:final_project/features/main/presentation/screens/add_meal_screen.dart'
    as _i1;
import 'package:final_project/features/main/presentation/screens/main_screen.dart'
    as _i2;

/// generated route for
/// [_i1.AddMealScreen]
class AddMealRoute extends _i3.PageRouteInfo<void> {
  const AddMealRoute({List<_i3.PageRouteInfo>? children})
      : super(
          AddMealRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddMealRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddMealScreen();
    },
  );
}

/// generated route for
/// [_i2.MainScreen]
class MainRoute extends _i3.PageRouteInfo<void> {
  const MainRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i3.PageInfo page = _i3.PageInfo(
    name,
    builder: (data) {
      return const _i2.MainScreen();
    },
  );
}
