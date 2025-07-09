
// core/router/app_router.dart
import 'package:chatapp/core/constants/route_constants.dart';
import 'package:chatapp/feature/auth/presentation/pages/login_page.dart';
import 'package:chatapp/feature/auth/presentation/providers/auth_provider.dart';
import 'package:chatapp/feature/chat/presentation/pages/chat_screen.dart';
import 'package:chatapp/feature/chat/presentation/pages/individual_chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Route constants
class AppRoutes {
  static const String initial = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String chat = '/chat';
  static const String individualChat = '/chat/:chatId';
  static const String newChat = '/chat/new';
}

final routerProvider = Provider<GoRouter>((ref) {
  final isAuthenticated = ref.watch(
    authProvider.select((state) => state.isAuthenticated),
  );

  return GoRouter(
    initialLocation: AppRoutes.initial,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isGoingToLogin = state.matchedLocation == AppRoutes.login;
      final isGoingToInitial = state.matchedLocation == AppRoutes.initial;

      // Already on login → do NOT redirect again
      if (!isAuthenticated && (isGoingToLogin || isGoingToInitial)) {
        return null;
      }

      // If trying to access protected page unauthenticated
      if (!isAuthenticated) {
        return AppRoutes.login;
      }

      // Redirect away from login if already logged in
      if (isAuthenticated && (isGoingToLogin || isGoingToInitial)) {
        return AppRoutes.home;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.initial,
        name: 'initial',
        redirect: (context, state) => isAuthenticated 
            ? AppRoutes.home 
            : AppRoutes.login,
      ),
      GoRoute(
        path: AppRoutes.login,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        name: 'home',
        builder: (context, state) => const ChatListScreen(),
        routes: [
          GoRoute(
            path: 'chat/:chatId',
            name: 'individual_chat',
            builder: (context, state) {
              final chatId = int.tryParse(state.pathParameters['chatId'] ?? '0') ?? 0;
              final chatName = state.uri.queryParameters['name'] ?? 'Unknown';
              final otherUserId = state.uri.queryParameters['otherUserId'] ?? '';
              
              return IndividualChatScreen(
                chatId: chatId,
                chatName: chatName,
                otherUserId: otherUserId,
              );
            },
          ),
          GoRoute(
            path: 'chat/new',
            name: 'new_chat',
            builder: (context, state) {
              final userId = state.uri.queryParameters['userId'] ?? '';
              final userName = state.uri.queryParameters['userName'] ?? '';
              
              return NewChatScreen(
                userId: userId,
                userName: userName,
              );
            },
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(
        title: const Text('Page Not Found'),
        backgroundColor: const Color(0xFF1C1C1C),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF1C1C1C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              '404',
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Page ${state.uri.path} not found',
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => context.go(AppRoutes.home),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00D4AA),
                foregroundColor: Colors.white,
              ),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});

// Navigation helpers
extension AppNavigator on BuildContext {
  void goToChat({
    required int chatId,
    required String chatName,
    required String otherUserId,
  }) {
    go('/home/chat/$chatId?name=$chatName&otherUserId=$otherUserId');
  }

  void goToNewChat({
    required String userId,
    required String userName,
  }) {
    go('/home/chat/new?userId=$userId&userName=$userName');
  }

  void goToHome() {
    go(AppRoutes.home);
  }

  void goToLogin() {
    go(AppRoutes.login);
  }
}

// Placeholder for NewChatScreen
class NewChatScreen extends StatelessWidget {
  final String userId;
  final String userName;

  const NewChatScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Chat'),
        backgroundColor: const Color(0xFF1C1C1C),
        foregroundColor: Colors.white,
      ),
      backgroundColor: const Color(0xFF1C1C1C),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Start a new chat with $userName',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.goToHome(),
              child: const Text('Go Back'),
            ),
          ],
        ),
      ),
    );
  }
}