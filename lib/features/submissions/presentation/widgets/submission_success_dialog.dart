import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/features/submissions/data/models/response/submission_response_model.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/ui_tool_mix.dart';

Future<dynamic> submissionSuccessfulDialog({
  required SubmissionModel submission,
  required String title,
  required String subTitle,
}) async {
  return Get.dialog(
    name: "submission_successful_dialog",
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    SubmissionSuccessfulDialog(
      submission: submission,
      title: title,
      subTitle: subTitle,
    ),
  );
}

class SubmissionSuccessfulDialog extends StatefulWidget {
  const SubmissionSuccessfulDialog({
    super.key,
    required this.submission,
    required this.title,
    required this.subTitle,
  });

  final SubmissionModel submission;
  final String title;
  final String subTitle;

  @override
  State<SubmissionSuccessfulDialog> createState() =>
      _SubmissionSuccessfulDialogState();
}

class _SubmissionSuccessfulDialogState extends State<SubmissionSuccessfulDialog>
    with UIToolMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(color: Colors.black.withValues(alpha: 0.2)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 525.h,
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                decoration: BoxDecoration(
                  color: surfaceColor(),
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          height: 32.r,
                          width: 32.r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.dynamic10,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedCancel01,
                              color: AppColors.dynamic,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          AssetsPngImages.checkmark,
                          width: 48.w,
                          height: 48.h,
                        ),
                        SizedBox(height: 24.h),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: widget.title,
                            style: TextStyles.titleSemiBold20(context),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: widget.subTitle,
                            style: TextStyles.normalRegular14(
                              context,
                              opacity: .5,
                            ),
                          ),
                        ),
                        SizedBox(height: 56.h),
                        IconTextButton(
                          height: 53,
                          onPressed: () => Navigator.pop(context),
                          text: "Close",
                        ),
                        SizedBox(height: 10.h),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class BankDetailsNotice extends StatelessWidget {
  const BankDetailsNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.orange10,
        border: Border.all(width: .5.w, color: AppColors.orange),
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        spacing: 16.w,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 24.sp,
            color: AppColors.dynamic,
          ),
          Expanded(
            child: Column(
              spacing: 2.h,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                RichText(
                  text: TextSpan(
                    text:
                        "Funds will be deposited to your GTB Pounds account within 2-3 business days after admin approval.",
                    style: TextStyles.cardRegular10(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
