import 'package:candy_puzzle/core/theme/app_assets.dart';
import 'package:flutter/material.dart';

class RulesWidget extends StatelessWidget {
  final VoidCallback onClose;
  const RulesWidget({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(153, 54, 169, 0.61),
      child: Center(
        child: Stack(
          children: [
            Image.asset(AppAssets.rulesBackground),
            Positioned(
              top: 104,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.rules, width: 141, height: 64),
                ],
              ),
            ),
            Positioned(
              top: 154,
              right: 22.85,
              child: GestureDetector(
                onTap: onClose,
                child: Image.asset(
                  AppAssets.closeButton,
                  width: 65.15,
                  height: 55.14,
                ),
              ),
            ),
            Positioned(
              top: 229,
              right: 67,
              left: 69,
              child: Image.asset(AppAssets.rulesBody, width: 254, height: 56),
            ),
          ],
        ),
      ),
    );
  }
}
