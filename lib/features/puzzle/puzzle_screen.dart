import 'dart:ui';

import 'package:candy_puzzle/core/theme/app_assets.dart';
import 'package:candy_puzzle/core/theme/app_colors.dart';
import 'package:candy_puzzle/core/widgets/game_background.dart';
import 'package:candy_puzzle/features/puzzle/data/level_configs.dart';
import 'package:candy_puzzle/features/win/win_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/models/puzzle_piece.dart';
import 'bloc/game_bloc.dart';
import 'bloc/game_event.dart';
import 'bloc/game_state.dart';

class PuzzleScreen extends StatelessWidget {
  final int levelId;
  const PuzzleScreen({super.key, required this.levelId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GameBloc(),
      child: _PuzzleView(levelId: levelId),
    );
  }
}

class _PuzzleView extends StatefulWidget {
  final int levelId;
  const _PuzzleView({required this.levelId});

  @override
  State<_PuzzleView> createState() => _PuzzleViewState();
}

class _PuzzleViewState extends State<_PuzzleView> {
  @override
  void initState() {
    super.initState();
    // Initialize game after layout to get correct size
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size.width - 28;
      // final size = level1Data.originalPuzzleSize.width;
      context.read<GameBloc>().add(
        GameStarted(levelId: widget.levelId, gameAreaSize: Size(size, size)),
      );
    });
  }

  void _showWinDialog(GameState state, GameBloc bloc) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      barrierColor: const Color.fromRGBO(153, 54, 169, 0.72),
      builder: (context) => WinWidget(
        isCompleted: state.status == GameStatus.completed,
        stars: state.stars,
        yourTime: state.timeElapsed,
        bestTime: state.bestTime,
        onRestart: () {
          Navigator.of(context).pop();
          final size = MediaQuery.of(context).size.width - 28;
          bloc.add(
            GameStarted(
              levelId: widget.levelId,
              gameAreaSize: Size(size, size),
            ),
          );
        },
        onHome: () {
          _showExitDialog(state);
        },
        onNext: () {
          Navigator.of(context).pop();
          context.pop();
        },
      ),
    );
  }

  void _showExitDialog(GameState state) {
    showDialog(
      context: context,
      barrierDismissible: false,
      useSafeArea: false,
      barrierColor: const Color.fromRGBO(153, 54, 169, 0.72),
      builder: (context) => _ExitWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackground(
        child: BlocConsumer<GameBloc, GameState>(
          listener: (context, state) {
            if (state.status == GameStatus.completed ||
                state.status == GameStatus.failed) {
              _showWinDialog(state, context.read<GameBloc>());
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14, top: 50),
                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () => context.pop(),
                        child: Image.asset(
                          AppAssets.puzzleBack,
                          width: 53.34,
                          height: 38.15,
                        ),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 12),
                        child: Stack(
                          children: [
                            Image.asset(
                              AppAssets.timer,
                              width: 123,
                              height: 32.81,
                            ),
                            Positioned(
                              right: 16,
                              bottom: 0.1,
                              child: Text(
                                _formatTime(
                                  state.totalTime - state.timeElapsed,
                                ),
                                style: const TextStyle(
                                  color: AppColors.background,
                                  fontSize: 25.19,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          if (state.status == GameStatus.paused) {
                            context.read<GameBloc>().add(GameResumed());
                          } else {
                            context.read<GameBloc>().add(GamePaused());
                          }
                        },
                        child: Image.asset(
                          AppAssets.pauseButton,
                          width: 53.34,
                          height: 38.15,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 2),
                GameArea(puzzleId: widget.levelId, pieces: state.pieces),
                const Spacer(),
                CompletedPuzzleExample(puzzleId: widget.levelId),
              ],
            );
          },
        ),
      ),
    );
  }

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}

class CompletedPuzzleExample extends StatelessWidget {
  final int puzzleId;
  const CompletedPuzzleExample({super.key, required this.puzzleId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 230,
      height: 190,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppAssets.nameBackground),
          fit: BoxFit.fill,
        ),
      ),
      child: Center(
        child: Image.asset(
          'assets/images/puzzles/puzzle_$puzzleId.png',
          width: 159,
          height: 151,
          errorBuilder: (context, error, stackTrace) {
            return const Icon(
              Icons.image_not_supported,
              size: 50,
              color: Colors.white,
            );
          },
        ),
      ),
    );
  }
}

class GameArea extends StatelessWidget {
  final int puzzleId;
  final List<PuzzlePiece> pieces;

  const GameArea({super.key, required this.puzzleId, required this.pieces});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width - 28;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: AppColors.darkPurpleWithOpacity,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.pieceBorder, width: 3),
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // -------- BACKGROUND GHOST IMAGE --------
          Center(
            child: Opacity(
              opacity: 0.3,
              child: Image.asset(
                'assets/images/puzzles/puzzle_$puzzleId.png',
                width: level1Data.originalPuzzleSize.width,
                height: level1Data.originalPuzzleSize.height,
              ),
            ),
          ),

          // -------- PUZZLE PIECES --------
          ...pieces.map((piece) {
            final widget = Image.asset(
              piece.imageAsset,
              width: piece.size.width,
              height: piece.size.height,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: piece.size.width,
                  height: piece.size.height,
                  color: Colors.primaries[piece.id % Colors.primaries.length]
                      .withValues(alpha: 0.5),
                  child: Center(child: Text('${piece.id}')),
                );
              },
            );

            // ---------- IF PLACED → disable gestures ----------
            if (piece.isPlaced) {
              return Positioned(
                left: piece.currentPosition.dx,
                top: piece.currentPosition.dy + 6,
                child: IgnorePointer(
                  // <––– KEY PART
                  child: widget,
                ),
              );
            }

            // ---------- IF NOT PLACED → enable drag ----------
            return Positioned(
              left: piece.currentPosition.dx,
              top: piece.currentPosition.dy + 6,
              child: GestureDetector(
                onPanUpdate: (details) {
                  final newPos = piece.currentPosition + details.delta;
                  context.read<GameBloc>().add(
                    PieceMoved(pieceId: piece.id, newPosition: newPos),
                  );
                },
                onPanEnd: (_) {
                  context.read<GameBloc>().add(PieceDropped(pieceId: piece.id));
                },
                child: widget,
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}

class _ExitWidget extends StatelessWidget {
  const _ExitWidget();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: SizedBox(
              height: 258,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Align(child: Image.asset(AppAssets.nameBackground)),
                  Align(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 50),
                      child: Text(
                        'Do you really want exit the game?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.background,
                          fontSize: 35.18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: -9,
                    left: 0,
                    right: 0,
                    child: Row(
                      children: [
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                            context.pop();
                            context.pop();
                            context.pop();
                          },
                          child: Image.asset(
                            AppAssets.yes,
                            width: 111.58,
                            height: 46.83,
                          ),
                        ),
                        const SizedBox(width: 72.42),
                        GestureDetector(
                          onTap: () {
                            context.pop();
                          },
                          child: Image.asset(
                            AppAssets.no,
                            width: 111.58,
                            height: 46.83,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
