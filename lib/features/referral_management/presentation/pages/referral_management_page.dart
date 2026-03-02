import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thressford_admin/core/constants/app_assets.dart';
import 'package:thressford_admin/core/utils/helpers.dart';
import 'package:thressford_admin/features/referral_management/data/models/response/referral_response_model.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/input/search_text_input.dart';
import '../../../../core/constants/app_colors.dart';

class ReferralManagementPage extends StatefulWidget {
  const ReferralManagementPage({super.key});

  @override
  State<ReferralManagementPage> createState() => _ReferralManagementPageState();
}

class _ReferralManagementPageState extends State<ReferralManagementPage> {
  final TextEditingController _inputController = TextEditingController();

  String searchText = "";

  List<ReferralModel> searchData = [];
  List<ReferralModel> payments = [
    ReferralModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      additionalNotes: "Student asked for an extension",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Referred",
      expectedCommission: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    ReferralModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      additionalNotes: "Student asked for an extension",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Contacted",
      expectedCommission: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    ReferralModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      additionalNotes: "Student asked for an extension",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Application Started",
      expectedCommission: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    ReferralModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      additionalNotes: "Student asked for an extension",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Paid",
      expectedCommission: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    ReferralModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      additionalNotes: "Student asked for an extension",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Paid",
      expectedCommission: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    ReferralModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      additionalNotes: "Student asked for an extension",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Paid",
      expectedCommission: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    ReferralModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      phone: "+44 20 1234 5678",
      course: "Biology",
      country: "Spain",
      additionalNotes: "Student asked for an extension",
      referredBy: "Peter Rocky",
      referrerEmail: "emma@example.com",
      status: "Paid",
      expectedCommission: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
  ];

  @override
  void initState() {
    super.initState();
    search();
  }

  void search() {
    searchData.clear();

    if (searchText.isEmpty) {
      searchData.addAll(payments);
    } else {
      searchData.addAll(
        payments
            .where(
              (element) =>
                  element.fullName.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.email.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.course.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.country.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.expectedCommission.toString().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.referredBy.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.email.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ),
            )
            .toList(),
      );
    }
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
                            text: "Referral Management",
                            style: TextStyles.bodySemiBold16(context),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "48,388 total referral",
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
                      color: AppColors.orange,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AssetsSvgIcons.stickyNote,
                        width: 20.sp,
                        height: 20.sp,
                        colorFilter: ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SearchTextInput(
                hintText: "Search Referrals",
                controller: _inputController,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                  search();
                },
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: searchData.length,
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  itemBuilder: (context, index) {
                    final referral = searchData[index];
                    return ReferralTile(referral: referral);
                  },
                  separatorBuilder: (_, _) => SizedBox(height: 16.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ReferralTile extends StatelessWidget {
  const ReferralTile({super.key, required this.referral});

  final ReferralModel referral;

  @override
  Widget build(BuildContext context) {
    final statusLower = referral.status.toLowerCase();
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
            spacing: 12.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Column(
                  spacing: 4.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: referral.fullName,
                        style: TextStyles.normalRegular14(context),
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: referral.email,
                        style: TextStyles.smallRegular12(context, opacity: .65),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: getReferralColor(statusLower).withValues(alpha: .05),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: RichText(
                  text: TextSpan(
                    text: referral.status,
                    style: TextStyles.smallRegular12(
                      context,
                    ).copyWith(color: getReferralColor(statusLower)),
                  ),
                ),
              ),
              Container(
                width: 36.w,
                height: 36.h,
                decoration: BoxDecoration(
                  color: AppColors.green11,
                  borderRadius: BorderRadius.circular(12.r),
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
                    text: referral.course,
                    style: TextStyles.smallRegular12(context),
                  ),
                ),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: referral.country,
                    style: TextStyles.smallRegular12(context),
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: 20.w,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
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
                                text: referral.referredBy,
                                style: TextStyles.normalRegular14(context),
                              ),
                            ],
                            text: "Referred by: ",
                            style: TextStyles.normalRegular14(
                              context,
                              opacity: .5,
                            ),
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
                                  referral.updatedAt ?? referral.createdAt,
                                ),
                                style: TextStyles.normalRegular14(context),
                              ),
                            ],
                            text: "Submitted: ",
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
              RichText(
                text: TextSpan(
                  text: "£${formatAmount(referral.expectedCommission)}",
                  style: TextStyles.normalMedium14(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Color getReferralColor(String status) {
  return switch (status.toLowerCase()) {
    'application started' => AppColors.orange,
    'contacted' => AppColors.green,
    'Referred' => AppColors.dynamic,
    'rejected' => AppColors.error,
    _ => AppColors.dynamic, // default
  };
}
