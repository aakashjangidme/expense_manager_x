import 'package:expense_manager_x/app/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/current_page_index.dart';

class BottomNavigationWidget extends ConsumerStatefulWidget {
  const BottomNavigationWidget({super.key});

  @override
  ConsumerState<BottomNavigationWidget> createState() =>
      _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState
    extends ConsumerState<BottomNavigationWidget> {
  final List<NavDestination> _destinations = [
    NavDestination(
      selectedIcon: const Icon(Icons.home),
      icon: const Icon(Icons.home_outlined),
      label: 'Home',
      path: Routes.home,
    ),
    NavDestination(
      selectedIcon: const Icon(Icons.credit_card),
      icon: const Icon(Icons.credit_card_outlined),
      label: 'Accounts',
      path: Routes.accounts,
    ),
    NavDestination(
      selectedIcon: const Icon(Icons.developer_board),
      icon: const Icon(Icons.developer_board_outlined),
      label: 'Debts',
      path: Routes.debts,
    ),
    NavDestination(
      selectedIcon: const Icon(Icons.menu),
      icon: const Icon(Icons.menu_outlined),
      label: 'Overview',
      path: Routes.overview,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final int currentPageIndex = ref.watch(currentPageIndexProvider);

    return NavigationBar(
      elevation: 1,
      selectedIndex: currentPageIndex,
      onDestinationSelected: _onDestinationSelected,
      // indicatorColor: Colors.amber[800],
      destinations: <Widget>[..._destinations],
    );
  }

  void _onDestinationSelected(int index) {
    ref.read(currentPageIndexProvider.notifier).newIndex(index);
    context.go(_destinations[index].path!);
  }
}

class NavDestination extends NavigationDestination {
  const NavDestination(
      {super.key,
      required super.icon,
      super.selectedIcon,
      required super.label,
      this.path});

  final String? path;
}
