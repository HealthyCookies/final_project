// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:final_project/features/all_meals/presentation/screens/all_meals_screen.dart'
    as _i2;
import 'package:final_project/features/main/presentation/screens/add_meal_screen.dart'
    as _i1;
import 'package:final_project/features/main/presentation/screens/main_root_screen.dart'
    as _i3;
import 'package:final_project/features/main/presentation/screens/main_screen.dart'
    as _i4;
import 'package:final_project/features/main/presentation/screens/tabs_root_router.dart'
    as _i5;

/// generated route for
/// [_i1.AddMealScreen]
class AddMealRoute extends _i6.PageRouteInfo<void> {
  const AddMealRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AddMealRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddMealRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i1.AddMealScreen();
    },
  );
}

/// generated route for
/// [_i2.AllMealsScreen]
class AllMealsRoute extends _i6.PageRouteInfo<void> {
  const AllMealsRoute({List<_i6.PageRouteInfo>? children})
      : super(
          AllMealsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AllMealsRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i2.AllMealsScreen();
    },
  );
}

/// generated route for
/// [_i3.MainRootScreen]
class MainRootRoute extends _i6.PageRouteInfo<void> {
  const MainRootRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MainRootRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRootRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.MainRootScreen();
    },
  );
}

/// generated route for
/// [_i4.MainScreen]
class MainRoute extends _i6.PageRouteInfo<void> {
  const MainRoute({List<_i6.PageRouteInfo>? children})
      : super(
          MainRoute.name,
          initialChildren: children,
        );

  static const String name = 'MainRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.MainScreen();
    },
  );
}

/// generated route for
/// [_i5.TabsRouterScreen]
class TabsRouterRoute extends _i6.PageRouteInfo<void> {
  const TabsRouterRoute({List<_i6.PageRouteInfo>? children})
      : super(
          TabsRouterRoute.name,
          initialChildren: children,
        );

  static const String name = 'TabsRouterRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.TabsRouterScreen();
    },
  );
}
