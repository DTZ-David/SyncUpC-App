import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/config/exports/routing.dart';
import 'package:syncupc/design_system/molecules/search_bar.dart';
import 'package:syncupc/ui/home/exports/home.dart';
import 'package:syncupc/ui/home/widgets/confirm_scan_dialog.dart';
import 'package:syncupc/ui/home/widgets/home_events_for_u.dart';

import '../../../features/auth/providers/auth_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: null,
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HomeHeader(
                  userName: user?.name ?? 'Invitado',
                  location: "Valledupar",
                  profileImagePath:
                      user?.photo ?? 'assets/images/default_avatar.png',
                ),
                const SizedBox(height: 24),
                const SearchBarDesign(filter: true),
                const SizedBox(height: 24),
                const HomeCategories(),
                const SizedBox(height: 12),
                HomeEventsSection(
                  title: "Eventos Cercanos",
                  events: MockEvents.nearbyEvents,
                ),
                const SizedBox(height: 12),
                HomeEventsForU(
                  title: "Eventos Cercanos",
                  events: MockEvents.nearbyEvents,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
