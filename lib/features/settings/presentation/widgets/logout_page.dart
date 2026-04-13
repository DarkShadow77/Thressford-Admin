import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/enums/app_enum.dart';
import '../../../../core/constants/navigators/route_name.dart';
import '../../../../core/session/session_manager.dart';

class LogoutPage extends StatefulWidget {
  const LogoutPage({super.key});

  @override
  State<LogoutPage> createState() => _LogoutPageState();
}

class _LogoutPageState extends State<LogoutPage> {
  bool loading = false;

  void _submit() {
    setState(() => loading = true);

    Future.delayed((Duration(seconds: 2)), () {
      setState(() => loading = false);
      SessionManager.instance.dispose();
      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteName.loginPage,
        (route) => false,
      );
    });
  }

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
                  SizedBox(height: 240.h),
                  Container(
                    width: 56.r,
                    height: 56.r,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.dynamic075,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AssetsSvgIcons.logout,
                        width: 33.6.w,
                        height: 33.6.h,
                      ),
                    ),
                  ),
                  SizedBox(height: 24.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Log Out",
                      style: TextStyles.titleSemiBold20(context),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Are you sure you want to log out?",
                      style: TextStyles.bodyRegular16(context, opacity: .5),
                    ),
                  ),
                  SizedBox(height: 32.h),
                ]),
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              sliver: SliverFillRemaining(
                hasScrollBody: false,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconTextButton(
                      onPressed: _submit,
                      text: "Yes, log out",
                      color: AppColors.primary,
                      buttonState: loading
                          ? AppButtonState.loading
                          : AppButtonState.idle,
                    ),
                    SizedBox(height: 16.h),
                    IconTextButton(
                      onPressed: () => Navigator.pop(context),
                      text: "Cancel",
                      color: Colors.transparent,
                      borderColor: AppColors.dynamic30,
                      textColor: AppColors.dynamic50,
                    ),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
