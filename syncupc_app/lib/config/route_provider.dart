import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/ui/search/screens/search_screen.dart';
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
        builder: (context, state) => const LoginScreen(),
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
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: '/settings',
            name: 'settings',
            builder: (context, state) => const ProfilePage(),
          ),
        ],
      ),

      // Otras rutas independientes
      GoRoute(
        path: '/event/:id',
        name: 'event-detail',
        builder: (context, state) {
          final eventId = state.pathParameters['id']!;
          return EventDetailPage(eventId: eventId);
        },
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
