// ignore_for_file: avoid_print

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:syncupc/ui/bookmark/screens/bookmark_screen.dart';
import 'package:syncupc/ui/forum/screens/forum_post_screen.dart';
import 'package:syncupc/ui/forum/screens/forum_screen.dart';
import 'package:syncupc/ui/home/screens/event_details_screen.dart';
import 'package:syncupc/ui/home/screens/event_confirm_screen.dart';
import 'package:syncupc/ui/home/screens/scanner_screen.dart';
import 'package:syncupc/ui/registerEvent/screens/register_event_screen.dart';
import 'package:syncupc/ui/search/screens/search_screen.dart';
import 'package:syncupc/ui/settings/screens/edit_profile_screen.dart';
import 'package:syncupc/ui/settings/screens/history_screen.dart';
import 'package:syncupc/ui/settings/screens/settings_screen.dart';
import '../features/auth/controllers/login_controller.dart';
import '../features/home/models/event_model.dart';
import '../ui/forum/screens/create_topic_screen.dart';
import './exports/routing_for_provider.dart';
import './exports/pages_barrel.dart';
import './exports/design_system_barrel.dart';

part 'route_provider.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    initialLocation: '/splash',
    redirect: (context, state) {
      final authState = ref.read(loginControllerProvider);
      final currentPath = state.uri.path;

      print('🔥🔥🔥 REDIRECT - currentPath: $currentPath');
      print('🔥🔥🔥 REDIRECT - isAuthenticated: ${authState.isAuthenticated}');

      // 🔥 Si el usuario está autenticado y trata de ir a rutas de auth, redirigir al home
      if (authState.isAuthenticated) {
        if (currentPath == '/splash' ||
            currentPath == '/welcome' ||
            currentPath == '/login' ||
            currentPath == '/registerEmail' ||
            currentPath == '/registerPassword' ||
            currentPath.startsWith('/register/step/')) {
          // MÁS ESPECÍFICO
          print('🔥🔥🔥 REDIRECT - Redirigiendo a / desde auth route');
          return '/';
        }
      }

      // 🔥 Si no está autenticado y trata de ir a rutas protegidas, redirigir al splash
      if (!authState.isAuthenticated) {
        if (currentPath == '/' ||
            currentPath == '/search' ||
            currentPath == '/bookmarks' ||
            currentPath == '/settings') {
          print(
              '🔥🔥🔥 REDIRECT - Redirigiendo a /splash desde ruta protegida');
          return '/splash';
        }
      }

      print('🔥🔥🔥 REDIRECT - Resultado: null (sin redirección)');
      return null; // No redirect needed
    },
    routes: [
      // Rutas de autenticación (fuera del ShellRoute)
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

      // RUTAS INDEPENDIENTES (sin bottom navigation) - ANTES DEL SHELLROUTE
      GoRoute(
        path: '/register_event',
        name: 'registerEvent',
        builder: (context, state) {
          print('🔥🔥🔥 CONSTRUYENDO RegisterEventScreen');
          return const RegisterEventScreen();
        },
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
        path: '/event/forum',
        name: 'event-forum',
        builder: (context, state) {
          final event = state.extra as EventModel;
          return ForumScreen(event.id);
        },
      ),
      GoRoute(
        path: '/event/forum/createTopic',
        name: 'event-forum-createTopic',
        builder: (context, state) {
          final event = state.extra as String;
          return CreateTopicScreen(event);
        },
      ),
      GoRoute(
        path: '/event/forum/forumPostDetails',
        name: 'event-forum-id',
        builder: (context, state) {
          final forumId = state.extra as String;
          return ForumPostScreen(forumId: forumId);
        },
      ),
      GoRoute(
        path: '/event_confirm',
        name: 'event_confirm',
        builder: (context, state) {
          final eventTitle = state.extra as String;
          return EventConfirm(eventTitle);
        },
      ),
      GoRoute(
        path: '/scanner',
        name: 'scanner',
        builder: (context, state) => const ScannerScreen(),
      ),

      // ShellRoute para el layout principal con bottom navigation
      ShellRoute(
        builder: (context, state, child) {
          return MainNavigationWrapper(child: child);
        },
        routes: [
          // Rutas principales con bottom navigation
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
