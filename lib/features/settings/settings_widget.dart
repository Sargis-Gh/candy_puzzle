import 'package:candy_puzzle/core/theme/app_assets.dart';
import 'package:candy_puzzle/core/widgets/custom_switch.dart';
import 'package:flutter/material.dart';

class SettingsWidget extends StatelessWidget {
  final VoidCallback onClose;
  const SettingsWidget({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(153, 54, 169, 0.61),
      child: Center(
        child: Stack(
          children: [
            Image.asset(AppAssets.settingsBackground),
            Positioned(
              top: 104,
              left: 0,
              right: 0,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AppAssets.settingsHeader, width: 200, height: 64),
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
              bottom: 227,
              right: 64,
              left: 64,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ListTile(
                    title: Image.asset(AppAssets.music, width: 148, height: 64),
                    trailing: CustomSwitch(value: false, onChanged: (value) {}),
                  ),
                  const SizedBox(height: 27),
                  ListTile(
                    title: Image.asset(AppAssets.sound, width: 157, height: 64),
                    trailing: CustomSwitch(value: true, onChanged: (value) {}),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
