import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/navigators/route_name.dart';

class CreateAdminSuccessPage extends StatefulWidget {
  const CreateAdminSuccessPage({super.key, required this.param});

  final CreateAdminSuccessPageParam param;
  @override
  State<CreateAdminSuccessPage> createState() => _CreateAdminSuccessPageState();
}

class _CreateAdminSuccessPageState extends State<CreateAdminSuccessPage> {
  bool copied = false;

  _onSubmit() {
    Navigator.of(
      context,
    ).pushNamedAndRemoveUntil(RouteName.dashboardPage, (route) => false);
  }

  _onCopy() {
    setState(() => copied = true);
    SharePlus.instance.share(
      ShareParams(
        text:
            'Admin Details\n'
            'Full name: ${widget.param.fullName}\n'
            'Email: ${widget.param.email}\n'
            'Password: ${widget.param.password}\n',
      ),
    );

    Future.delayed((Duration(seconds: 1)), () {
      setState(() => copied = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PopScope(
          canPop: false,
          onPopInvokedWithResult: (canPop, result) => _onSubmit(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      AssetsLogo.roundedLogo,
                      width: 32.w,
                      height: 32.h,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 16.h),
                      Image.asset(
                        AssetsPngImages.checkmark,
                        width: 48.w,
                        height: 48.h,
                      ),
                      SizedBox(height: 24.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: "Admin Created",
                          style: TextStyles.titleSemiBold20(context),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text:
                              "You have successfully created a new sub administrator",
                          style: TextStyles.bodyRegular16(context, opacity: .5),
                        ),
                      ),
                      SizedBox(height: 27.h),

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
                                    text: "Admin Information",
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ],
                            ),

                            _buildLabel(
                              context,
                              label: "Full Name",
                              value: widget.param.fullName,
                            ),
                            _buildLabel(
                              context,
                              label: "Email",
                              value: widget.param.email,
                            ),
                            _buildLabel(
                              context,
                              label: "Password",
                              value: widget.param.password,
                            ),
                            Divider(height: 1.h, color: AppColors.dynamic20),
                            IconTextButton(
                              onPressed: _onCopy,
                              iconWidget: copied
                                  ? HugeIcon(
                                      icon: HugeIcons.strokeRoundedTick01,
                                      size: 18.sp,
                                      color: AppColors.green,
                                    )
                                  : HugeIcon(
                                      icon: HugeIcons.strokeRoundedCopy01,
                                      size: 18.sp,
                                      color: AppColors.dynamic,
                                    ),
                              text: copied ? "Copied" : "Copy Details",
                              color: Colors.transparent,
                              textColor: copied
                                  ? AppColors.green
                                  : AppColors.dynamic,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 47.h),
                      IconTextButton(
                        onPressed: () => _onSubmit(),
                        text: "Back to Dashboard",
                        color: AppColors.primary,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
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

class CreateAdminSuccessPageParam {
  final String fullName;
  final String email;
  final String password;

  CreateAdminSuccessPageParam({
    required this.fullName,
    required this.email,
    required this.password,
  });
}
