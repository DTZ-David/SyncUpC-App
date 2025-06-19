import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncupc/design_system/molecules/search_bar.dart';
import 'package:syncupc/ui/home/exports/home.dart';
import 'package:syncupc/ui/home/widgets/home_events_for_u.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        elevation: 4,
        onPressed: () {},
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
                const HomeHeader(
                  userName: "Maria Gonzales",
                  location: "Valledupar",
                  profileImagePath: 'assets/images/profile.png',
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
