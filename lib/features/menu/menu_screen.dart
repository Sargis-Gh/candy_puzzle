import 'package:candy_puzzle/features/rules/rules_widget.dart';
import 'package:candy_puzzle/features/settings/settings_widget.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/game_background.dart';
import '../../core/theme/app_assets.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({super.key});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  bool isSettingsOpen = false;
  bool isRulesOpen = false;

  void onClose() {
    setState(() {
      isSettingsOpen = false;
      isRulesOpen = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GameBackground(
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
                          onPressed: () => setState(() {
                            isSettingsOpen = !isSettingsOpen;
                            isRulesOpen = false;
                          }),
                        ),
                        const SizedBox(height: 20),
                        _MenuButton(
                          asset: AppAssets.privacyButton,
                          onPressed: () => setState(() {
                            isRulesOpen = !isRulesOpen;
                            isSettingsOpen = false;
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Visibility(
            visible: isSettingsOpen,
            child: SettingsWidget(onClose: onClose),
          ),
          Visibility(
            visible: isRulesOpen,
            child: RulesWidget(onClose: onClose),
          ),
        ],
      ),
    );
  }
}

class _MenuButton extends StatefulWidget {
  final String asset;
  final VoidCallback onPressed;

  const _MenuButton({required this.asset, required this.onPressed});

  @override
  State<_MenuButton> createState() => _MenuButtonState();
}

class _MenuButtonState extends State<_MenuButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        widget.onPressed();
      },
      onTapCancel: () => _controller.reverse(),
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Image.asset(
          widget.asset,
          width: 200,
          height: 80,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
