import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PuzzlePiece extends Equatable {
  final int id;
  final String imageAsset;
  final Offset correctPosition;
  final Offset currentPosition;
  final bool isPlaced;
  final Size size;

  const PuzzlePiece({
    required this.id,
    required this.imageAsset,
    required this.correctPosition,
    required this.currentPosition,
    this.isPlaced = false,
    this.size = const Size(100, 100), // Default size, should be set per piece
  });

  PuzzlePiece copyWith({
    int? id,
    String? imageAsset,
    Offset? correctPosition,
    Offset? currentPosition,
    bool? isPlaced,
    Size? size,
  }) {
    return PuzzlePiece(
      id: id ?? this.id,
      imageAsset: imageAsset ?? this.imageAsset,
      correctPosition: correctPosition ?? this.correctPosition,
      currentPosition: currentPosition ?? this.currentPosition,
      isPlaced: isPlaced ?? this.isPlaced,
      size: size ?? this.size,
    );
  }

  @override
  List<Object?> get props => [
    id,
    imageAsset,
    correctPosition,
    currentPosition,
    isPlaced,
    size,
  ];
}
