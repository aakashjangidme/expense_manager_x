import 'package:expense_manager_x/app/features/accounts/accounts.dart';
import 'package:expense_manager_x/app/features/debts/debts.dart';
import 'package:expense_manager_x/app/features/home/presentation/screens/home_screen.dart';
import 'package:expense_manager_x/app/features/overview/overview.dart';
import 'package:expense_manager_x/app/shared/widgets/scaffold_with_navbar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'routes.dart';

part 'router_config.g.dart';

final GlobalKey<NavigatorState> _rootNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigator =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

@riverpod
GoRouter goRouter(GoRouterRef ref) => _router;

final GoRouter _router = GoRouter(
  navigatorKey: _rootNavigator,
  initialLocation: '/home',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigator,
      builder: (context, state, child) =>
          ScaffoldWithNavbar(key: state.pageKey, child: child),
      routes: [
        GoRoute(
          path: Routes.home,
          name: Routes.home,
          parentNavigatorKey: _shellNavigator,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const HomeScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.accounts,
          name: Routes.accounts,
          parentNavigatorKey: _shellNavigator,
          pageBuilder: (context, state) {
            return NoTransitionPage(
              key: state.pageKey,
              child: const AccountsScreen(
                  // productId: int.parse(state.queryParameters['id']!),
                  ),
            );
          },
        ),
        GoRoute(
          path: Routes.debts,
          name: Routes.debts,
          parentNavigatorKey: _shellNavigator,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: DebtsScreen(),
            );
          },
        ),
        GoRoute(
          path: Routes.overview,
          name: Routes.overview,
          parentNavigatorKey: _shellNavigator,
          pageBuilder: (context, state) {
            return const NoTransitionPage(
              child: OverviewScreen(),
            );
          },
        ),
      ],
    )
  ],
);
