import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/core/constants/app_assets.dart';
import 'package:thressford_admin/core/utils/helpers.dart';
import 'package:thressford_admin/features/user_management/data/models/response/users_response_model.dart';
import 'package:thressford_admin/features/user_management/data/models/users_management_status_enum.dart';
import 'package:thressford_admin/features/user_management/presentation/widgets/deactivate_user_dialog.dart';
import 'package:thressford_admin/features/user_management/presentation/widgets/suspend_user_dialog.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/input/search_text_input.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/navigators/route_name.dart';
import '../../../referral_management/presentation/bloc/referral_bloc.dart';
import '../bloc/users_bloc.dart';
import 'user_management_details_page.dart';

class UserManagementPage extends StatefulWidget {
  const UserManagementPage({super.key});

  @override
  State<UserManagementPage> createState() => _UserManagementPageState();
}

class _UserManagementPageState extends State<UserManagementPage> {
  final TextEditingController _inputController = TextEditingController();

  String searchText = "";

  String filterType = "";

  List<UsersModel> searchData = [];
  List<UsersModel> users = [];

  @override
  void initState() {
    super.initState();
    final userBloc = context.read<UsersBloc>();
    users = userBloc.state.users;
    userBloc.add(GetAllUsersEvent());
    context.read<ReferralBloc>().add(GetAllReferralEvent());

    searchData.addAll(users);
  }

