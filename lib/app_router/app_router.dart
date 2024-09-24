import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        AutoRoute(
          page: TabsRouterRoute.page,
          initial: true,
          children: <AutoRoute>[
            ..._mainScreenRoutes,
            ..._mealsListRoutes,
          ],
        ),
      ];

  List<AutoRoute> get _mainScreenRoutes => <AutoRoute>[
        AutoRoute(
          page: MainRootRoute.page,
          initial: true,
          children: <AutoRoute>[
            AutoRoute(page: MainRoute.page, initial: true),
            AutoRoute(page: AddMealRoute.page),
          ],
        ),
      ];

  List<AutoRoute> get _mealsListRoutes => <AutoRoute>[
        AutoRoute(
          page: AllMealsRoute.page,
        ),
      ];
}
