import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../core/constants/app_assets.dart';
import '../widgets/buttons/icon_text_button.dart';

class SuccessfulPage extends StatefulWidget {
  const SuccessfulPage({super.key, required this.param});

  final SuccessfulPageParam param;
  @override
  State<SuccessfulPage> createState() => _SuccessfulPageState();
}

class _SuccessfulPageState extends State<SuccessfulPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (canPop, result) => widget.param.onTap(),
          child: CustomScrollView(
            physics: BouncingScrollPhysics(),
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Image.asset(
                          AssetsLogo.roundedLogo,
                          width: 32.w,
                          height: 32.h,
                        ),
                      ],
                    ),
                    SizedBox(height: 240.h),
                    Image.asset(
                      AssetsPngImages.checkmark,
                      width: 48.w,
                      height: 48.h,
                    ),
                    SizedBox(height: 24.h),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: widget.param.title,
                        style: TextStyles.titleSemiBold20(context),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: widget.param.subTitle,
                        style: TextStyles.bodyRegular16(context, opacity: .5),
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ]),
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                sliver: SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconTextButton(
                        onPressed: () => widget.param.onTap(),
                        text: widget.param.btnText,
                        color: AppColors.primary,
                      ),
                      SizedBox(
                        height: 20.h + MediaQuery.of(context).padding.bottom,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SuccessfulPageParam {
  final String title;
  final String subTitle;
  final String btnText;
  final VoidCallback onTap;

  SuccessfulPageParam({
    required this.title,
    required this.subTitle,
    required this.btnText,
    required this.onTap,
  });
}
