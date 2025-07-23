import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/design_system/protons/colors.dart';
import '../features/auth/providers/auth_providers.dart';
import '../utils/bottom_navigation.dart';

class MainNavigationWrapper extends ConsumerWidget {
  final Widget child;

  const MainNavigationWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    // Mientras el usuario aún no está cargado
    if (user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final isAuthorized = user.role == 'Student';

    return Scaffold(
      // Estas propiedades son clave para mantener el FAB fijo
      resizeToAvoidBottomInset: false, // Evita que el FAB suba con el teclado
      extendBody: true, // Permite que el body se extienda detrás del bottom nav

      body: child,

      floatingActionButton: isAuthorized
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
                  context.push('/register_event');
                },
                shape: const CircleBorder(),
                elevation:
                    0, // Quitamos la elevación default ya que usamos BoxShadow
                child: SvgPicture.asset(
                  'assets/images/add_event.svg',
                  width: 28,
                  height: 28,
                ),
              ),
            )
          : null,

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

      bottomNavigationBar: BottomNavigation(isAuthorized: isAuthorized),
    );
  }
}
