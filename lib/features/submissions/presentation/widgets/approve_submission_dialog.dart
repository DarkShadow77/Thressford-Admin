import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/core/constants/enums/app_enum.dart';
import 'package:thressford_admin/features/submissions/presentation/widgets/submission_success_dialog.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../../referral_management/data/models/referral_status_enum.dart';
import '../../../referral_management/data/models/request/update_referral_app_status_request_model.dart';
import '../../../referral_management/data/models/response/referral_response_model.dart';
import '../../../referral_management/presentation/bloc/referral_bloc.dart';

Future<dynamic> approveSubmissionDialog({
  required ReferralModel submission,
}) async {
  return Get.dialog(
    name: "approve_submission_dialog",
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    ApproveSubmissionDialog(submission: submission),
  );
}

class ApproveSubmissionDialog extends StatefulWidget {
  const ApproveSubmissionDialog({super.key, required this.submission});

  final ReferralModel submission;

  @override
  State<ApproveSubmissionDialog> createState() =>
      _ApproveSubmissionDialogState();
}

class _ApproveSubmissionDialogState extends State<ApproveSubmissionDialog>
    with UIToolMixin {
  bool loading = false;

  void _submit() async {
    context.read<ReferralBloc>().add(
      UpdateReferralAppStatusEvent(
        request: UpdateReferralAppStatusRequestModel(
          email: widget.submission.email,
          appDate: DateTime.now().toLocal().toIso8601String(),
          appStat: AppReferralStatus.approved,
          token: await LocalStorageHelper().getAccessToken() ?? "",
          comment: "",
        ),
      ),
    );
  }

  void _loadingReferralState(BuildContext context, ReferralLoadingState state) {
    if (state.type == ReferralType.updateReferralAppStatus) {
      setState(() => loading = true);
    }
  }

  void _successReferralState(BuildContext context, ReferralSuccessState state) {
    if (state.type == ReferralType.updateReferralAppStatus) {
      context.read<ReferralBloc>().add(GetAllReferralEvent());
      Future.delayed((Duration(seconds: 1)), () {
        setState(() => loading = false);
        Navigator.pop(context);
        submissionSuccessfulDialog(
          submission: widget.submission,
          title: "Submission Approved",
          subTitle:
              "${widget.submission.fullName}’s details has been submitted successfully.",
        );
      });
    }
  }

  void _failedReferralState(BuildContext context, ReferralFailureState state) {
    if (state.type == ReferralType.updateReferralAppStatus) {
      setState(() => loading = false);
      showMessage(context, state.message, status: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ReferralBloc, ReferralState>(
      listener: (context, state) {
        if (state is ReferralLoadingState) {
          _loadingReferralState(context, state);
        } else if (state is ReferralSuccessState) {
          _successReferralState(context, state);
        } else if (state is ReferralFailureState) {
          _failedReferralState(context, state);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: Container(color: Colors.black.withValues(alpha: 0.2)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 525.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 16.h,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: surfaceColor(),
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 32.r,
                            width: 32.r,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: AppColors.dynamic10,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: HugeIcon(
                                icon: HugeIcons.strokeRoundedCancel01,
                                color: AppColors.dynamic,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 24.h),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: "Approve Submission?",
                              style: TextStyles.titleSemiBold20(context),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  "Are you sure you want to approve this referral submission?",
                              style: TextStyles.normalRegular14(
                                context,
                                opacity: .5,
                              ),
                            ),
                          ),
                          SizedBox(height: 56.h),
                          Row(
                            spacing: 10.w,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (!loading)
                                Expanded(
                                  child: IconTextButton(
                                    height: 53,
                                    onPressed: () => Navigator.pop(context),
                                    text: "Cancel",
                                    color: surfaceColor(),
                                    textColor: AppColors.dynamic,
                                    borderColor: AppColors.dynamic30,
                                  ),
                                ),
                              Expanded(
                                child: IconTextButton(
                                  height: 53,
                                  onPressed: () => _submit(),
                                  text: "Yes, Approve",
                                  buttonState: loading
                                      ? AppButtonState.loading
                                      : AppButtonState.idle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
