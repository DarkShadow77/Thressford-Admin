import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';

class ThessfordIcon extends StatelessWidget {
  const ThessfordIcon({
    super.key,
    this.width = 80,
    this.height = 80,
    this.radius = 14,
    this.bgColor = Colors.transparent,
    this.iconColor = AppColors.primary,
  });

  final double width;
  final double height;
  final double radius;
  final Color bgColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius.r),
        color: bgColor,
      ),
      child: Transform.scale(
        scale: 1.2,
        child: Image.asset(
          AssetsLogo.logoIcon,
          width: width.r,
          height: height.r,
          fit: BoxFit.contain,
          color: iconColor,
          colorBlendMode: BlendMode.srcIn,
        ),
      ),
    );
  }
}
