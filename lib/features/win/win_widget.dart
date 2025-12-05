import 'dart:ui';

import 'package:candy_puzzle/core/theme/app_assets.dart';
import 'package:flutter/material.dart';

class WinWidget extends StatelessWidget {
  final bool isCompleted;
  final Duration yourTime;
  final Duration bestTime;
  final int stars;
  final VoidCallback onRestart;
  final VoidCallback onHome;
  final VoidCallback onNext;

  const WinWidget({
    super.key,
    required this.isCompleted,
    required this.yourTime,
    required this.bestTime,
    required this.stars,
    required this.onRestart,
    required this.onHome,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: Center(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 35),
                  child: Image.asset(AppAssets.winBackground),
                ),
                Positioned(
                  top: -2,
                  left: 0,
                  right: 0,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Image.asset(
                          isCompleted
                              ? AppAssets.winHeader
                              : AppAssets.loseHeader,
                          height: 131.26,
                        ),
                      ),
                    ],
                  ),
                ),
                // Stars section - only show if completed
                if (isCompleted)
                  Positioned(
                    top: 109,
                    right: 0,
                    left: 0,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Spacer(),
                        _Star(filled: stars >= 1),
                        const SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 9),
                          child: _Star(filled: stars >= 2, isCenter: true),
                        ),
                        const SizedBox(width: 20),
                        _Star(filled: stars >= 3),
                        const Spacer(),
                      ],
                    ),
                  ),
                Positioned.fill(
                  top: isCompleted ? 217 : 158,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _TimeRow(
                          labelAsset: AppAssets.yourTime,
                          time: yourTime,
                        ),
                        const SizedBox(height: 23),
                        _TimeRow(
                          labelAsset: AppAssets.bestTime,
                          time: bestTime,
                        ),
                        // Show "Maybe try again" if failed
                        if (!isCompleted) ...[
                          const SizedBox(height: 20),
                          Image.asset(
                            AppAssets.maybeTryAgain,
                            width: 200,
                            height: 50,
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  bottom: -28,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: GestureDetector(
                            onTap: onHome,
                            child: Image.asset(
                              AppAssets.home,
                              width: 66.15,
                              height: 55.15,
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        GestureDetector(
                          onTap: isCompleted ? onNext : null,
                          child: Image.asset(
                            isCompleted
                                ? AppAssets.next
                                : AppAssets.inactiveNext,
                            width: 94.69,
                            height: 80.15,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 18),
                          child: GestureDetector(
                            onTap: onRestart,
                            child: Image.asset(
                              AppAssets.restart,
                              width: 66.15,
                              height: 55.15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Star extends StatelessWidget {
  final bool filled;
  final bool isCenter;

  const _Star({required this.filled, this.isCenter = false});

  @override
  Widget build(BuildContext context) {
    final width = isCenter ? 78.0 : 51.17;
    final height = isCenter ? 81.41 : 53.41;

    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Image.asset(AppAssets.starBg),
          if (filled) Positioned.fill(child: Image.asset(AppAssets.star)),
        ],
      ),
    );
  }
}

class _TimeRow extends StatelessWidget {
  final String labelAsset;
  final Duration time;

  const _TimeRow({required this.labelAsset, required this.time});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(labelAsset, width: 115, height: 30),
        const SizedBox(width: 19),
        Stack(
          children: [
            Image.asset(AppAssets.timer, width: 96.76, height: 25.81),
            Positioned(
              bottom: 0.1,
              right: 12.59,
              child: Text(
                _formatTime(time),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 19.82,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  String _formatTime(Duration duration) {
    final minutes = duration.inMinutes;
    final seconds = duration.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }
}
