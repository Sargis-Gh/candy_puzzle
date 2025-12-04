import 'package:equatable/equatable.dart';

class SettingsState extends Equatable {
  final bool isMusicEnabled;
  final bool isSoundEnabled;

  const SettingsState({this.isMusicEnabled = true, this.isSoundEnabled = true});

  SettingsState copyWith({bool? isMusicEnabled, bool? isSoundEnabled}) {
    return SettingsState(
      isMusicEnabled: isMusicEnabled ?? this.isMusicEnabled,
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
    );
  }

  @override
  List<Object> get props => [isMusicEnabled, isSoundEnabled];
}
