import 'package:flutter/material.dart';
import 'package:password_generator/core/extension.dart';

class LinearTracker extends StatefulWidget {
  final double progress;
  final Color? color;
  final bool shouldShowLabel;
  final double height;

  const LinearTracker({
    super.key,
    required this.progress,
    this.color,
    this.shouldShowLabel = false,
    required this.height,
  });

  @override
  State<LinearTracker> createState() => _LinearTrackerState();
}

class _LinearTrackerState extends State<LinearTracker>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.progress,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOutCubic,
      ),
    );
    _controller.forward();
  }

  @override
  void didUpdateWidget(covariant LinearTracker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _animation = Tween<double>(
        begin: oldWidget.progress,
        end: widget.progress,
      ).animate(
        CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
      );
      _controller
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.shouldShowLabel)
          AnimatedBuilder(
              animation: _animation,
              builder: (context, child) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 4.h),
                  // child: Text('${widget.progress.round()}%',
                  child: Text('${_animation.value.round()}%',
                      style: context.textTheme.bodySmall),
                );
              }),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: widget.height,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(widget.height / 2),
              ),
            ),
            // Progress
            AnimatedBuilder(
              animation: _controller,
              builder: (context,child) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: FractionallySizedBox(
                    // widthFactor: widget.progress / 100,
                    // widthFactor: _animation.value / 100,
                    widthFactor: (_animation.value / 100).clamp(0.0, 1.0),
                    child: Container(
                      height: widget.height,
                      decoration: BoxDecoration(
                        color: widget.color ?? Colors.blue,
                        borderRadius: BorderRadius.circular(widget.height / 2),
                      ),
                    ),
                  ),
                );
              }
            ),
            // Optional centered label
            if (widget.shouldShowLabel)
              Text(
                '${widget.progress.round()}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        )
      ],
    );
  }
}
