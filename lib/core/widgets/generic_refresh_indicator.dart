import 'package:flutter/material.dart';
import 'package:gym_app/core/theme/app_colors.dart';

class GenericRefreshIndicator extends StatelessWidget {
  final Future<void> Function() onRefresh;
  final Widget Function(BuildContext) builder;
  final Color? color;
  final Color? backgroundColor;

  const GenericRefreshIndicator({
    Key? key,
    required this.onRefresh,
    required this.builder,
    this.color,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      color: color ?? AppColors.black,
      backgroundColor: backgroundColor,
      child: Builder(
        builder: (context) => builder(context),
      ),
    );
  }
}
