import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/app/view/widgets/input/input_title.dart';
import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';
import 'package:thressford_admin/features/referral_management/data/models/response/referral_response_model.dart';
import 'package:thressford_admin/features/referral_management/presentation/bloc/referral_bloc.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../app/view/widgets/input/text_area_field.dart';
import '../../../../core/constants/enums/app_enum.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../../referral_management/data/models/request/update_referral_app_status_request_model.dart';
import 'submission_success_dialog.dart';

Future<dynamic> submissionRejectionReasonDialog({
  required ReferralModel submission,
  required String title,
}) async {
  return Get.dialog(
    name: "submission_rejection_reason_dialog",
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    SubmissionRejectionReasonDialog(submission: submission, title: title),
  );
}

class SubmissionRejectionReasonDialog extends StatefulWidget {
  const SubmissionRejectionReasonDialog({
    super.key,
    required this.submission,
    required this.title,
  });

  final ReferralModel submission;
  final String title;

  @override
  State<SubmissionRejectionReasonDialog> createState() =>
      _SubmissionRejectionReasonDialogState();
}

class _SubmissionRejectionReasonDialogState
    extends State<SubmissionRejectionReasonDialog>
    with UIToolMixin {
  final TextEditingController _reasonController = TextEditingController();

  bool _isReasonValid = false;
  bool _isFormValid = true;

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _reasonController.dispose();
    super.dispose();
  }

  void _validateForm() {
    String reason = _reasonController.text.trim();

    setState(() {
      _isReasonValid = reason.length > 1;
    });
  }

  bool _formValidation() {
    return _isReasonValid;
  }

  void _submit() async {
    _validateForm();
    _isFormValid = _formValidation();
    if (_isFormValid) {
      context.read<ReferralBloc>().add(
        UpdateReferralAppStatusEvent(
          request: UpdateReferralAppStatusRequestModel(
            email: widget.submission.email,
            appDate: DateTime.now().toLocal().toIso8601String(),
            appStat: AppReferralStatus.rejected,
            token: await LocalStorageHelper().getAccessToken() ?? "",
            comment: _reasonController.text.trim(),
          ),
        ),
      );
    }
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
          title: "Submission Rejected",
          subTitle:
              "${widget.submission.fullName}’s submission has been rejected",
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 24.h),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: RichText(
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: widget.title,
                                style: TextStyles.titleSemiBold20(context),
                              ),
                            ),
                          ),
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
                      SizedBox(height: 36.h),
                      InputTitle(text: widget.title),
                      TextAreaField(
                        maxLines: 3,
                        enabled: !loading,
                        errorBool: !_isFormValid && !_isReasonValid,
                        controller: _reasonController,
                        hintText: 'Enter Reason',
                        onChanged: (value) => _validateForm(),
                      ),
                      Spacer(),
                      SizedBox(height: 56.h),
                      IconTextButton(
                        onPressed: _submit,
                        text: "Submit",
                        color: _formValidation()
                            ? AppColors.primary
                            : AppColors.dynamic10,
                        buttonState: loading
                            ? AppButtonState.loading
                            : AppButtonState.idle,
                      ),
                      SizedBox(height: 76.h),
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
