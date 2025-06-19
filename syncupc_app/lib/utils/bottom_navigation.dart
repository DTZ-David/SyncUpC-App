import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../design_system/protons/colors.dart';

class BottomNavigation extends ConsumerWidget {
  final bool isAuthorized;

  const BottomNavigation({super.key, this.isAuthorized = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final location = GoRouterState.of(context).uri.toString();

    int getCurrentIndex() {
      switch (location) {
        case '/':
          return 0;
        case '/search':
          return 1;
        case '/bookmarks':
          return 2;
        case '/settings':
          return 3;
        default:
          return 0;
      }
    }

    return BottomAppBar(
      shape: isAuthorized ? const CircularNotchedRectangle() : null,
      notchMargin: 8,
      elevation: 8,
      color: AppColors.white,
      child: SizedBox(
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: _buildNavItems(context, getCurrentIndex()),
        ),
      ),
    );
  }

  List<Widget> _buildNavItems(BuildContext context, int currentIndex) {
    final icons = [
      "assets/images/home.svg",
      "assets/images/search.svg",
      "assets/images/bookmark.svg",
      "assets/images/settings.svg"
    ];
    final routes = ['/', '/search', '/bookmarks', '/settings'];

    if (!isAuthorized) {
      return List.generate(icons.length, (i) {
        return _navIcon(context, i, currentIndex, icons[i], routes[i]);
      });
    }

    return [
      _navIcon(context, 0, currentIndex, icons[0], routes[0]),
      _navIcon(context, 1, currentIndex, icons[1], routes[1]),
      const SizedBox(width: 48), // espacio para el FAB
      _navIcon(context, 2, currentIndex, icons[2], routes[2]),
      _navIcon(context, 3, currentIndex, icons[3], routes[3]),
    ];
  }

  Widget _navIcon(BuildContext context, int index, int currentIndex,
      String asset, String route) {
    final isActive = currentIndex == index;

    return IconButton(
      onPressed: () {
        context.go(route);
      },
      icon: SvgPicture.asset(
        asset,
        width: 24,
        height: 24,
        colorFilter: ColorFilter.mode(
          isActive ? AppColors.primary200 : AppColors.neutral400,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
