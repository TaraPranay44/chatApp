import 'package:chatapp/core/constants/route_constants.dart';
import 'package:chatapp/feature/auth/presentation/pages/login_page.dart';
import 'package:chatapp/feature/auth/presentation/providers/auth_provider.dart';
import 'package:chatapp/feature/chat/presentation/pages/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final routerProvider = Provider<GoRouter>((ref) {
  // Only watch isAuthenticated - remove isVerifyingOtp from router logic
  final isAuthenticated = ref.watch(
    authProvider.select((state) => state.isAuthenticated),
  );

  return GoRouter(
    initialLocation: RouteConstants.initialRoute,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isGoingToLogin = state.matchedLocation == RouteConstants.loginRoute;
      final isGoingToInitial =
          state.matchedLocation == RouteConstants.initialRoute;

      // 🛑 Already on login → do NOT redirect again
      if (!isAuthenticated && (isGoingToLogin || isGoingToInitial)) {
        return null;
      }

      // 🔒 If trying to access protected page unauthenticated
      if (!isAuthenticated) {
        return RouteConstants.loginRoute;
      }

      // 🏠 Redirect away from login if already logged in
      if (isAuthenticated && (isGoingToLogin || isGoingToInitial)) {
        return RouteConstants.homeRoute;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RouteConstants.homeRoute,
        name: 'home',
        builder: (context, state) => const ChatListScreen(),
      ),
      GoRoute(
        path: RouteConstants.loginRoute,
        name: 'login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteConstants.initialRoute,
        name: 'initial',
        redirect: (_, __) => isAuthenticated
            ? RouteConstants.homeRoute
            : RouteConstants.loginRoute,
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      appBar: AppBar(title: const Text('Page Not Found')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('404',
                style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Page ${state.uri.path} not found'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go(RouteConstants.homeRoute),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    ),
  );
});
