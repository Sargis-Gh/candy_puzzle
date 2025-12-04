import 'package:go_router/go_router.dart';
import '../../features/loading/loading_screen.dart';
import '../../features/username/username_screen.dart';
import '../../features/menu/menu_screen.dart';
import '../../features/level_select/level_select_screen.dart';
import '../../features/puzzle/puzzle_screen.dart';
import '../../features/win/win_screen.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const LoadingScreen()),
      GoRoute(
        path: '/username',
        builder: (context, state) => const UsernameScreen(),
      ),
      GoRoute(path: '/menu', builder: (context, state) => const MenuScreen()),
      GoRoute(
        path: '/levels',
        builder: (context, state) => const LevelSelectScreen(),
      ),
      GoRoute(
        path: '/puzzle/:id',
        builder: (context, state) {
          final id = int.tryParse(state.pathParameters['id'] ?? '1') ?? 1;
          return PuzzleScreen(levelId: id);
        },
      ),
      GoRoute(path: '/win', builder: (context, state) => const WinScreen()),
    ],
  );
}
