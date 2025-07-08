// import 'package:chatapp/feature/auth/presentation/providers/auth_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';

// class SplashScreen extends ConsumerWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final authState = ref.watch(authStateProvider);
    
//     // Listen to auth state changes and navigate accordingly
//     ref.listen(authStateProvider, (previous, next) {
//       if (!next.isLoading) {
//         next.when(
//           data: (user) {
//             if (user != null) {
//               context.go('/home');
//             } else {
//               context.go('/login');
//             }
//           },
//           error: (_, __) => context.go('/login'),
//           loading: () {}, // This won't be called since we check !isLoading
//         );
//       }
//     });
    
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             const FlutterLogo(size: 100),
//             const SizedBox(height: 20),
//             authState.when(
//               data: (_) => const Text('Redirecting...'),
//               loading: () => const Column(
//                 children: [
//                   CircularProgressIndicator(),
//                   SizedBox(height: 16),
//                   Text('Loading...'),
//                 ],
//               ),
//               error: (error, _) => Column(
//                 children: [
//                   const Icon(Icons.error, color: Colors.red),
//                   const SizedBox(height: 16),
//                   Text('Error: ${error.toString()}'),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: () => ref.refresh(authStateProvider),
//                     child: const Text('Retry'),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
