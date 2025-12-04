import 'package:equatable/equatable.dart';
import '../../../core/models/level.dart';

class LevelState extends Equatable {
  final List<Level> levels;

  const LevelState({this.levels = const []});

  @override
  List<Object> get props => [levels];
}