  void search() {
    setState(() {
      searchData = users.where((users) {
        // Text search
        bool matchesSearch =
            searchText.isEmpty ||
            users.fullName.toLowerCase().contains(searchText.toLowerCase()) ||
            users.email.toLowerCase().contains(searchText.toLowerCase()) ||
            users.phone.toString().contains(searchText) ||
            users.bankName.toLowerCase().contains(searchText.toLowerCase()) ||
            users.acctName.toLowerCase().contains(searchText.toLowerCase());

        // Type/Status filter
        bool matchesType =
            filterType.isEmpty ||
            users.status.statusString.toLowerCase() == filterType.toLowerCase();

        return matchesSearch && matchesType;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UsersBloc, UsersState>(
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          users = state.users;
          search();
        });
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
                                text: "User Management",
                                style: TextStyles.bodySemiBold16(context),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    "${searchData.length} total user${searchData.length != 1 ? 's' : ''}",
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
                          color: AppColors.dynamic,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AssetsSvgIcons.userGroup,
                            width: 20.sp,
                            height: 20.sp,
                            colorFilter: ColorFilter.mode(
                              AppColors.inverseDynamic,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    spacing: 10.w,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SearchTextInput(
                          height: 56,
                          hintText: "Search User",
                          controller: _inputController,
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                            });
                            search();
                          },
                        ),
                      ),
                      PopupMenuButton<String>(
                        color: surfaceColor(),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.r),
                        ),
                        borderRadius: BorderRadius.circular(12.r),
                        shadowColor: AppColors.dynamic20,
                        position: PopupMenuPosition.under,
                        onSelected: (value) {
                          setState(() => filterType = value);
                          search();
                        },
                        menuPadding: EdgeInsets.symmetric(
                          vertical: 8.h,
                          horizontal: 4.w,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(maxWidth: 170.w),
                        itemBuilder: (context) =>
                            [
                                  ("", "All Users"),
                                  (
                                    UsersStatus.active.statusString,
                                    UsersStatus
                                            .active
                                            .statusString
                                            .capitalize ??
                                        "",
                                  ),
                                  (
                                    UsersStatus.inactive.statusString,
                                    UsersStatus
                                            .inactive
                                            .statusString
                                            .capitalize ??
                                        "",
                                  ),
                                  (
                                    UsersStatus.suspended.statusString,
                                    UsersStatus
                                            .suspended
                                            .statusString
                                            .capitalize ??
                                        "",
                                  ),
                                ]
                                .map(
                                  (e) => _buildPopupMenuItem(
                                    context,
                                    value: e.$1,
                                    text: e.$2,
                                    selected: filterType == e.$1,
                                  ),
                                )
                                .toList(),
                        child: Container(
                          width: 56.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.dynamic20),
                            borderRadius: BorderRadius.circular(14.r),
                            color: filterType.isNotEmpty
                                ? AppColors.primary50
                                : null,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              AssetsSvgIcons.filter,
                              width: 24.w,
                              height: 24.h,
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                filterType.isNotEmpty
                                    ? AppColors.white
                                    : AppColors.dynamic,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: searchData.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 48.sp,
                                  color: AppColors.dynamic50,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  "No Users found",
                                  style: TextStyles.bodyRegular16(
                                    context,
                                    opacity: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            itemCount: searchData.length,
                            physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 32.h),
                            itemBuilder: (context, index) {
                              final referral = searchData[index];
                              return UsersTile(user: referral);
                            },
                            separatorBuilder: (_, _) => SizedBox(height: 16.h),
                          ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class UsersTile extends StatelessWidget {
  const UsersTile({super.key, required this.user});

  final UsersModel user;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RouteName.userManagementDetailsPage,
        arguments: UserManagementDetailsPageParam(user: user),
      ),
      behavior: HitTestBehavior.opaque,
      child: Container(
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
              spacing: 16.w,
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
                      Column(
                        spacing: 6.h,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: user.fullName,
                              style: TextStyles.normalRegular14(context),
                            ),
                          ),
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text: user.email,
                              style: TextStyles.smallRegular12(
                                context,
                                opacity: .65,
                              ),
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: user.phone,
                          style: TextStyles.smallRegular12(
                            context,
                            opacity: .65,
                          ),
                        ),
                      ),

                      Row(
                        spacing: 16.w,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 8.w,
                              vertical: 4.h,
                            ),
                            decoration: BoxDecoration(
                              color: user.getUsersStatusColor().withValues(
                                alpha: .075,
                              ),
                              borderRadius: BorderRadius.circular(100.r),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: user.status.statusString.capitalize,
                                style: TextStyles.cardRegular10(
                                  context,
                                ).copyWith(color: user.getUsersStatusColor()),
                              ),
                            ),
                          ),
                          RichText(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            text: TextSpan(
                              text:
                                  "Joined ${formatDate(user.updatedAt ?? user.createdAt)}",
                              style: TextStyles.smallRegular12(
                                context,
                                opacity: .65,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  color: surfaceColor(),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                  shadowColor: AppColors.dynamic20,
                  position: PopupMenuPosition.under,
                  onSelected: (value) {
                    if (value == "view") {
                      Navigator.pushNamed(
                        context,
                        RouteName.userManagementDetailsPage,
                        arguments: UserManagementDetailsPageParam(user: user),
                      );
                    } else if (value == "deactivate") {
                      deactivateUserDialog(user: user);
                    } else if (value == "suspend") {
                      suspendUserDialog(user: user, suspend: true);
                    } else if (value == "unsuspend") {
                      suspendUserDialog(user: user, suspend: false);
                    }
                  },
                  menuPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(maxWidth: 170.w),
                  itemBuilder: (BuildContext context) => [
                    _buildPopupMenuItem(
                      context,
                      value: "view",
                      text: "See details",
                      icon: Icon(
                        Icons.remove_red_eye_outlined,
                        size: 20.sp,
                        color: AppColors.dynamic50,
                      ),
                    ),
                    if (user.status != UsersStatus.inactive) ...[
                      _buildPopupMenuItem(
                        context,
                        value: "deactivate",
                        text: "Deactivate",
                        color: AppColors.orange,
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedPause,
                          color: AppColors.orange,
                          size: 20.sp,
                        ),
                      ),
                      if (user.status == UsersStatus.suspended)
                        _buildPopupMenuItem(
                          context,
                          value: "unsuspend",
                          text: "Unsuspend",
                          color: AppColors.green,
                          icon: Icon(
                            Icons.check_rounded,
                            size: 20.sp,
                            color: AppColors.green,
                          ),
                        )
                      else
                        _buildPopupMenuItem(
                          context,
                          value: "suspend",
                          text: "Suspend",
                          color: AppColors.error,
                          icon: Icon(
                            Icons.close_outlined,
                            size: 20.sp,
                            color: AppColors.error,
                          ),
                        ),
                    ],
                  ],
                  child: Center(
                    child: Icon(
                      Icons.more_vert_rounded,
                      size: 20.sp,
                      color: AppColors.dynamic,
                    ),
                  ),
                ),
              ],
            ),
            Divider(height: 1.h, color: AppColors.dynamic15),
            IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: _buildContainer(
                      context,
                      right: false,
                      text: formatAmount(user.totalReferrals),
                      subtitle: "Referrals",
                    ),
                  ),
                  Expanded(
                    child: _buildContainer(
                      context,
                      text: "£${formatAmount(user.totalEarnings)}",
                      subtitle: "Earnings",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildContainer(
    BuildContext context, {
    bool right = true,
    required String text,
    required String subtitle,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
      decoration: BoxDecoration(
        color: AppColors.inverseDynamic80,
        borderRadius: BorderRadius.horizontal(
          right: right ? Radius.circular(14.r) : Radius.zero,
          left: !right ? Radius.circular(14.r) : Radius.zero,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 8.r,
            color: AppColors.dynamic15,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(text: text, style: TextStyles.bodyMedium16(context)),
          ),
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: subtitle,
              style: TextStyles.smallRegular12(context, opacity: .65),
            ),
          ),
        ],
      ),
    );
  }
}

PopupMenuItem<String> _buildPopupMenuItem(
  BuildContext context, {
  required String value,
  required String text,
  bool? selected,
  Color? color,
  Widget? icon,
}) {
  return PopupMenuItem<String>(
    height: 26.h,
    padding: EdgeInsets.zero,
    value: value,
    child: Container(
      width: 250.w,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: selected == true ? AppColors.dynamic10 : null,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        spacing: 4.w,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ?icon,
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: text,
              style: TextStyles.normalRegular14(context).copyWith(
                color:
                    color ??
                    (selected == true
                        ? AppColors.dynamic70
                        : AppColors.dynamic50),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
