import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/widgets/game_background.dart';
import '../../core/theme/app_colors.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    // Simulate loading progress
    _simulateLoading();
  }

  void _simulateLoading() async {
    const totalDuration = Duration(seconds: 1);
    const steps = 100;
    final stepDuration = totalDuration ~/ steps;

    for (int i = 0; i <= steps; i++) {
      if (!mounted) return;

      setState(() {
        _progress = i / 100;
      });

      await Future.delayed(stepDuration);
    }

    // Check if this is the first launch
    final prefs = await SharedPreferences.getInstance();
    final isFirstLaunch = prefs.getBool('isFirstLaunch') ?? true;

    if (!mounted) return;

    if (isFirstLaunch) {
      context.go('/username');
    } else {
      context.go('/menu');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackground(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Progress Text
              Text(
                '${(_progress * 100).toInt()}%',
                style: const TextStyle(
                  fontSize: 35.27,
                  letterSpacing: 0,
                  fontWeight: FontWeight.w600,
                  color: AppColors.background,
                ),
              ),
              const SizedBox(height: 8),
              // Progress Bar
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 60),
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(217, 217, 217, 0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        width: constraints.maxWidth * _progress,
                        height: 20,
                        decoration: BoxDecoration(
                          color: const Color.fromRGBO(227, 74, 194, 1),
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              const Color.fromRGBO(
                                227,
                                74,
                                194,
                                1,
                              ).withValues(alpha: 0.8),
                              const Color.fromRGBO(227, 74, 194, 1),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.2),
                              offset: const Offset(0, 4),
                              blurRadius: 4,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 87),
            ],
          ),
        ),
      ),
    );
  }
}
