import 'package:flutter/material.dart';
import '../theme/app_assets.dart';
import '../theme/app_colors.dart';

class GameBackground extends StatelessWidget {
  final Widget child;
  final double overlayOpacity;
  final String backgroundImage;

  const GameBackground({
    super.key,
    required this.child,
    this.overlayOpacity = 0.34,
    this.backgroundImage = AppAssets.background,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(color: AppColors.background),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(backgroundImage, fit: BoxFit.cover),
          ColoredBox(color: Color.fromRGBO(153, 54, 169, overlayOpacity)),
          child,
        ],
      ),
    );
  }
}
