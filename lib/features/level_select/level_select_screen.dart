import 'package:candy_puzzle/core/models/level.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/game_background.dart';
import '../../core/theme/app_assets.dart';
import 'bloc/level_cubit.dart';
import 'bloc/level_state.dart';

class LevelSelectScreen extends StatelessWidget {
  const LevelSelectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const List<Offset> positions = [
      Offset(0.62, 0.94), // 10% from left, 20% from top
      Offset(0.53, 0.80),
      Offset(0.69, 0.63),
      Offset(0.53, 0.43),
      Offset(0.30, 0.30),
      Offset(0.52, 0.09),
      // ...
    ];
    return Scaffold(
      body: GameBackground(
        backgroundImage: AppAssets.levelBackground,
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => context.pop(),
                      child: Image.asset(
                        AppAssets.backButton,
                        width: 53.34,
                        height: 45.15,
                      ),
                    ),
                    const Spacer(),
                    Image.asset(AppAssets.levelMap, width: 167, height: 45),
                    const Spacer(),
                    const SizedBox(width: 45),
                  ],
                ),
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final width = constraints.maxWidth;
                    final height = constraints.maxHeight;
                    return BlocBuilder<LevelCubit, LevelState>(
                      builder: (context, state) {
                        return Stack(
                          children: [
                            ...positions.asMap().entries.map((entry) {
                              final index = entry.key;
                              final rel = entry.value;

                              return Positioned(
                                left: rel.dx * width - 74,
                                top: rel.dy * height - 24,
                                child: _LevelButton(
                                  level: state.levels[index],
                                  onTap: state.levels[index].isUnlocked
                                      ? () => context.push(
                                          '/puzzle/${state.levels[index].id}',
                                        )
                                      : null,
                                ),
                              );
                            }),
                          ],
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LevelButton extends StatelessWidget {
  final Level level;
  final VoidCallback? onTap;

  const _LevelButton({required this.level, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isLocked = !level.isUnlocked;

    return GestureDetector(
      onTap: onTap,
      child: Image.asset(
        isLocked ? AppAssets.blockedLevel : 'assets/images/lvl_${level.id}.png',
        width: 64.67,
        height: 58.79,
      ),
    );
  }
}
