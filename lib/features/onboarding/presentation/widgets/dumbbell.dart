import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gym_app/core/packages.dart';
import 'package:gym_app/core/theme/app_colors.dart';
import 'package:gym_app/gen/assets.gen.dart';

class AnimatedDumbbellWidget extends StatefulWidget {
  final double size;

  const AnimatedDumbbellWidget({Key? key, this.size = 150}) : super(key: key);

  @override
  _AnimatedDumbbellWidgetState createState() => _AnimatedDumbbellWidgetState();
}

class _AnimatedDumbbellWidgetState extends State<AnimatedDumbbellWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _rotationAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1))
          ..repeat(reverse: true);

    _rotationAnimation =
        Tween<double>(begin: -0.09, end: 0.09).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));

    _scaleAnimation =
        Tween<double>(begin: 0.95, end: 1.05).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return Transform.rotate(
            angle: _rotationAnimation.value,
            child: Transform.scale(
              scale: _scaleAnimation.value,
              child: child,
            ),
          );
        },
        child: Assets.images.workout.workoutPlans
            .image(height: 100.h, width: 100.w));
  }
}
