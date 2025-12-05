import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object> get props => [];
}

class GameStarted extends GameEvent {
  final int levelId;
  final Size gameAreaSize;

  const GameStarted({required this.levelId, required this.gameAreaSize});

  @override
  List<Object> get props => [levelId, gameAreaSize];
}

class PieceMoved extends GameEvent {
  final int pieceId;
  final Offset newPosition;

  const PieceMoved({required this.pieceId, required this.newPosition});

  @override
  List<Object> get props => [pieceId, newPosition];
}

class PieceDropped extends GameEvent {
  final int pieceId;

  const PieceDropped({required this.pieceId});

  @override
  List<Object> get props => [pieceId];
}

class TimerTicked extends GameEvent {
  final Duration timeElapsed;

  const TimerTicked({required this.timeElapsed});

  @override
  List<Object> get props => [timeElapsed];
}

class GamePaused extends GameEvent {}

class GameResumed extends GameEvent {}

class GameExited extends GameEvent {}
