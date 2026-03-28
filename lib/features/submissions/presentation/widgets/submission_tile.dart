import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';
import 'package:thressford_admin/features/submissions/presentation/pages/submission_details_page.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/navigators/route_name.dart';
import '../../../../core/utils/helpers.dart';
import '../../../referral_management/data/models/response/referral_response_model.dart';
import 'approve_submission_dialog.dart';
import 'reject_submission_dialog.dart';

class SubmissionTile extends StatelessWidget {
  const SubmissionTile({super.key, required this.submission});

  final ReferralModel submission;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RouteName.submissionDetailsPage,
        arguments: SubmissionDetailsPageParam(submission: submission),
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: AppColors.dynamic025,
          borderRadius: BorderRadius.circular(14.r),
        ),
        child: Column(
          spacing: 16.h,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              spacing: 20.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    spacing: 4.h,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: submission.fullName,
                          style: TextStyles.normalRegular14(context),
                        ),
                      ),
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: submission.email,
                          style: TextStyles.smallRegular12(
                            context,
                            opacity: .65,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: submission.getAppStatusColor().withValues(
                      alpha: .05,
                    ),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: submission.appStatus.statusString.capitalize,
                      style: TextStyles.smallRegular12(
                        context,
                      ).copyWith(color: submission.getAppStatusColor()),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              decoration: BoxDecoration(
                color: AppColors.dynamic05,
                borderRadius: BorderRadius.circular(14.r),
              ),
              child: Column(
                spacing: 8.h,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: submission.course,
                      style: TextStyles.smallRegular12(context),
                    ),
                  ),
                  RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: submission.country,
                      style: TextStyles.smallRegular12(context),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              spacing: 17.h,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  spacing: 8.w,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsSvgIcons.user,
                      width: 20.w,
                      height: 20.h,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        AppColors.dynamic50,
                        BlendMode.srcIn,
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: submission.referredBy,
                            style: TextStyles.normalRegular14(context),
                          ),
                        ],
                        text: "Referred by: ",
                        style: TextStyles.normalRegular14(context, opacity: .5),
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 8.w,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      AssetsSvgIcons.calender,
                      width: 20.w,
                      height: 20.h,
                      fit: BoxFit.contain,
                      colorFilter: ColorFilter.mode(
                        AppColors.dynamic50,
                        BlendMode.srcIn,
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: formatDate(submission.createdAt),
                            style: TextStyles.normalRegular14(context),
                          ),
                        ],
                        text: "Submitted: ",
                        style: TextStyles.normalRegular14(context, opacity: .5),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Row(
              spacing: 10.w,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                if (submission.appStatus == AppReferralStatus.pending ||
                    submission.appStatus == AppReferralStatus.approved)
                  Expanded(
                    child: IconTextButton(
                      onPressed: () {
                        rejectSubmissionDialog(submission: submission);
                      },
                      height: 42,
                      text: "Deny",
                      iconWidget: Icon(
                        Icons.cancel_outlined,
                        color: AppColors.error,
                        size: 20.sp,
                      ),
                      textColor: AppColors.error,
                      color: AppColors.error5,
                    ),
                  ),
                if (submission.appStatus == AppReferralStatus.pending ||
                    submission.appStatus == AppReferralStatus.denied)
                  Expanded(
                    child: IconTextButton(
                      onPressed: () {
                        approveSubmissionDialog(submission: submission);
                      },
                      height: 42,
                      text: "Approve",
                      icon: AssetsSvgIcons.checkCircle,
                      iconColor: AppColors.white,
                      textColor: AppColors.white,
                      color: AppColors.green,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
