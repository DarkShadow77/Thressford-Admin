import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thressford_admin/app/view/widgets/buttons/theme_toggle.dart';
import 'package:thressford_admin/core/constants/navigators/route_name.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/theme/bloc/theme_bloc.dart';
import '../../../../app/view/widgets/thessford_icon.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/utils/helpers.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // UserProfile profile = UserProfile.empty();

  @override
  void initState() {
    super.initState();
    /*final profileBloc = context.read<ProfileBloc>();
    profile = profileBloc.state.userProfile;
    profileBloc.add(GetProfileEvent());*/
  }

  List<Map<String, String>> quickActions = [
    {"title": "User Management", "icon": AssetsSvgIcons.userGroup, "route": ""},
    {
      "title": "Referrals",
      "icon": AssetsSvgIcons.stickyNote,
      "route": RouteName.referralManagementPage,
    },
    {
      "title": "Submissions",
      "icon": AssetsSvgIcons.pound,
      "route": RouteName.submissionPage,
    },
    {
      "title": "Payments",
      "icon": AssetsSvgIcons.checkCircle,
      "route": RouteName.paymentPage,
    },
    {"title": "Reports", "icon": AssetsSvgIcons.rise, "route": ""},
    {
      "title": "Settings",
      "icon": AssetsSvgIcons.settings,
      "route": RouteName.settingsPage,
    },
    {"title": "Withdrawal Request", "icon": AssetsSvgIcons.pound, "route": ""},
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeMode>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 20.w,
            automaticallyImplyLeading: false,
            toolbarHeight: kToolbarHeight + 20.h,
            title: Row(
              spacing: 16.w,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ThessfordIcon(
                  width: 40,
                  height: 40,
                  iconColor: AppColors.white,
                  bgColor: AppColors.primary,
                  radius: 15,
                ),
                Expanded(
                  child: Column(
                    spacing: 4.h,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Admin Portal",
                          style: TextStyles.bodySemiBold16(context),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: "Dashboard",
                          style: TextStyles.bodyRegular16(
                            context,
                            opacity: .65,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ThemeToggle(),
                Container(
                  width: 40.r,
                  height: 40.r,
                  decoration: BoxDecoration(
                    color: AppColors.dynamic025,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: SvgPicture.asset(
                      AssetsSvgIcons.notification,
                      width: 24.w,
                      height: 24.h,
                      colorFilter: ColorFilter.mode(
                        AppColors.dynamic,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            centerTitle: false,
          ),
          body: SafeArea(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 24.h),
                      OverviewWidget(),
                      SizedBox(height: 32.h),
                      RichText(
                        text: TextSpan(
                          text: "Quick Actions",
                          style: TextStyles.bodyMedium16(context),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Wrap(
                        spacing: 12.w,
                        runSpacing: 12.h,
                        crossAxisAlignment: WrapCrossAlignment.start,
                        alignment: WrapAlignment.center,
                        children: quickActions.map((e) {
                          return SizedBox(
                            width: (AppSize.width - 40.w - 24.w) / 3,

                            child: QuickAction(
                              icon: e["icon"] as String,
                              text: e["title"] as String,
                              route: e["route"] as String,
                            ),
                          );
                        }).toList(),
                      ),
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
}

class QuickAction extends StatelessWidget {
  const QuickAction({
    super.key,
    required this.text,
    required this.icon,
    required this.route,
  });

  final String text;
  final String icon;
  final String route;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, route),
      borderRadius: BorderRadius.circular(14.r),
      child: Ink(
        height: 110.h,
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 14.w),
        decoration: BoxDecoration(
          color: surfaceColor(),
          borderRadius: BorderRadius.circular(14.r),
          boxShadow: [
            BoxShadow(
              offset: Offset(0, 1),
              color: AppColors.dynamic10,
              blurRadius: 5.r,
              spreadRadius: 2.r,
            ),
          ],
        ),
        child: Column(
          spacing: 6.h,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 40.r,
              width: 40.r,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.dynamic05,
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 20.w,
                  height: 20.h,
                  colorFilter: ColorFilter.mode(
                    AppColors.dynamic60,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: text,
                style: TextStyles.smallRegular12(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          spacing: 12.w,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: OverviewSubWidget(
                title: "Total users",
                value: formatAmount(24),
                color: isDark() ? AppColors.navyBlue : AppColors.dynamic,
                icon: AssetsSvgIcons.userGroup,
              ),
            ),
            Expanded(
              child: OverviewSubWidget(
                title: "Total Referrals",
                value: formatAmount(24),
                color: AppColors.orange,
                icon: AssetsSvgIcons.stickyNote,
              ),
            ),
          ],
        ),
        Row(
          spacing: 12.w,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: OverviewSubWidget(
                title: "Pending Commission",
                value: "£${formatAmount(2300)}",
                color: AppColors.primary,
                icon: AssetsSvgIcons.pound,
              ),
            ),
            Expanded(
              child: OverviewSubWidget(
                title: "Paid Commission",
                value: "£${formatAmount(2300)}",
                color: AppColors.green,
                icon: AssetsSvgIcons.checkCircle,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OverviewSubWidget extends StatelessWidget {
  const OverviewSubWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  final String title;
  final String value;
  final String icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: surfaceColor(),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            color: AppColors.dynamic10,
            blurRadius: 5.r,
            spreadRadius: 2.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 40.r,
            width: 40.r,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Center(
              child: SvgPicture.asset(
                icon,
                width: 20.w,
                height: 20.h,
                colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
              ),
            ),
          ),
          SizedBox(height: 12.h),
          RichText(
            text: TextSpan(
              text: value,
              style: TextStyles.titleSemiBold20(context),
            ),
          ),
          SizedBox(height: 4.h),
          RichText(
            text: TextSpan(
              text: title,
              style: TextStyles.smallRegular12(context, opacity: .75),
            ),
          ),
        ],
      ),
    );
  }
}
