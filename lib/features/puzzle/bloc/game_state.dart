import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../core/models/puzzle_piece.dart';

enum GameStatus { initial, playing, paused, completed, failed }

class GameState extends Equatable {
  final GameStatus status;
  final List<PuzzlePiece> pieces;
  final int timeElapsed;
  final int totalTime;
  final int levelId;
  final Size gameAreaSize;

  const GameState({
    this.status = GameStatus.initial,
    this.pieces = const [],
    this.timeElapsed = 0,
    this.totalTime = 300, // Default 30 seconds
    this.levelId = 1,
    this.gameAreaSize = Size.zero,
  });

  GameState copyWith({
    GameStatus? status,
    List<PuzzlePiece>? pieces,
    int? timeElapsed,
    int? totalTime,
    int? levelId,
    Size? gameAreaSize,
  }) {
    return GameState(
      status: status ?? this.status,
      pieces: pieces ?? this.pieces,
      timeElapsed: timeElapsed ?? this.timeElapsed,
      totalTime: totalTime ?? this.totalTime,
      levelId: levelId ?? this.levelId,
      gameAreaSize: gameAreaSize ?? this.gameAreaSize,
    );
  }

  @override
  List<Object> get props => [
    status,
    pieces,
    timeElapsed,
    totalTime,
    levelId,
    gameAreaSize,
  ];
}
