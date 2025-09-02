import 'package:flutter/material.dart';
import 'package:gym_app/core/packages.dart';

class CustomTop extends StatelessWidget {
  final String title;
  final Widget icon;
  final bool? haveBackIcon;
  const CustomTop({
    super.key,
    required this.title,
    required this.icon,
    this.haveBackIcon = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 11.w,
      children: [
        if (haveBackIcon!)
          InkWell(
            child: Icon(Icons.arrow_back_ios),
          ),
        icon,
        Text(
          title,
          style: AppText.s22W600,
        )
      ],
    );
  }
}
