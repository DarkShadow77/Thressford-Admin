/*
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/app/view/widgets/input/input_title.dart';
import 'package:thressford_admin/features/submissions/data/models/response/submission_response_model.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../app/view/widgets/input/text_area_field.dart';
import '../../../../core/constants/enums/app_enum.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/ui_tool_mix.dart';

Future<dynamic> submissionReasonDialog({
  required UsersModel submission,
  required String title,
  required VoidCallback onTap,
}) async {
  return Get.dialog(
    name: "submission_reason_dialog",
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    SubmissionReasonDialog(submission: submission, title: title, onTap: onTap),
  );
}

class SubmissionReasonDialog extends StatefulWidget {
  const SubmissionReasonDialog({
    super.key,
    required this.submission,
    required this.title,
    required this.onTap,
  });

  final UsersModel submission;
  final String title;
  final VoidCallback onTap;

  @override
  State<SubmissionReasonDialog> createState() => _SubmissionReasonDialogState();
}

class _SubmissionReasonDialogState extends State<SubmissionReasonDialog>
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
      setState(() => loading = true);

      Future.delayed(Duration(seconds: 2), () {
        setState(() => loading = false);

        Navigator.pop(context);
        widget.onTap();
      });
      */
/*context.read<ProfileBloc>().add(
        ChangePasswordEvent(
          request: ChangePasswordRequestModel(
            token: await LocalStorageHelper().getAccessToken() ?? "",
            oldPassword: _oldPasswordController.text.trim(),
            newPassword: _passwordController.text.trim(),
            confirmNewPassword: _confirmPasswordController.text.trim(),
          ),
        ),
      );*/ /*

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
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
    );
  }
}
 
*/
