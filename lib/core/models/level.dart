import 'package:equatable/equatable.dart';

class Level extends Equatable {
  final int id;
  final bool isUnlocked;
  final int stars; // 0-3

  const Level({required this.id, this.isUnlocked = false, this.stars = 0});

  Level copyWith({int? id, bool? isUnlocked, int? stars}) {
    return Level(
      id: id ?? this.id,
      isUnlocked: isUnlocked ?? this.isUnlocked,
      stars: stars ?? this.stars,
    );
  }

  @override
  List<Object> get props => [id, isUnlocked, stars];
}
