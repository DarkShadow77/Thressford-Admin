import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thressford_admin/app/view/widgets/buttons/icon_text_button.dart';
import 'package:thressford_admin/core/constants/app_assets.dart';
import 'package:thressford_admin/core/utils/helpers.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/response/submission_response_model.dart';
import '../widgets/approve_submission_dialog.dart';
import '../widgets/reason_dialog.dart';
import '../widgets/reject_submission_dialog.dart';
import '../widgets/submission_success_dialog.dart';

class SubmissionPage extends StatefulWidget {
  const SubmissionPage({super.key});

  @override
  State<SubmissionPage> createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  String status = "pending";

  List<SubmissionModel> submissions = [
    SubmissionModel(
      id: "00977",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Pending",
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    SubmissionModel(
      id: "00977",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Pending",
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    SubmissionModel(
      id: "00977",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Pending",
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    SubmissionModel(
      id: "00977",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Approved",
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    SubmissionModel(
      id: "00977",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Approved",
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    SubmissionModel(
      id: "00977",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Approved",
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    SubmissionModel(
      id: "00977",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Rejected",
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    SubmissionModel(
      id: "00977",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Rejected",
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    SubmissionModel(
      id: "00977",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Rejected",
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
  ];

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20.w,
        automaticallyImplyLeading: false,
        toolbarHeight: kToolbarHeight + 20.h,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.dynamic05,
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.h),
              Row(
                spacing: 16.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 8.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Submission Approval",
                            style: TextStyles.bodySemiBold16(context),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "288 submissions",
                            style: TextStyles.bodyRegular16(
                              context,
                              opacity: .75,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.dynamic05,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AssetsSvgIcons.checkCircle,
                        width: 20.sp,
                        height: 20.sp,
                        colorFilter: ColorFilter.mode(
                          AppColors.dynamic60,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Divider(height: 1.h, color: AppColors.dynamic10),
              SizedBox(height: 20.h),
              Container(
                height: 45.h,
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: dynamicColor(.03),
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: TabBar(
                  isScrollable: false,
                  padding: EdgeInsets.zero,
                  unselectedLabelStyle: TextStyles.normalRegular14(context),
                  dividerColor: Colors.transparent,
                  labelStyle: TextStyles.normalSemibold14(context),
                  labelColor: AppColors.white,
                  unselectedLabelColor: dynamicColor(.65),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: lighten(AppColors.primary, .9),
                  indicator: BoxDecoration(
                    color: AppColors.navyBlue,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  controller: tabController,
                  tabs: [
                    Tab(text: 'Pending'),
                    Tab(text: 'Approved '),
                    Tab(text: 'Rejected'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: tabController,
                  children: [
                    TabViewWidget(status: "pending", submissions: submissions),
                    TabViewWidget(status: "approved", submissions: submissions),
                    TabViewWidget(status: "rejected", submissions: submissions),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TabViewWidget extends StatelessWidget {
  const TabViewWidget({
    super.key,
    required this.status,
    required this.submissions,
  });

  final String status;
  final List<SubmissionModel> submissions;

  List<SubmissionModel> get filteredSubmission => submissions
      .where((element) => element.status.toLowerCase() == status.toLowerCase())
      .toList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: filteredSubmission.length,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.symmetric(vertical: 20.h),
      itemBuilder: (context, index) {
        final submission = filteredSubmission[index];

        return SubmissionTile(submission: submission);
      },
      separatorBuilder: (_, _) => SizedBox(height: 16.h),
    );
  }
}

class SubmissionTile extends StatelessWidget {
  const SubmissionTile({super.key, required this.submission});

  final SubmissionModel submission;

  @override
  Widget build(BuildContext context) {
    final statusLower = submission.status.toLowerCase();
    return Container(
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
                        style: TextStyles.smallRegular12(context, opacity: .65),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: getSubmissionColor(
                    submission.status,
                  ).withValues(alpha: .05),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: RichText(
                  text: TextSpan(
                    text: submission.status,
                    style: TextStyles.smallRegular12(
                      context,
                    ).copyWith(color: getSubmissionColor(submission.status)),
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
                          text: formatDate(
                            submission.updatedAt ?? submission.createdAt,
                          ),
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
              if (statusLower == "pending")
                Expanded(
                  child: IconTextButton(
                    onPressed: () {
                      rejectSubmissionDialog(submission: submission);
                    },
                    height: 42,
                    text: "Reject",
                    iconWidget: Icon(
                      Icons.cancel_outlined,
                      color: AppColors.error,
                      size: 20.sp,
                    ),
                    textColor: AppColors.error,
                    color: AppColors.error5,
                  ),
                ),
              if (statusLower == "pending" || statusLower == "rejected")
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
              if (statusLower == "approved")
                Expanded(
                  child: IconTextButton(
                    onPressed: () {
                      submissionReasonDialog(
                        submission: submission,
                        title: "Reason for Cancellation",
                        onTap: () {
                          submissionSuccessfulDialog(
                            submission: submission,
                            title: "Submission Cancelled",
                            subTitle:
                                "${submission.fullName}’s submission has been cancelled",
                          );
                        },
                      );
                    },
                    height: 42,
                    iconWidget: Icon(
                      Icons.cancel_outlined,
                      color: AppColors.error,
                      size: 20.sp,
                    ),
                    text: "Cancel",
                    iconColor: AppColors.error,
                    textColor: AppColors.error,
                    color: AppColors.error5,
                    borderColor: AppColors.error,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

Color getSubmissionColor(String status) {
  return switch (status.toLowerCase()) {
    'pending' => AppColors.orange,
    'approved' => AppColors.green,
    'rejected' => AppColors.error,
    _ => AppColors.dynamic, // default
  };
}

class Notice extends StatelessWidget {
  const Notice({super.key, required this.status});

  final String status;

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
            child: RichText(
              text: TextSpan(
                text: status.toLowerCase() == "approved"
                    ? "Resets every 30 days, as all approved submissions will be moved to referrals"
                    : status.toLowerCase() == "rejected"
                    ? "Resets every 30 days, as all will be in referrals"
                    : "",
                style: TextStyles.cardRegular10(context),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
