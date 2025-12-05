import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../core/models/puzzle_piece.dart';

enum GameStatus { initial, playing, paused, completed, failed }

class GameState extends Equatable {
  final GameStatus status;
  final List<PuzzlePiece> pieces;
  final Duration timeElapsed;
  final Duration totalTime;
  final Duration bestTime;
  final int levelId;
  final Size gameAreaSize;
  final int stars;

  const GameState({
    this.status = GameStatus.initial,
    this.pieces = const [],
    this.timeElapsed = Duration.zero,
    this.totalTime = const Duration(minutes: 2), // Default 2 minutes
    this.bestTime = Duration.zero,
    this.levelId = 1,
    this.gameAreaSize = Size.zero,
    this.stars = 0,
  });

  GameState copyWith({
    GameStatus? status,
    List<PuzzlePiece>? pieces,
    Duration? timeElapsed,
    Duration? totalTime,
    Duration? bestTime,
    int? levelId,
    Size? gameAreaSize,
    int? stars,
  }) {
    return GameState(
      status: status ?? this.status,
      pieces: pieces ?? this.pieces,
      timeElapsed: timeElapsed ?? this.timeElapsed,
      totalTime: totalTime ?? this.totalTime,
      bestTime: bestTime ?? this.bestTime,
      levelId: levelId ?? this.levelId,
      gameAreaSize: gameAreaSize ?? this.gameAreaSize,
      stars: stars ?? this.stars,
    );
  }

  @override
  List<Object> get props => [
    status,
    pieces,
    timeElapsed,
    totalTime,
    bestTime,
    levelId,
    gameAreaSize,
    stars,
  ];
}
