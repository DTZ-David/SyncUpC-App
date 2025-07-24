import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/ui/bookmark/screens/bookmark_screen.dart';
import 'package:syncupc/ui/home/screens/event_details_screen.dart';
import 'package:syncupc/ui/home/screens/event_confirm_screen.dart';
import 'package:syncupc/ui/home/screens/scanner_screen.dart';
import 'package:syncupc/ui/registerEvent/screens/register_event_screen.dart';
import 'package:syncupc/ui/search/screens/search_screen.dart';
import 'package:syncupc/ui/settings/screens/edit_profile_screen.dart';
import 'package:syncupc/ui/settings/screens/history_screen.dart';
import 'package:syncupc/ui/settings/screens/settings_screen.dart';
import '../features/home/models/event_model.dart';
import './exports/routing_for_provider.dart';
import './exports/pages_barrel.dart';
import './exports/design_system_barrel.dart';

part 'route_provider.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      // Mueve splash aquí
      GoRoute(
        path: '/splash',
        builder: (context, state) => const AnimatedSplashScreen(),
      ),
      GoRoute(
        path: '/welcome',
        name: 'welcome',
        builder: (context, state) => const AuthWelcomeScreen(),
      ),
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/registerEmail',
        name: 'registerEmail',
        builder: (context, state) => const RegisterEmailScreen(),
      ),
      GoRoute(
        path: '/registerPassword',
        name: 'registerPassword',
        builder: (context, state) => const RegisterPasswordScreen(),
      ),
      GoRoute(
        path: '/register/step/:stepNumber',
        name: 'registerStep',
        builder: (context, state) {
          final stepNumber =
              int.tryParse(state.pathParameters['stepNumber'] ?? '1') ?? 1;

          switch (stepNumber) {
            case 1:
              return const RegisterProfileInfoScreen();
            case 2:
              return const RegisterProfileCollegeInfoScreen();
            case 3:
              return const RegisterProfileNotificationsPreferencesScreen();
            default:
              return const RegisterProfileInfoScreen();
          }
        },
      ),
      // Mantén el ShellRoute para el layout principal
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigationWrapper(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/search',
            name: 'search',
            builder: (context, state) => const SearchScreen(),
          ),
          GoRoute(
            path: '/bookmarks',
            name: 'bookmarks',
            builder: (context, state) => const BookmarkScreen(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const SettingsScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/event/details',
        name: 'event-detail',
        builder: (context, state) {
          final event = state.extra as EventModel;
          return EventDetailsScreen(event);
        },
      ),

      GoRoute(
        path: '/event_confirm',
        name: 'event_confirm',
        builder: (context, state) {
          //final eventId = state.pathParameters['id']!;
          return EventConfirm();
        },
      ),
      GoRoute(
        path: '/scanner',
        name: 'scanner',
        builder: (context, state) => const ScannerScreen(),
      ),
      GoRoute(
        path: '/register_event',
        name: 'registerEvent',
        builder: (context, state) => const RegisterEventScreen(),
      ),
      GoRoute(
        path: '/edit_profile',
        name: 'editProfile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/history',
        name: 'history',
        builder: (context, state) => const HistoryScreen(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text('Página no encontrada',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text('La página que buscas no existe',
                style: Theme.of(context).textTheme.bodyMedium),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Ir al inicio'),
            ),
          ],
        ),
      ),
    ),
  );
}
