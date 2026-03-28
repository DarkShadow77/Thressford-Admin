import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:thressford_admin/core/utils/helpers.dart';
import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../../referral_management/data/models/response/referral_response_model.dart';
import '../../../referral_management/presentation/bloc/referral_bloc.dart';
import '../widgets/approve_submission_dialog.dart';
import '../widgets/reject_submission_dialog.dart';

class SubmissionDetailsPage extends StatefulWidget {
  const SubmissionDetailsPage({super.key, required this.param});

  final SubmissionDetailsPageParam param;

  @override
  State<SubmissionDetailsPage> createState() => _SubmissionDetailsPageState();
}

class _SubmissionDetailsPageState extends State<SubmissionDetailsPage>
    with UIToolMixin {
  ReferralModel submission = ReferralModel.empty();

  @override
  void initState() {
    super.initState();
    submission = widget.param.submission;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferralBloc, ReferralState>(
      builder: (context, state) {
        submission = state.referral.firstWhere(
          (element) => element.id == submission.id,
        );
        final isAppRejected = submission.appStatus == AppReferralStatus.denied;

        return Scaffold(
          appBar: AppBar(
            titleSpacing: 20.w,
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.dynamic075,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_rounded,
                        size: 24.sp,
                        color: AppColors.dynamic,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          body: SafeArea(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 10.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Referral Details",
                                    style: TextStyles.bodySemiBold16(context),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                RichText(
                                  text: TextSpan(
                                    text: "#${submission.id.capitalize}",
                                    style: TextStyles.bodyRegular16(
                                      context,
                                      opacity: .5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4.h,
                              horizontal: 8.w,
                            ),
                            decoration: BoxDecoration(
                              color: submission.getAppStatusColor().withValues(
                                alpha: .1,
                              ),
                              borderRadius: BorderRadius.circular(1000.r),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: submission
                                    .appStatus
                                    .statusString
                                    .capitalize,
                                style: TextStyles.smallRegular12(context)
                                    .copyWith(
                                      color: submission.getAppStatusColor(),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.dynamic025,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Column(
                          spacing: 12.h,
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
                                  text: TextSpan(
                                    text: "Student Information",
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ],
                            ),

                            _buildLabel(
                              context,
                              label: "Full Name",
                              value: submission.fullName,
                            ),
                            _buildLabel(
                              context,
                              label: "Email",
                              value: submission.email,
                            ),
                            _buildLabel(
                              context,
                              label: "Phone",
                              value: submission.phone,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.dynamic025,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Column(
                          spacing: 12.h,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              spacing: 8.w,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  AssetsSvgIcons.details,
                                  width: 20.w,
                                  height: 20.h,
                                  fit: BoxFit.contain,
                                  colorFilter: ColorFilter.mode(
                                    AppColors.dynamic50,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Program Details",
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ],
                            ),
                            _buildLabel(
                              context,
                              label: "Country of Study",
                              value: submission.country,
                            ),
                            _buildLabel(
                              context,
                              label: "Intended Course",
                              value: submission.course,
                            ),
                            if (submission.additionalNotes.isNotEmpty)
                              _buildLabel(
                                context,
                                label: "Additional Notes",
                                value: submission.additionalNotes,
                              ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 16.h,
                          horizontal: 16.w,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.dynamic025,
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        child: Column(
                          spacing: 12.h,
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
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Referred By",
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 24.w,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.dynamic10,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        text: submission.referredBy.substring(
                                          0,
                                          1,
                                        ),
                                        style: TextStyles.normalSemibold14(
                                          context,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: 6.h,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: submission.referredBy,
                                          style: TextStyles.bodySemiBold16(
                                            context,
                                            opacity: .65,
                                          ),
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: submission.referrerEmail,
                                          style: TextStyles.bodyRegular16(
                                            context,
                                            opacity: .45,
                                          ),
                                        ),
                                      ),
                                    ],
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
                                    text: "Submitted: ",
                                    children: [
                                      TextSpan(
                                        text: formatDate(submission.createdAt),
                                        style: TextStyles.normalRegular14(
                                          context,
                                        ),
                                      ),
                                    ],
                                    style: TextStyles.normalRegular14(
                                      context,
                                      opacity: .5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (isAppRejected) ...[
                        SizedBox(height: 24.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.orange025,
                            borderRadius: BorderRadius.circular(14.r),
                          ),
                          child: Column(
                            spacing: 12.h,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Row(
                                spacing: 8.w,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    AssetsSvgIcons.note,
                                    width: 20.w,
                                    height: 20.h,
                                    fit: BoxFit.contain,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.orange50,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Reason for Cancellation",
                                      style: TextStyles.normalRegular14(context)
                                          .copyWith(
                                            color: isAppRejected
                                                ? AppColors.orange
                                                : null,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.orange5,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    text: submission.adminAppNote,
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: 32.h),

                      Row(
                        spacing: 10.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (submission.appStatus ==
                                  AppReferralStatus.pending ||
                              submission.appStatus ==
                                  AppReferralStatus.approved)
                            Expanded(
                              child: IconTextButton(
                                onPressed: () {
                                  rejectSubmissionDialog(
                                    submission: submission,
                                  );
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
                          if (submission.appStatus ==
                                  AppReferralStatus.pending ||
                              submission.appStatus == AppReferralStatus.denied)
                            Expanded(
                              child: IconTextButton(
                                onPressed: () {
                                  approveSubmissionDialog(
                                    submission: submission,
                                  );
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
                      SizedBox(height: 32.h),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Column _buildLabel(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Column(
      spacing: 4.h,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
            text: label,
            style: TextStyles.smallRegular12(context, opacity: .65),
          ),
        ),
        RichText(
          text: TextSpan(
            text: value,
            style: TextStyles.normalRegular14(context),
          ),
        ),
      ],
    );
  }
}

class SubmissionDetailsPageParam {
  final ReferralModel submission;

  SubmissionDetailsPageParam({required this.submission});
}
