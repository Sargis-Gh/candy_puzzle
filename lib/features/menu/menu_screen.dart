import 'package:candy_puzzle/features/rules/rules_widget.dart';
import 'package:candy_puzzle/features/settings/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/game_background.dart';
import '../../core/theme/app_assets.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      useSafeArea: false,
      context: context,
      barrierColor: Color.fromRGBO(153, 54, 169, 0.61),
      builder: (context) =>
          SettingsWidget(onClose: () => Navigator.of(context).pop()),
    );
  }

  void _showRulesDialog(BuildContext context) {
    showDialog(
      useSafeArea: false,
      context: context,
      barrierColor: Color.fromRGBO(153, 54, 169, 0.61),
      builder: (context) =>
          RulesWidget(onClose: () => Navigator.of(context).pop()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GameBackground(
        child: Center(
          child: Stack(
            children: [
              Image.asset(AppAssets.menuBackground),
              Positioned(
                top: 116,
                left: 0,
                right: 0,
                child: Image.asset(
                  AppAssets.menuHeader,
                  width: 359.91,
                  height: 131.26,
                ),
              ),
              Positioned(
                bottom: 170.52,
                left: 0,
                right: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _MenuButton(
                      asset: AppAssets.playButton,
                      onPressed: () => context.push('/levels'),
                    ),
                    const SizedBox(height: 20),
                    _MenuButton(
                      asset: AppAssets.settingsButton,
                      onPressed: () => _showSettingsDialog(context),
                    ),
                    const SizedBox(height: 20),
                    _MenuButton(
                      asset: AppAssets.privacyButton,
                      onPressed: () => _showRulesDialog(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuButton extends StatelessWidget {
  final String asset;
  final VoidCallback onPressed;

  const _MenuButton({required this.asset, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Image.asset(asset, width: 265.79, height: 74.02),
    );
  }
}
