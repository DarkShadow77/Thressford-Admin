import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/features/submissions/data/models/response/submission_response_model.dart';
import 'package:thressford_admin/features/submissions/presentation/widgets/reason_dialog.dart';
import 'package:thressford_admin/features/submissions/presentation/widgets/submission_success_dialog.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/ui_tool_mix.dart';

Future<dynamic> rejectSubmissionDialog({
  required SubmissionModel submission,
}) async {
  return Get.dialog(
    name: "reject_submission_dialog",
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    RejectSubmissionDialog(submission: submission),
  );
}

class RejectSubmissionDialog extends StatefulWidget {
  const RejectSubmissionDialog({super.key, required this.submission});

  final SubmissionModel submission;

  @override
  State<RejectSubmissionDialog> createState() => _RejectSubmissionDialogState();
}

class _RejectSubmissionDialogState extends State<RejectSubmissionDialog>
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
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          height: 40.r,
                          width: 40.r,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.error5,
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            onPressed: () => Navigator.pop(context),
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedCancel01,
                              color: AppColors.error,
                              size: 12.sp,
                            ),
                          ),
                        ),
                        SizedBox(height: 24.h),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: "Reject Submission?",
                            style: TextStyles.titleSemiBold20(context),
                          ),
                        ),
                        SizedBox(height: 16.h),
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text:
                                "Are you sure you want to reject this referral submission?",
                            style: TextStyles.normalRegular14(
                              context,
                              opacity: .5,
                            ),
                          ),
                        ),
                        SizedBox(height: 56.h),
                        Row(
                          spacing: 10.w,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: IconTextButton(
                                height: 53,
                                onPressed: () => Navigator.pop(context),
                                text: "Cancel",
                                color: surfaceColor(),
                                textColor: AppColors.dynamic,
                                borderColor: AppColors.dynamic30,
                              ),
                            ),
                            Expanded(
                              child: IconTextButton(
                                height: 53,
                                onPressed: () {
                                  Navigator.pop(context);
                                  submissionReasonDialog(
                                    submission: widget.submission,
                                    title: "Reason for Rejection",
                                    onTap: () {
                                      submissionSuccessfulDialog(
                                        submission: widget.submission,
                                        title: "Submission Rejected",
                                        subTitle:
                                            "${widget.submission.fullName}’s submission has been rejected",
                                      );
                                    },
                                  );
                                },
                                text: "Yes, Reject",
                              ),
                            ),
                          ],
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
