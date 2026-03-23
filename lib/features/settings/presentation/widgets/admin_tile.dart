import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:share_plus/share_plus.dart';
import 'package:thressford_admin/features/settings/data/models/admin_enum.dart';
import 'package:thressford_admin/features/settings/presentation/widgets/admin_status_dialog.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../data/models/response/admin_response_model.dart';
import 'delete_admin_dialog.dart';
import 'warning_dialog.dart';

class AdminTile extends StatelessWidget {
  const AdminTile({
    super.key,
    required this.admin,
    required this.currentUserRole,
  });

  final AdminModel admin;
  final AdminRole currentUserRole;

  @override
  Widget build(BuildContext context) {
    final isDeleted = admin.isDeleted == "1";
    final canManage = currentUserRole.canManageAdmin(admin.role);
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: "Admin Information",
                    style: TextStyles.normalRegular14(context),
                  ),
                ),
              ),

              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: isDeleted
                      ? AppColors.error10
                      : admin.getAdminStatusColor().withValues(alpha: .1),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: RichText(
                  text: TextSpan(
                    text: isDeleted
                        ? "Deleted"
                        : admin.status.statusString.capitalize,
                    style: TextStyles.smallRegular12(context).copyWith(
                      color: isDeleted
                          ? AppColors.error
                          : admin.getAdminStatusColor(),
                    ),
                  ),
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
                  // Block action if no permission
                  if (!canManage) {
                    warningDialog(
                      text:
                          "You don't have permission to manage admins at this level or above.",
                    );
                    return;
                  }
                  if (value == "copy") {
                    SharePlus.instance.share(
                      ShareParams(
                        text:
                            'Admin Details\n'
                            'Full name: ${admin.fullName}\n'
                            'Email: ${admin.email}\n',
                      ),
                    );
                  } else if (value == "deactivate") {
                    adminStatusDialog(admin: admin, deactivate: true);
                  } else if (value == "activate") {
                    adminStatusDialog(admin: admin, deactivate: false);
                  } else if (value == "delete") {
                    deleteAdminDialog(admin: admin);
                  } else if (value == "restore") {
                    deleteAdminDialog(admin: admin, restore: true);
                  }
                },
                menuPadding: EdgeInsets.symmetric(
                  vertical: 8.h,
                  horizontal: 12.w,
                ),
                padding: EdgeInsets.zero,
                constraints: BoxConstraints(maxWidth: 170.w),
                itemBuilder: (BuildContext context) => [
                  if (!isDeleted) ...[
                    _buildPopupMenuItem(
                      context,
                      value: "copy",
                      text: "Copy details",
                      icon: HugeIcon(
                        icon: HugeIcons.strokeRoundedCopy01,
                        size: 20.sp,
                        color: AppColors.dynamic50,
                      ),
                    ),
                    if (canManage) ...[
                      if (admin.status != AdminStatus.inactive)
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
                        )
                      else
                        _buildPopupMenuItem(
                          context,
                          value: "activate",
                          text: "Activate",
                          color: AppColors.green,
                          icon: HugeIcon(
                            icon: HugeIcons.strokeRoundedPlay,
                            color: AppColors.green,
                            size: 20.sp,
                          ),
                        ),
                    ],
                  ],
                  if (canManage) ...[
                    if (!isDeleted)
                      _buildPopupMenuItem(
                        context,
                        value: "delete",
                        text: "Delete",
                        color: AppColors.error,
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedCancel01,
                          color: AppColors.error,
                          size: 20.sp,
                        ),
                      )
                    else
                      _buildPopupMenuItem(
                        context,
                        value: "restore",
                        text: "Restore",
                        color: AppColors.green,
                        icon: HugeIcon(
                          icon: HugeIcons.strokeRoundedRecycle03,
                          color: AppColors.green,
                          size: 20.sp,
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
          _buildLabel(context, label: "Full Name", value: admin.fullName),
          _buildLabel(context, label: "Email", value: admin.email),
          _buildLabel(
            context,
            label: "Role",
            value: admin.role.statusString.capitalize ?? "--",
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
                  text: "Created: ",
                  children: [TextSpan(text: formatDate(admin.createdAt))],
                  style: TextStyles.normalRegular14(context, opacity: .5),
                ),
              ),
            ],
          ),
        ],
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
