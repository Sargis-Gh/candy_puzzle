import 'package:flutter_bloc/flutter_bloc.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void toggleMusic() {
    emit(state.copyWith(isMusicEnabled: !state.isMusicEnabled));
  }

  void toggleSound() {
    emit(state.copyWith(isSoundEnabled: !state.isSoundEnabled));
  }
}
