import 'dart:async';
import 'dart:math';
import 'package:candy_puzzle/features/puzzle/data/level_configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/puzzle_piece.dart';
import 'game_event.dart';
import 'game_state.dart';

class GameBloc extends Bloc<GameEvent, GameState> {
  Timer? _timer;
  static const double _snapThreshold = 15; // Distance to snap

  GameBloc() : super(const GameState()) {
    on<GameStarted>(_onGameStarted);
    on<PieceMoved>(_onPieceMoved);
    on<PieceDropped>(_onPieceDropped);
    on<TimerTicked>(_onTimerTicked);
    on<GamePaused>(_onGamePaused);
    on<GameResumed>(_onGameResumed);
    on<GameExited>(_onGameExited);
  }

  void _onGameStarted(GameStarted event, Emitter<GameState> emit) {
    _timer?.cancel();
    // Initialize pieces for the level
    // For now, we'll generate some dummy pieces if we don't have the asset logic yet
    // But ideally we should load from a repository or helper

    final pieces = _generatePiecesForLevel(event.levelId, event.gameAreaSize);

    emit(
      state.copyWith(
        status: GameStatus.playing,
        pieces: pieces,
        timeElapsed: 0,
        levelId: event.levelId,
        gameAreaSize: event.gameAreaSize,
      ),
    );

    _startTimer();
  }

  void _onPieceMoved(PieceMoved event, Emitter<GameState> emit) {
    if (state.status != GameStatus.playing) return;

    final updatedPieces = state.pieces.map((piece) {
      if (piece.id == event.pieceId && !piece.isPlaced) {
        // Clamp position to keep piece within game area
        final double maxX = state.gameAreaSize.width - piece.size.width;
        final double maxY = state.gameAreaSize.height - piece.size.height;

        final double clampedX = event.newPosition.dx.clamp(0.0, maxX);
        final double clampedY = event.newPosition.dy.clamp(0.0, maxY);

        return piece.copyWith(currentPosition: Offset(clampedX, clampedY));
      }
      return piece;
    }).toList();

    emit(state.copyWith(pieces: updatedPieces));
  }

  void _onPieceDropped(PieceDropped event, Emitter<GameState> emit) {
    if (state.status != GameStatus.playing) return;

    final pieceIndex = state.pieces.indexWhere((p) => p.id == event.pieceId);
    if (pieceIndex == -1) return;

    final piece = state.pieces[pieceIndex];
    if (piece.isPlaced) return;

    // Check distance to correct position
    final distance = (piece.currentPosition - piece.correctPosition).distance;

    // DEBUG: Print position to help calibration
    debugPrint('Piece ${piece.id} dropped at: ${piece.currentPosition}');

    if (distance < _snapThreshold) {
      // Snap to correct position
      final updatedPieces = List<PuzzlePiece>.from(state.pieces);
      updatedPieces[pieceIndex] = piece.copyWith(
        currentPosition: piece.correctPosition,
        isPlaced: true,
      );

      emit(state.copyWith(pieces: updatedPieces));

      // Check win condition
      if (updatedPieces.every((p) => p.isPlaced)) {
        _timer?.cancel();
        emit(state.copyWith(status: GameStatus.completed));
      }
    }
  }

  void _onTimerTicked(TimerTicked event, Emitter<GameState> emit) {
    if (state.timeElapsed >= state.totalTime) {
      _timer?.cancel();
      emit(state.copyWith(status: GameStatus.failed));
    } else {
      emit(state.copyWith(timeElapsed: event.timeElapsed));
    }
  }

  void _onGamePaused(GamePaused event, Emitter<GameState> emit) {
    _timer?.cancel();
    emit(state.copyWith(status: GameStatus.paused));
  }

  void _onGameResumed(GameResumed event, Emitter<GameState> emit) {
    _startTimer();
    emit(state.copyWith(status: GameStatus.playing));
  }

  void _onGameExited(GameExited event, Emitter<GameState> emit) {
    _timer?.cancel();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      add(TimerTicked(timeElapsed: state.timeElapsed + 1));
    });
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }

  List<PuzzlePiece> _generatePiecesForLevel(int levelId, Size gameArea) {
    // For now, only level 1 is defined
    final data = level1Data;

    // final scaleX = gameArea.width / data.originalPuzzleSize.width;
    // final scaleY = gameArea.height / data.originalPuzzleSize.height;

    final scaleX = 1;
    final scaleY = 1;

    final pieces = <PuzzlePiece>[];
    final random = Random();

    for (int id = 1; id <= data.pieceSizes.length; id++) {
      final originalSize = data.pieceSizes[id]!;
      final originalCorrect = data.correctPositions[id]!;

      // SCALE to device
      final scaledSize = Size(
        originalSize.width * scaleX,
        originalSize.height * scaleY,
      );

      final scaledCorrect = Offset(
        originalCorrect.dx * scaleX,
        originalCorrect.dy * scaleY,
      );

      // Random starting position inside game area
      final start = Offset(
        random.nextDouble() * (gameArea.width - scaledSize.width),
        random.nextDouble() * (gameArea.height - scaledSize.height),
      );

      pieces.add(
        PuzzlePiece(
          id: id,
          imageAsset: 'assets/images/puzzles/level_1/$id.png',
          size: scaledSize,
          correctPosition: scaledCorrect,
          currentPosition: start,
        ),
      );
    }

    return pieces;
  }
}

class LevelConfig {
  final int pieceCount;
  final Size pieceSize;

  const LevelConfig({required this.pieceCount, required this.pieceSize});
}
