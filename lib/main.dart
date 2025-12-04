import 'package:flutter/material.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/settings/bloc/settings_cubit.dart';
import 'features/level_select/bloc/level_cubit.dart';

void main() {
  runApp(const CandyPuzzleApp());
}

class CandyPuzzleApp extends StatelessWidget {
  const CandyPuzzleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SettingsCubit()),
        BlocProvider(create: (_) => LevelCubit()),
      ],
      child: MaterialApp.router(
        title: 'Candy Puzzle',
        theme: AppTheme.lightTheme,
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
