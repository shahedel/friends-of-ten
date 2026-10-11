import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../features/home/presentation/screens/home_screen.dart';
import '../features/visualization/presentation/screens/visualization_screen.dart';
import '../features/mental_math/presentation/screens/math_session_screen.dart';
import '../features/mental_math/presentation/screens/results_screen.dart';
import '../features/mental_math/presentation/screens/ones_practice_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/visualization',
        name: 'visualization',
        builder: (context, state) => const VisualizationScreen(),
      ),
      GoRoute(
        path: '/ones',
        name: 'onesPractice',
        builder: (context, state) => const OnesPracticeScreen(),
      ),
      GoRoute(
        path: '/session',
        name: 'mathSession',
        builder: (context, state) => const MathSessionScreen(),
      ),
      GoRoute(
        path: '/results',
        name: 'results',
        builder: (context, state) => const ResultsScreen(),
      ),
    ],
  );
});
