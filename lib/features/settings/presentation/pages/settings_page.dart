import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thressford_admin/core/constants/app_assets.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/theme/bloc/theme_bloc.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/navigators/route_name.dart';
import '../../../../core/utils/helpers.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
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
                                text: "Settings",
                                style: TextStyles.bodySemiBold16(context),
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
                            AssetsSvgIcons.settings,
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
                  Expanded(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(
                        parent: AlwaysScrollableScrollPhysics(),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 32.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Admin",
                              style: TextStyles.bodyMedium16(context),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Column(
                            spacing: 12.h,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SettingsTile(
                                icon: AssetsSvgIcons.password,
                                title: "Manage Admins",
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  RouteName.manageAdminPage,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 24.h),
                          RichText(
                            text: TextSpan(
                              text: "Preferences",
                              style: TextStyles.bodyMedium16(context),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          Column(
                            spacing: 12.h,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SettingsTile(
                                icon: AssetsSvgIcons.moon2,
                                title: "Dark Mode",
                                onTap: () {
                                  context.read<ThemeBloc>().add(
                                    ThemeChanged(!isDark()),
                                  );
                                },
                                trailing: SizedBox(
                                  height: 30.h,
                                  child: Transform.scale(
                                    scale: .6,
                                    child: Switch(
                                      value: isDark(),
                                      materialTapTargetSize:
                                          MaterialTapTargetSize.shrinkWrap,
                                      onChanged: (bool value) {
                                        context.read<ThemeBloc>().add(
                                          ThemeChanged(!isDark()),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                              SettingsTile(
                                icon: AssetsSvgIcons.password,
                                title: "Change Password",
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  RouteName.changePasswordPage,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconTextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, RouteName.logoutPage),
                    text: "Log Out",
                    color: AppColors.primary10,
                    iconSize: 24,
                    icon: AssetsSvgIcons.logout,
                    iconColor: AppColors.primary50,
                    borderColor: AppColors.primary10,
                    textColor: AppColors.primary50,
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class SettingsTile extends StatelessWidget {
  const SettingsTile({
    super.key,
    required this.icon,
    required this.title,
    this.subTitle,
    this.trailing,
    this.onTap,
  });

  final String icon;
  final String title;
  final String? subTitle;
  final Widget? trailing;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14.r),
      child: Ink(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(width: 1.w, color: AppColors.dynamic25),
        ),
        child: Row(
          spacing: 16.w,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40.w,
              height: 40.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.dynamic075,
              ),
              child: Center(
                child: SvgPicture.asset(
                  icon,
                  width: 24.w,
                  height: 24.h,
                  colorFilter: ColorFilter.mode(
                    AppColors.dynamic75,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                spacing: 8.h,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: title,
                      style: TextStyles.normalRegular14(context),
                    ),
                  ),
                  if (subTitle != null)
                    RichText(
                      text: TextSpan(
                        text: subTitle,
                        style: TextStyles.smallRegular12(context, opacity: .65),
                      ),
                    ),
                ],
              ),
            ),
            trailing ??
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20.sp,
                  color: AppColors.dynamic20,
                ),
          ],
        ),
      ),
    );
  }
}
