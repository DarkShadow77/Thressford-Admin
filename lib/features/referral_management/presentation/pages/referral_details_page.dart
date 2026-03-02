import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:timelines_plus/timelines_plus.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../data/models/response/referral_response_model.dart';

class ReferralManagementDetailsPage extends StatefulWidget {
  const ReferralManagementDetailsPage({super.key, required this.param});

  final ReferralManagementDetailsPageParam param;

  @override
  State<ReferralManagementDetailsPage> createState() =>
      _ReferralManagementDetailsPageState();
}

class _ReferralManagementDetailsPageState
    extends State<ReferralManagementDetailsPage>
    with UIToolMixin {
  ReferralModel get referral => widget.param.referral;

  TimeLineStatus currentStatus = TimeLineStatus(
    icon: "",
    value: "",
    id: 0,
    title: "",
  );

  @override
  Widget build(BuildContext context) {
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
                                text: "#${referral.id.capitalize}",
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
                          color: AppColors.dynamic10,
                          borderRadius: BorderRadius.circular(1000.r),
                        ),
                        child: RichText(
                          text: TextSpan(
                            text: referral.status.capitalize,
                            style: TextStyles.smallRegular12(context),
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
                      color: AppColors.dynamic05,
                      borderRadius: BorderRadius.circular(14.r),
                    ),
                    child: Column(
                      spacing: 12.h,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Student Information",
                            style: TextStyles.normalRegular14(context),
                          ),
                        ),
                        Column(
                          spacing: 4.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Full Name",
                                style: TextStyles.smallRegular12(
                                  context,
                                  opacity: .65,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: referral.fullName,
                                style: TextStyles.normalRegular14(context),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 12.w,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 18.sp,
                              color: AppColors.dynamic40,
                            ),
                            Expanded(
                              child: Column(
                                spacing: 4.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: "Email",
                                      style: TextStyles.smallRegular12(
                                        context,
                                        opacity: .65,
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: referral.email,
                                      style: TextStyles.normalRegular14(
                                        context,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 12.w,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              Icons.phone_outlined,
                              size: 18.sp,
                              color: AppColors.dynamic40,
                            ),
                            Expanded(
                              child: Column(
                                spacing: 4.h,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                      text: "Phone",
                                      style: TextStyles.smallRegular12(
                                        context,
                                        opacity: .65,
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: referral.phone,
                                      style: TextStyles.normalRegular14(
                                        context,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          spacing: 12.w,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Row(
                                spacing: 12.w,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    AssetsSvgIcons.location,
                                    width: 16.w,
                                    height: 16.h,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.dynamic40,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      spacing: 4.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: "Country",
                                            style: TextStyles.smallRegular12(
                                              context,
                                              opacity: .65,
                                            ),
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: referral.country,
                                            style: TextStyles.normalRegular14(
                                              context,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Row(
                                spacing: 12.w,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SvgPicture.asset(
                                    AssetsSvgIcons.mortarboard,
                                    width: 16.w,
                                    height: 16.h,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.dynamic40,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      spacing: 4.h,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: "Course",
                                            style: TextStyles.smallRegular12(
                                              context,
                                              opacity: .65,
                                            ),
                                          ),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                            text: referral.course,
                                            style: TextStyles.normalRegular14(
                                              context,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Column(
                          spacing: 4.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: "Additional Notes",
                                style: TextStyles.smallRegular12(
                                  context,
                                  opacity: .65,
                                ),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: referral.additionalNotes,
                                style: TextStyles.normalRegular14(context),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),
                  if (referral.status == "pending")
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error5,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(width: 1.w, color: AppColors.error),
                      ),
                      child: Row(
                        spacing: 20.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                text: "Application Status",
                                style: TextStyles.smallRegular12(context),
                              ),
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 4.h,
                              horizontal: 8.w,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(1000.r),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: referral.status.capitalize,
                                style: TextStyles.smallRegular12(
                                  context,
                                ).copyWith(color: AppColors.error),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  else if (referral.status == "cancelled")
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.orange5,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(width: 1.w, color: AppColors.orange),
                      ),
                      child: Column(
                        spacing: 8.h,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Reason for cancellation",
                              style: TextStyles.smallRegular12(
                                context,
                              ).copyWith(color: AppColors.orange),
                            ),
                          ),
                          RichText(
                            text: TextSpan(
                              text: "Student stopped responding",
                              style: TextStyles.smallRegular12(context),
                            ),
                          ),
                        ],
                      ),
                    )
                  else
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.error5,
                        borderRadius: BorderRadius.circular(14.r),
                        border: Border.all(width: 1.w, color: AppColors.error),
                      ),
                      child: Row(
                        spacing: 20.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Column(
                              spacing: 4.h,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Commission Amount",
                                    style: TextStyles.smallRegular12(context),
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "\$200",
                                    style: TextStyles.bigTitleSemiBold24(
                                      context,
                                    ).copyWith(color: AppColors.error),
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
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(1000.r),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: referral.status.capitalize,
                                style: TextStyles.smallRegular12(
                                  context,
                                ).copyWith(color: AppColors.error),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  SizedBox(height: 24.h),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: statuses.length,
                    itemBuilder: (context, index) {
                      final status = statuses[index];
                      bool isSelected = status == currentStatus;
                      bool isMarked = status.id <= currentStatus.id;

                      bool isFirst = index == 0;
                      bool isLast = index == statuses.length - 1;
                      bool isPaid = status.value == "paid";
                      return TimelineTile(
                        nodePosition: 0,
                        nodeAlign: TimelineNodeAlign.basic,
                        contents: GestureDetector(
                          onTap: () {
                            setState(() {
                              currentStatus = status;
                            });
                          },
                          child: Container(
                            height: 75.h,
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 14.w,
                              vertical: 14.h,
                            ),
                            child: Column(
                              spacing: 4.h,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: status.title,
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                                if (isSelected)
                                  RichText(
                                    text: TextSpan(
                                      text: "Current status",
                                      style: TextStyles.smallRegular12(
                                        context,
                                      ).copyWith(color: AppColors.error),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        node: TimelineNode(
                          indicatorPosition: .3,
                          position: 0,
                          startConnector: isFirst
                              ? null
                              : DashedLineConnector(
                                  color: isMarked
                                      ? AppColors.green
                                      : AppColors.dynamic40,
                                ),
                          indicator: Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              color: isMarked
                                  ? isPaid
                                        ? AppColors.primary
                                        : AppColors.green
                                  : lighten(AppColors.dynamic, .95),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                isPaid
                                    ? AssetsSvgIcons.checkCircle
                                    : isMarked
                                    ? status.icon
                                    : AssetsSvgIcons.clock,
                                width: 20.w,
                                height: 20.h,
                                colorFilter: ColorFilter.mode(
                                  isMarked
                                      ? AppColors.white
                                      : AppColors.dynamic40,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                          ),
                          endConnector: isLast
                              ? null
                              : DashedLineConnector(
                                  color: isMarked
                                      ? AppColors.green
                                      : AppColors.dynamic40,
                                ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 32.h),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<TimeLineStatus> statuses = [
    TimeLineStatus(
      id: 0,
      title: "Submitted",
      icon: AssetsSvgIcons.mortarboard,
      value: "submitted",
    ),
    TimeLineStatus(
      id: 1,
      title: "Contacted by Thessford Global",
      icon: AssetsSvgIcons.mortarboard,
      value: "contacted",
    ),
    TimeLineStatus(
      id: 2,
      title: "Application Started",
      icon: AssetsSvgIcons.mortarboard,
      value: "started",
    ),
    TimeLineStatus(
      id: 3,
      title: "Documents Submitted",
      icon: AssetsSvgIcons.mortarboard,
      value: "document_submitted",
    ),
    TimeLineStatus(
      id: 4,
      title: "Offer Letter Issued",
      icon: AssetsSvgIcons.mortarboard,
      value: "letter_issued",
    ),
    TimeLineStatus(
      id: 5,
      title: "Visa Processing",
      icon: AssetsSvgIcons.mortarboard,
      value: "visa_processing",
    ),
    TimeLineStatus(
      id: 6,
      title: "Visa Approved",
      icon: AssetsSvgIcons.mortarboard,
      value: "visa_approval",
    ),
    TimeLineStatus(
      id: 7,
      title: "Enrolled",
      icon: AssetsSvgIcons.mortarboard,
      value: "enrolled",
    ),
    TimeLineStatus(
      id: 8,
      title: "Commission Eligible",
      icon: AssetsSvgIcons.mortarboard,

      value: "commission_eligible",
    ),
    TimeLineStatus(
      id: 9,
      title: "Paid",
      icon: AssetsSvgIcons.mortarboard,
      value: "paid",
    ),
  ];
}

class ReferralManagementDetailsPageParam {
  final ReferralModel referral;

  ReferralManagementDetailsPageParam({required this.referral});
}

class TimeLineStatus {
  final int id;
  final String title;
  final String icon;
  final String value;

  TimeLineStatus({
    required this.id,
    required this.title,
    required this.icon,
    required this.value,
  });
}
