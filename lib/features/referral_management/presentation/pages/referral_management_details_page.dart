import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:thressford_admin/app/view/widgets/buttons/icon_text_button.dart';
import 'package:thressford_admin/core/utils/helpers.dart';
import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';
import 'package:thressford_admin/features/settings/data/models/admin_enum.dart';
import 'package:thressford_admin/features/settings/presentation/widgets/warning_dialog.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/loading/outer_loading.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../data/models/request/update_commission_status_request_model.dart';
import '../../data/models/response/referral_response_model.dart';
import '../bloc/referral_bloc.dart';
import '../widgets/commission_reversal_reason_dialog.dart';
import '../widgets/expected_commission_dialog.dart';

class ReferralManagementDetailsPage extends StatefulWidget {
  const ReferralManagementDetailsPage({super.key, required this.param});

  final ReferralManagementDetailsPageParam param;

  @override
  State<ReferralManagementDetailsPage> createState() =>
      _ReferralManagementDetailsPageState();
}

class _ReferralManagementDetailsPageState
    extends State<ReferralManagementDetailsPage>
    with UIToolMixin {
  ReferralModel referral = ReferralModel.empty();
  AdminRole currentRole = AdminRole.admin;

  @override
  void initState() {
    super.initState();
    referral = widget.param.referral;
    log("Referral Details ${referral.toJson()}");

    final profileBloc = context.read<DashboardBloc>();
    final userProfile = profileBloc.state.profile;
    currentRole = userProfile.role;
  }

  _releaseCommission() async {
    if (double.tryParse(referral.expectedCommission) == null ||
        double.parse(referral.expectedCommission) <= 0) {
      warningDialog(
        text:
            "Expected commission must be set before releasing commission. Please update the expected commission first.",
      );
    }
    context.read<ReferralBloc>().add(
      UpdateCommissionStatusEvent(
        request: UpdateCommissionStatusRequestModel(
          token: await LocalStorageHelper().getAccessToken() ?? "",
          email: referral.email,
          status: CommissionStatus.paid,
          note: "",
        ),
      ),
    );
  }

  _reverseCommission() async {
    if (double.tryParse(referral.expectedCommission) == null ||
        double.parse(referral.expectedCommission) <= 0) {
      warningDialog(
        text:
            "Expected commission must be set before releasing commission. Please update the expected commission first.",
      );
    }
    if (referral.commissionStatus != CommissionStatus.paid) {
      warningDialog(text: "Commission cannot be reversed");
    }
    commissionReversalReasonDialog(
      onTap: (value) async {
        context.read<ReferralBloc>().add(
          UpdateCommissionStatusEvent(
            request: UpdateCommissionStatusRequestModel(
              token: await LocalStorageHelper().getAccessToken() ?? "",
              email: referral.email,
              status: CommissionStatus.reversed,
              note: value,
            ),
          ),
        );
      },
    );
  }

  void _loadingReferralState(BuildContext context, ReferralLoadingState state) {
    if (state.type == ReferralType.updateCommissionStatus) {
      outerLoadingDialog(text: "Updating Commission Status");
    }
  }

  void _successReferralState(BuildContext context, ReferralSuccessState state) {
    if (state.type == ReferralType.updateCommissionStatus) {
      context.read<ReferralBloc>().add(GetAllReferralEvent());
      Future.delayed((Duration(seconds: 1)), () {
        if (Get.isDialogOpen == true) Navigator.pop(context);
        showMessage(context, state.message);
      });
    }
  }

  void _failedReferralState(BuildContext context, ReferralFailureState state) {
    if (state.type == ReferralType.updateCommissionStatus) {
      Future.delayed((Duration(seconds: 1)), () {
        if (Get.isDialogOpen == true) Navigator.pop(context);
        showMessage(context, state.message, status: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReferralBloc, ReferralState>(
      listener: (context, state) {
        if (state is ReferralLoadingState) {
          _loadingReferralState(context, state);
        } else if (state is ReferralSuccessState) {
          _successReferralState(context, state);
        } else if (state is ReferralFailureState) {
          _failedReferralState(context, state);
        }
      },
      builder: (context, state) {
        referral = state.referral.firstWhere(
          (element) => element.id == referral.id,
        );

        final isPending = referral.appStatus == AppReferralStatus.pending;
        final isAppRejected = referral.appStatus == AppReferralStatus.denied;
        final isCancelled =
            referral.enrollStatus == EnrollReferralStatus.cancelled;

        final bool canShowCommissionStatus =
            double.tryParse(referral.expectedCommission) == null ||
            double.parse(referral.expectedCommission) <= 0;
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RichText(
                                  text: TextSpan(
                                    text: "Referral Details",
                                    style: TextStyles.bodySemiBold16(context),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                RichText(
                                  text: TextSpan(
                                    text: "#${referral.id.capitalize}",
                                    style: TextStyles.bodyRegular16(
                                      context,
                                      opacity: .5,
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
                              color: isPending || isAppRejected
                                  ? referral.getAppStatusColor().withValues(
                                      alpha: .1,
                                    )
                                  : ReferralModel.getEnrollStatusColor(
                                      referral.enrollStatus,
                                    ).withValues(alpha: .1),
                              borderRadius: BorderRadius.circular(1000.r),
                            ),
                            child: RichText(
                              text: TextSpan(
                                text: isPending || isAppRejected
                                    ? referral.appStatus.statusString.capitalize
                                    : referral
                                          .enrollStatus
                                          .statusString
                                          .capitalize,
                                style: TextStyles.smallRegular12(context)
                                    .copyWith(
                                      color: isPending || isAppRejected
                                          ? referral.getAppStatusColor()
                                          : ReferralModel.getEnrollStatusColor(
                                              referral.enrollStatus,
                                            ),
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
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
                                    text: "Student Information",
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ],
                            ),
                            _buildLabel(
                              context,
                              label: "Full Name",
                              value: referral.fullName,
                            ),
                            _buildLabel(
                              context,
                              label: "Email",
                              value: referral.email,
                            ),
                            _buildLabel(
                              context,
                              label: "Phone",
                              value: referral.phone,
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
                                  AssetsSvgIcons.details,
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
                                    text: "Program Details",
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ],
                            ),
                            _buildLabel(
                              context,
                              label: "Country of Study",
                              value: referral.country,
                            ),
                            _buildLabel(
                              context,
                              label: "Intended Course",
                              value: referral.course,
                            ),
                            Row(
                              spacing: 10.w,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: _buildLabel(
                                    context,
                                    label: "Expected Commission",
                                    value:
                                        "£${formatAmount(double.parse(referral.expectedCommission))}",
                                  ),
                                ),
                                if (!canShowCommissionStatus)
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 4.h,
                                      horizontal: 8.w,
                                    ),
                                    decoration: BoxDecoration(
                                      color: referral
                                          .getCommissionStatusColor()
                                          .withValues(alpha: .1),
                                      borderRadius: BorderRadius.circular(
                                        1000.r,
                                      ),
                                    ),
                                    child: RichText(
                                      text: TextSpan(
                                        text: referral
                                            .commissionStatus
                                            .statusString
                                            .capitalize,
                                        style:
                                            TextStyles.smallRegular12(
                                              context,
                                            ).copyWith(
                                              color: referral
                                                  .getCommissionStatusColor(),
                                            ),
                                      ),
                                    ),
                                  ),
                                GestureDetector(
                                  onTap: () {
                                    if (isPending) {
                                      warningDialog(
                                        text:
                                            "The expected commission cannot be updated while this referral is still pending review. Please wait until the application has been approved.",
                                      );
                                      return;
                                    } else if (isAppRejected) {
                                      warningDialog(
                                        text:
                                            "The expected commission cannot be updated for a rejected application.",
                                      );
                                      return;
                                    }
                                    expectedCommissionDialog(
                                      referral: referral,
                                    );
                                  },
                                  child: Container(
                                    width: 24.w,
                                    height: 24.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6.r),
                                      border: Border.all(
                                        width: 1.r,
                                        color: AppColors.dynamic20,
                                      ),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        AssetsSvgIcons.plus,
                                        width: 16.w,
                                        height: 16.h,
                                        fit: BoxFit.contain,
                                        colorFilter: ColorFilter.mode(
                                          AppColors.dynamic,
                                          BlendMode.srcIn,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            if (currentRole.level >= 3 &&
                                !canShowCommissionStatus) ...[
                              if (referral.commissionStatus !=
                                  CommissionStatus.paid)
                                IconTextButton(
                                  onPressed: _releaseCommission,
                                  text: "Release Commission",
                                )
                              else if (referral.commissionStatus ==
                                  CommissionStatus.paid)
                                IconTextButton(
                                  onPressed: _reverseCommission,
                                  text: "Reverse Commission",
                                  color: AppColors.blue,
                                ),
                            ],
                          ],
                        ),
                      ),
                      if (referral.commissionNote.isNotEmpty) ...[
                        SizedBox(height: 24.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.blue5,
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
                                    AssetsSvgIcons.note,
                                    width: 20.w,
                                    height: 20.h,
                                    fit: BoxFit.contain,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.blue,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Reason for Reversal",
                                      style: TextStyles.normalRegular14(
                                        context,
                                      ).copyWith(color: AppColors.blue),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.blue10,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    text: referral.commissionNote,
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                                ),
                                RichText(
                                  text: TextSpan(
                                    text: "Referred By",
                                    style: TextStyles.normalRegular14(context),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              spacing: 24.w,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40.w,
                                  height: 40.h,
                                  decoration: BoxDecoration(
                                    color: AppColors.dynamic10,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: RichText(
                                      text: TextSpan(
                                        text: referral.referredBy.substring(
                                          0,
                                          1,
                                        ),
                                        style: TextStyles.normalSemibold14(
                                          context,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    spacing: 6.h,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: referral.referredBy,
                                          style: TextStyles.bodySemiBold16(
                                            context,
                                            opacity: .65,
                                          ),
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: referral.referrerEmail,
                                          style: TextStyles.bodyRegular16(
                                            context,
                                            opacity: .45,
                                          ),
                                        ),
                                      ),
                                    ],
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
                                    text: "Submitted: ",
                                    children: [
                                      TextSpan(
                                        text: formatDate(
                                          referral.updatedAt ??
                                              referral.createdAt,
                                        ),
                                        style: TextStyles.normalRegular14(
                                          context,
                                        ),
                                      ),
                                    ],
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
                      if (referral.adminEnrollNote.isNotEmpty) ...[
                        SizedBox(height: 24.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 16.w,
                          ),
                          decoration: BoxDecoration(
                            color: isCancelled
                                ? AppColors.orange025
                                : AppColors.dynamic025,
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
                                    AssetsSvgIcons.note,
                                    width: 20.w,
                                    height: 20.h,
                                    fit: BoxFit.contain,
                                    colorFilter: ColorFilter.mode(
                                      isCancelled
                                          ? AppColors.orange50
                                          : AppColors.dynamic50,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: isCancelled
                                          ? "Reason for Cancellation"
                                          : "Admin Notes",
                                      style: TextStyles.normalRegular14(context)
                                          .copyWith(
                                            color: isCancelled
                                                ? AppColors.orange
                                                : null,
                                          ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: isCancelled
                                      ? AppColors.orange5
                                      : AppColors.dynamic05,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Column(
                                  spacing: 4.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: referral.adminEnrollNote,
                                        style: TextStyles.normalRegular14(
                                          context,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      spacing: 8.w,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                            text: "Submitted: ",
                                            children: [
                                              TextSpan(
                                                text: formatDate(
                                                  referral.enrollModDate ??
                                                      DateTime.now()
                                                          .toIso8601String(),
                                                ),
                                              ),
                                            ],
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
                            ],
                          ),
                        ),
                      ],
                      if (referral.additionalNotes.isNotEmpty) ...[
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
                                    AssetsSvgIcons.note,
                                    width: 20.w,
                                    height: 20.h,
                                    fit: BoxFit.contain,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      text: "Internal Notes",
                                      style: TextStyles.normalRegular14(
                                        context,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 16.h,
                                  horizontal: 16.w,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.dynamic05,
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: Column(
                                  spacing: 4.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: referral.additionalNotes,
                                        style: TextStyles.normalRegular14(
                                          context,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      spacing: 8.w,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                            text: "Submitted: ",
                                            children: [
                                              TextSpan(
                                                text: formatDate(
                                                  referral.additionalNoteSubmittedAt ??
                                                      DateTime.now()
                                                          .toIso8601String(),
                                                ),
                                              ),
                                            ],
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
                            ],
                          ),
                        ),
                      ],
                      SizedBox(height: 32.h),
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

class ReferralManagementDetailsPageParam {
  final ReferralModel referral;

  ReferralManagementDetailsPageParam({required this.referral});
}
