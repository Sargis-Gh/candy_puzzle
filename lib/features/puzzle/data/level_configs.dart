import 'package:flutter/material.dart';

class LevelData {
  final Map<int, Size> pieceSizes;
  final Map<int, Offset> correctPositions;
  final Size originalPuzzleSize;

  const LevelData({
    required this.pieceSizes,
    required this.correctPositions,
    required this.originalPuzzleSize,
  });
}

/// ORIGINAL puzzle_1.png size: (307.63 x 297)
///
/// All coordinates and sizes below must be from this original coordinate system.
/// They will be automatically scaled to the user's screen size.
final level1Data = LevelData(
  originalPuzzleSize: const Size(307.63, 297),

  pieceSizes: const {
    1: Size(80.51, 52.91),
    2: Size(102.54, 67.6),
    3: Size(87.86, 91.15),
    4: Size(100.01, 91.15),
    5: Size(88.62, 91.15),
    6: Size(111.66, 70.9),
    7: Size(84.32, 120.27),
    8: Size(172.68, 67.86),
    9: Size(134.95, 111.66),
    10: Size(109.38, 120.27),
    11: Size(81.53, 117.23),
    12: Size(62.03, 114.45),
    13: Size(71.4, 69.88),
  },

  correctPositions: const {
    1: Offset(49.79, 33.87),
    2: Offset(190.57, 37.17),
    3: Offset(206.52, 229.85),
    4: Offset(47, 178.45),
    5: Offset(246.02, 114.39),
    6: Offset(109.54, 24),
    7: Offset(190.82, 109.58),
    8: Offset(34.6, 85.27),
    9: Offset(27, 135.15),
    10: Offset(64.22, 196.68),
    11: Offset(164.74, 203.77),
    12: Offset(272.09, 52.86),
    13: Offset(261.71, 208.83),
  },
);
