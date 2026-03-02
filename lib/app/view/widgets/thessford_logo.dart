import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constants/app_assets.dart';
import '../../../core/constants/app_colors.dart';
import 'thessford_icon.dart';

class ThessfordLogo extends StatelessWidget {
  const ThessfordLogo({
    super.key,
    this.opacity = 1,
    this.iconOpacity = 0,
    this.logoW = 72,
    this.logoH = 72,
    this.textW = 155,
    this.textH = 72,
  });

  final double opacity;
  final double iconOpacity;
  final double logoW;
  final double logoH;
  final double textW;
  final double textH;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 11.w,
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Opacity(
          opacity: iconOpacity,
          child: ThessfordIcon(width: logoW, height: logoH),
        ),
        Opacity(
          opacity: opacity,
          child: Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Image.asset(
              AssetsLogo.logoName,
              fit: BoxFit.contain,
              width: textW.w,
              height: textH.h,
            ),
          ),
        ),
      ],
    );
  }
}
