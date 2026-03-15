import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/app/view/widgets/buttons/icon_text_button.dart';
import 'package:thressford_admin/core/constants/navigators/route_name.dart';
import 'package:thressford_admin/core/utils/helpers.dart';
import 'package:thressford_admin/features/user_management/data/models/users_management_status_enum.dart';
import 'package:thressford_admin/features/user_management/presentation/pages/user_referrals_page.dart';
import 'package:thressford_admin/features/user_management/presentation/widgets/deactivate_user_dialog.dart';
import 'package:thressford_admin/features/user_management/presentation/widgets/suspend_user_dialog.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../../dashboard/presentation/pages/dashboard_page.dart';
import '../../../referral_management/presentation/bloc/referral_bloc.dart';
import '../../data/models/response/users_response_model.dart';
import '../bloc/users_bloc.dart';

class UserManagementDetailsPage extends StatefulWidget {
  const UserManagementDetailsPage({super.key, required this.param});

  final UserManagementDetailsPageParam param;

  @override
  State<UserManagementDetailsPage> createState() =>
      _UserManagementDetailsPageState();
}

class _UserManagementDetailsPageState extends State<UserManagementDetailsPage>
    with UIToolMixin {
  UsersModel user = UsersModel.empty();

  @override
  void initState() {
    super.initState();
    user = widget.param.user;
    context.read<ReferralBloc>().add(GetAllReferralEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        user = state.users.firstWhere((element) => element.id == user.id);
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
                        spacing: 15.w,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 40.r,
                            height: 40.r,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.dynamic10,
                            ),
                            child: Center(
                              child: RichText(
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                text: TextSpan(
                                  text: user.fullName.substring(0, 1),
                                  style: TextStyles.normalRegular14(context),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              spacing: 8.h,
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: user.fullName,
                                    style: TextStyles.bodySemiBold16(context),
                                  ),
                                ),
                                RichText(
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: user.email,
                                    style: TextStyles.bodyRegular16(
                                      context,
                                      opacity: .65,
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
                              color: user.getUsersStatusColor().withValues(
                                alpha: .1,
                              ),
                              borderRadius: BorderRadius.circular(1000.r),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: user.status.statusString.capitalize,
                                style: TextStyles.smallRegular12(
                                  context,
                                ).copyWith(color: user.getUsersStatusColor()),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        spacing: 12.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => Navigator.pushNamed(
                                context,
                                RouteName.userReferralsPage,
                                arguments: UserReferralsPageParam(user: user),
                              ),
                              behavior: HitTestBehavior.opaque,
                              child: OverviewSubWidget(
                                title: "Total Referrals",
                                value: formatAmount(user.totalReferrals),
                                color: AppColors.orange,
                                icon: AssetsSvgIcons.stickyNote,
                              ),
                            ),
                          ),
                          Expanded(
                            child: OverviewSubWidget(
                              title: "Earnings",
                              value: "£${formatAmount(user.totalEarnings)}",
                              color: AppColors.green,
                              icon: AssetsSvgIcons.checkCircle,
                            ),
                          ),
                        ],
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
                                  colorFilter: ColorFilter.mode(
                                    AppColors.dynamic50,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Personal Information",
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ],
                            ),
                            _buildLabel(
                              context,
                              label: "Full Name",
                              value: user.fullName,
                            ),
                            _buildLabel(
                              context,
                              label: "Email",
                              value: user.email,
                            ),
                            _buildLabel(
                              context,
                              label: "Phone",
                              value: user.phone,
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
                                  AssetsSvgIcons.card,
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
                                    text: "Bank Information",
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ],
                            ),
                            _buildLabel(
                              context,
                              label: "Bank Name",
                              value: user.bankName.isEmpty
                                  ? "--"
                                  : user.bankName,
                            ),
                            Row(
                              spacing: 12.w,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: _buildLabel(
                                    context,
                                    label: "Account Number",
                                    value: user.acctNo.isEmpty
                                        ? "--"
                                        : user.acctNo,
                                  ),
                                ),
                                Expanded(
                                  child: _buildLabel(
                                    context,
                                    label: "Currency",
                                    value: "GPB (Pounds)",
                                  ),
                                ),
                              ],
                            ),
                            _buildLabel(
                              context,
                              label: "Account Name",
                              value: user.acctName.isEmpty
                                  ? "--"
                                  : user.acctName,
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
                                  text: TextSpan(
                                    text: "Account Activity",
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 12.w,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: _buildLabel(
                                    context,
                                    label: "Joined",
                                    value: formatDate(user.createdAt),
                                  ),
                                ),

                                Expanded(
                                  child: _buildLabel(
                                    context,
                                    label: "Last Active",
                                    value: formatDate(user.createdAt),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      if (user.status != UsersStatus.inactive) ...[
                        SizedBox(height: 40.h),
                        IconTextButton(
                          height: 44,
                          radius: 14,
                          onPressed: () {
                            deactivateUserDialog(user: user);
                          },
                          text: "Deactivate",
                          color: AppColors.orange5,
                          textColor: AppColors.orange,
                          borderColor: AppColors.orange,
                          iconWidget: HugeIcon(
                            icon: HugeIcons.strokeRoundedPause,
                            color: AppColors.orange,
                            size: 20.sp,
                          ),
                        ),
                        SizedBox(height: 16.h),
                        if (user.status == UsersStatus.suspended) ...[
                          IconTextButton(
                            height: 44,
                            radius: 14,
                            onPressed: () {
                              suspendUserDialog(user: user, suspend: false);
                            },
                            text: "Unsuspend",
                            color: AppColors.green5,
                            textColor: AppColors.green,
                            borderColor: AppColors.green,
                            iconWidget: Icon(
                              Icons.check_rounded,
                              size: 20.sp,
                              color: AppColors.green,
                            ),
                          ),
                          SizedBox(height: 16.h),
                        ] else
                          IconTextButton(
                            height: 44,
                            radius: 14,
                            onPressed: () {
                              suspendUserDialog(user: user, suspend: true);
                            },
                            text: "Suspend",
                            color: AppColors.error5,
                            textColor: AppColors.error,
                            borderColor: AppColors.error,
                            iconWidget: Icon(
                              Icons.close_outlined,
                              size: 20.sp,
                              color: AppColors.error,
                            ),
                          ),
                      ],
                      SizedBox(
                        height:
                            32.h + MediaQuery.of(context).viewPadding.bottom,
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

class UserManagementDetailsPageParam {
  final UsersModel user;

  UserManagementDetailsPageParam({required this.user});
}
