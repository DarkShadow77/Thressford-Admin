import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thressford_admin/core/constants/app_assets.dart';
import 'package:thressford_admin/core/utils/helpers.dart';
import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';
import 'package:thressford_admin/features/referral_management/data/models/response/referral_response_model.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../referral_management/presentation/bloc/referral_bloc.dart';
import '../widgets/submission_tile.dart';

class SubmissionPage extends StatefulWidget {
  const SubmissionPage({super.key});

  @override
  State<SubmissionPage> createState() => _SubmissionPageState();
}

class _SubmissionPageState extends State<SubmissionPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  String status = "pending";

  List<ReferralModel> submissions = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    context.read<ReferralBloc>().add(GetAllReferralEvent());
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferralBloc, ReferralState>(
      builder: (context, state) {
        submissions = state.referral;

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
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
                                    text:
                                        "${formatAmount(submissions.length)} submissions",
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
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: dynamicColor(.03),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: TabBar(
                          isScrollable: false,
                          padding: EdgeInsets.zero,
                          unselectedLabelStyle: TextStyles.normalRegular14(
                            context,
                          ),
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
                            Tab(text: 'Denied'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      TabViewWidget(
                        status: AppReferralStatus.pending,
                        submissions: submissions,
                      ),
                      TabViewWidget(
                        status: AppReferralStatus.approved,
                        submissions: submissions,
                      ),
                      TabViewWidget(
                        status: AppReferralStatus.denied,
                        submissions: submissions,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TabViewWidget extends StatelessWidget {
  const TabViewWidget({
    super.key,
    required this.status,
    required this.submissions,
  });

  final AppReferralStatus status;
  final List<ReferralModel> submissions;

  List<ReferralModel> get filteredSubmission =>
      submissions.where((element) => element.appStatus == status).toList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: filteredSubmission.length,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      itemBuilder: (context, index) {
        final submission = filteredSubmission[index];

        return SubmissionTile(submission: submission);
      },
      separatorBuilder: (_, _) => SizedBox(height: 16.h),
    );
  }
}
