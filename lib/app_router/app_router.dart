import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => <AutoRoute>[
        ..._mainScreenRoutes,
      ];

  List<AutoRoute> get _mainScreenRoutes => <AutoRoute>[
        AutoRoute(page: MainRoute.page, initial: true),
      ];
}
