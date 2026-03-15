import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thressford_admin/core/utils/local_storage.dart';
import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';
import 'package:thressford_admin/features/referral_management/data/models/request/update_enroll_status_request_model.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/navigators/route_name.dart';
import '../../../../core/utils/helpers.dart';
import '../../data/models/response/referral_response_model.dart';
import '../bloc/referral_bloc.dart';
import '../pages/referral_management_details_page.dart';
import 'add_notes_dialog.dart';
import 'update_enroll_status_modal.dart';

class ReferralTile extends StatelessWidget {
  const ReferralTile({super.key, required this.referral});

  final ReferralModel referral;

  void _onSelect(BuildContext context, String value) {
    if (value == "view") {
      Navigator.pushNamed(
        context,
        RouteName.referralManagementDetailsPage,
        arguments: ReferralManagementDetailsPageParam(referral: referral),
      );
    } else if (value == "update") {
      final isCurrentCancelled =
          referral.enrollStatus == EnrollReferralStatus.cancelled;
      updateEnrollStatusModal(
        referral: referral,
        onPressed: (value, comment) async {
          context.read<ReferralBloc>().add(
            UpdateEnrollStatusEvent(
              request: UpdateEnrollStatusRequestModel(
                token: await LocalStorageHelper().getAccessToken() ?? "",
                email: referral.email,
                status: value,
                comment:
                    comment ??
                    (isCurrentCancelled ? "" : referral.adminEnrollNote),
                enrollDate: DateTime.now().toLocal().toIso8601String(),
              ),
            ),
          );
        },
      );
    } else if (value == "add note") {
      addNotesDialog(
        note: referral.adminEnrollNote,
        onTap: (value) async {
          context.read<ReferralBloc>().add(
            UpdateEnrollStatusEvent(
              request: UpdateEnrollStatusRequestModel(
                token: await LocalStorageHelper().getAccessToken() ?? "",
                email: referral.email,
                status: referral.enrollStatus,
                comment: value,
                enrollDate: DateTime.now().toLocal().toIso8601String(),
              ),
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isCancelled =
        referral.enrollStatus == EnrollReferralStatus.cancelled;
    return GestureDetector(
      onTap: () => Navigator.pushNamed(
        context,
        RouteName.referralManagementDetailsPage,
        arguments: ReferralManagementDetailsPageParam(referral: referral),
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
                          style: TextStyles.smallRegular12(
                            context,
                            opacity: .65,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: ReferralModel.getEnrollStatusColor(
                      referral.enrollStatus,
                    ).withValues(alpha: .05),
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                  child: RichText(
                    text: TextSpan(
                      text: referral.enrollStatus.statusString.capitalize,
                      style: TextStyles.smallRegular12(context).copyWith(
                        color: ReferralModel.getEnrollStatusColor(
                          referral.enrollStatus,
                        ),
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
                  onSelected: (value) => _onSelect(context, value),
                  menuPadding: EdgeInsets.symmetric(
                    vertical: 8.h,
                    horizontal: 12.w,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: BoxConstraints(maxWidth: 150.w),
                  itemBuilder: (BuildContext context) => [
                    _buildPopupMenuItem(
                      context,
                      value: "view",
                      text: "View Details",
                    ),
                    _buildPopupMenuItem(
                      context,
                      value: "update",
                      text: "Update Status",
                    ),
                    _buildPopupMenuItem(
                      context,
                      value: "add note",
                      text: "Add Notes",
                    ),
                  ],
                  child: Container(
                    width: 36.w,
                    height: 36.h,
                    decoration: BoxDecoration(
                      color: AppColors.green11,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AssetsSvgIcons.edit,
                        width: 24.w,
                        height: 24.h,
                        fit: BoxFit.contain,
                      ),
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
                    text:
                        "£${formatAmount(double.parse(referral.expectedCommission))}",
                    style: TextStyles.normalMedium14(context),
                  ),
                ),
              ],
            ),
            if (referral.adminEnrollNote.isNotEmpty)
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: isCancelled ? AppColors.orange5 : AppColors.dynamic05,
                  borderRadius: BorderRadius.circular(14.r),
                  border: Border.all(
                    width: 1.w,
                    color: isCancelled ? AppColors.orange : AppColors.dynamic20,
                  ),
                ),
                child: Column(
                  spacing: 8.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: isCancelled
                            ? "Reason for Cancellation"
                            : "Admin Note",
                        style: TextStyles.smallRegular12(context).copyWith(
                          color: isCancelled
                              ? AppColors.orange
                              : AppColors.dynamic,
                        ),
                      ),
                    ),
                    RichText(
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: referral.adminEnrollNote,
                        style: TextStyles.smallRegular12(context, opacity: .5),
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

  PopupMenuItem<String> _buildPopupMenuItem(
    BuildContext context, {
    required String value,
    required String text,
    Color? color,
  }) {
    return PopupMenuItem<String>(
      height: 26.h,
      padding: EdgeInsets.zero,
      value: value,
      child: Container(
        width: 200.w,
        padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(14.r)),
        child: RichText(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          text: TextSpan(
            text: text,
            style: TextStyles.normalRegular14(
              context,
            ).copyWith(color: color ?? AppColors.dynamic50),
          ),
        ),
      ),
    );
  }
}
