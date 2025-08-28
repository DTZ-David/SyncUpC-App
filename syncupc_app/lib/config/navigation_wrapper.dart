import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:syncupc/design_system/protons/colors.dart';
import '../features/auth/providers/auth_providers.dart';
import '../ui/home/widgets/confirm_scan_dialog.dart';
import '../ui/registerEvent/screens/register_event_screen.dart';
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
                    onPressed: () async {
                      print('🔥 FloatingActionButton presionado');
                      try {
                        print('🔥 Intentando navegar con GoRouter');
                        await context.push('/register_event');
                        print('🔥 Navegación completada');
                      } catch (e) {
                        print('🔥 Error con GoRouter: $e');
                      }
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

        // FAB escáner flotando arriba a la derecha en toda la app
        Positioned(
          bottom: 80,
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
                    Navigator.of(context).pop();
                    // Mantener push para scanner ya que está fuera del ShellRoute
                    context.push('/scanner');
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
