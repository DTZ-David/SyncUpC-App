// ignore_for_file: dead_code
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/design_system/protons/colors.dart';
import '../utils/bottom_navigation.dart';

class MainNavigationWrapper extends ConsumerWidget {
  final Widget child;

  const MainNavigationWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool isAuthorized = true;

    return Scaffold(
      body: child,
      floatingActionButton: isAuthorized
          ? FloatingActionButton(
              backgroundColor: AppColors.white, // mismo que BottomAppBar
              onPressed: () {
                context.push('/register_event');
              },
              shape: const CircleBorder(), // asegura que sea circular
              elevation: 4, // sombra sutil, puedes ajustarla
              child: SvgPicture.asset(
                'assets/images/add_event.svg',
                width: 28,
                height: 28,
              ),
            )
          : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigation(isAuthorized: isAuthorized),
    );
  }
}
