import 'package:flutter/material.dart';
import '../theme/app_assets.dart';

class CustomSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final double width;
  final double height;

  const CustomSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    this.width = 76.78,
    this.height = 42.82,
  });

  @override
  State<CustomSwitch> createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  static const double thumbWidth = 42.82;
  static const double thumbHeight = 36.26;

  static const double bgHorizontalPadding = 9.89;
  static const double bgTop = 2.66;
  static const double bgBottom = 1.50;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);

    if (widget.value) {
      _controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(CustomSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      widget.value ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double thumbVerticalPadding = (widget.height - thumbHeight) / 2 > 0
        ? (widget.height - thumbHeight) / 2
        : 0;

    final double maxOffset =
        widget.width - thumbWidth - (thumbVerticalPadding * 2);

    return GestureDetector(
      onTap: () => widget.onChanged(!widget.value),
      child: SizedBox(
        width: widget.width,
        height: widget.height,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned(
              left: bgHorizontalPadding,
              right: bgHorizontalPadding,
              top: bgTop,
              bottom: bgBottom,
              child: Image.asset(
                widget.value
                    ? AppAssets.enabledSwitchBg
                    : AppAssets.disabledSwitchBg,
              ),
            ),
            AnimatedBuilder(
              animation: _animation,
              builder: (_, __) {
                return Positioned(
                  left: thumbVerticalPadding + maxOffset * _animation.value,
                  top: thumbVerticalPadding,
                  width: thumbWidth,
                  height: thumbHeight,
                  child: Image.asset(AppAssets.switchThumb),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
