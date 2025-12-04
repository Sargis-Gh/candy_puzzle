import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/models/level.dart';
import 'level_state.dart';

class LevelCubit extends Cubit<LevelState> {
  LevelCubit()
    : super(
        const LevelState(
          levels: [
            Level(id: 1, isUnlocked: true),
            Level(id: 2, isUnlocked: false),
            Level(id: 3, isUnlocked: false),
            Level(id: 4, isUnlocked: false),
            Level(id: 5, isUnlocked: false),
            Level(id: 6, isUnlocked: false),
          ],
        ),
      );

  void unlockLevel(int levelId) {
    final updatedLevels = state.levels.map((level) {
      if (level.id == levelId) {
        return level.copyWith(isUnlocked: true);
      }
      return level;
    }).toList();
    emit(LevelState(levels: updatedLevels));
  }

  void completeLevel(int levelId, int stars) {
    final updatedLevels = state.levels.map((level) {
      if (level.id == levelId) {
        return level.copyWith(stars: stars > level.stars ? stars : level.stars);
      }
      // Unlock next level
      if (level.id == levelId + 1) {
        return level.copyWith(isUnlocked: true);
      }
      return level;
    }).toList();
    emit(LevelState(levels: updatedLevels));
  }
}
