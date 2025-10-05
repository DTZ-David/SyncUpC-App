// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/design_system/protons/colors.dart';
import '../features/auth/providers/auth_providers.dart';
import '../ui/home/widgets/confirm_scan_dialog.dart';
import '../utils/bottom_navigation.dart';

class MainNavigationWrapper extends ConsumerStatefulWidget {
  final Widget child;

  const MainNavigationWrapper({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<MainNavigationWrapper> createState() => _MainNavigationWrapperState();
}

class _MainNavigationWrapperState extends ConsumerState<MainNavigationWrapper> {
  bool _isNavigatingToRegister = false;
  bool _isNavigatingToScanner = false;

  // 🔥 Rutas donde NO deben aparecer los FABs
  bool _shouldHideFABs(String currentRoute) {
    final hiddenRoutes = [
      '/register_event',
      '/scanner',
      '/event/details',
      '/event/forum',
      '/event/forum/createTopic',
      '/event/forum/forumPostDetails',
      '/event_confirm',
      '/edit_profile',
    ];

    return hiddenRoutes.any((route) => currentRoute.startsWith(route));
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final currentRoute = GoRouterState.of(context).uri.path;
    final shouldHideFABs = _shouldHideFABs(currentRoute);

    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isAuthorized = user.role == 'StaffMember';

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          extendBody: true,
          body: widget.child,
          floatingActionButton: (isAuthorized && !shouldHideFABs && !_isNavigatingToRegister)
              ? Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: FloatingActionButton(
                    backgroundColor: AppColors.white,
                    onPressed: () {
                      if (_isNavigatingToRegister) return;
                      print('🔥 FAB Register Event - Navegando a /register_event');
                      setState(() => _isNavigatingToRegister = true);
                      context.pushNamed('registerEvent').then((_) {
                        if (mounted) {
                          setState(() => _isNavigatingToRegister = false);
                        }
                      });
                    },
                    shape: const CircleBorder(),
                    elevation: 0,
                    child: SvgPicture.asset(
                      'assets/images/add_event.svg',
                      width: 28,
                      height: 28,
                    ),
                  ),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          bottomNavigationBar: BottomNavigation(isAuthorized: isAuthorized),
        ),

        // 🔥 FAB escáner - Solo mostrar si no debe estar oculto
        if (!shouldHideFABs && !_isNavigatingToScanner)
          Positioned(
            bottom: 120,
            right: 16,
            child: FloatingActionButton(
              heroTag: 'scanner',
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              elevation: 4,
              onPressed: () {
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (context) => ConfirmScanDialog(
                    onCancel: () => Navigator.of(context).pop(),
                    onContinue: () {
                      if (_isNavigatingToScanner) return;
                      Navigator.of(context).pop();
                      print('🔥 FAB Scanner - Navegando a /scanner');
                      setState(() => _isNavigatingToScanner = true);
                      context.pushNamed('scanner').then((_) {
                        if (mounted) {
                          setState(() => _isNavigatingToScanner = false);
                        }
                      });
                    },
                  ),
                );
              },
              child: SvgPicture.asset(
                'assets/images/scanner.svg',
                width: 28,
                height: 28,
              ),
            ),
          ),
      ],
    );
  }
}
