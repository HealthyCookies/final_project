import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app_router/app_router.gr.dart';

@RoutePage()
class TabsRouterScreen extends StatelessWidget {
  const TabsRouterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const <PageRouteInfo>[
        MainRoute(),
        AllMealsRoute(),
      ],
      // ignore: always_specify_types
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              label: 'Main',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Meals',
              icon: Icon(Icons.list_rounded),
            ),
          ],
        );
      },
    );
  }
}
