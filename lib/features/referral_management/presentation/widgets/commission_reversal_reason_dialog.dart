import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/app/view/widgets/input/input_title.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../app/view/widgets/input/text_area_field.dart';
import '../../../../core/constants/enums/app_enum.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/ui_tool_mix.dart';

Future<dynamic> commissionReversalReasonDialog({
  required Function(String) onTap,
}) async {
  return Get.dialog(
    name: "commission_reversal_reason_dialog",
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    CommissionReversalReasonDialog(onTap: onTap),
  );
}

class CommissionReversalReasonDialog extends StatefulWidget {
  const CommissionReversalReasonDialog({super.key, required this.onTap});

  final Function(String) onTap;

  @override
  State<CommissionReversalReasonDialog> createState() =>
      _CommissionReversalReasonDialogState();
}

class _CommissionReversalReasonDialogState
    extends State<CommissionReversalReasonDialog>
    with UIToolMixin {
  final TextEditingController _notesController = TextEditingController();

  bool _isNotesValid = false;
  bool _isFormValid = true;

  bool loading = false;

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  void _validateForm() {
    String reason = _notesController.text.trim();

    setState(() {
      _isNotesValid = reason.length > 1;
    });
  }

  bool _formValidation() {
    return _isNotesValid;
  }

  void _submit() async {
    _validateForm();
    _isFormValid = _formValidation();
    if (_isFormValid) {
      widget.onTap(_notesController.text.trim());
      Navigator.of(context, rootNavigator: true).pop();
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
            child: Container(color: Colors.black.withValues(alpha: .4)),
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
                              text: "Reversal Reason",
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
                    InputTitle(text: "Note"),
                    TextAreaField(
                      maxLines: 3,
                      enabled: !loading,
                      errorBool: !_isFormValid && !_isNotesValid,
                      controller: _notesController,
                      hintText: 'Enter reason for reversal',
                      onChanged: (value) => _validateForm(),
                    ),
                    Spacer(),
                    SizedBox(height: 56.h),
                    IconTextButton(
                      onPressed: _submit,
                      text: "Submit",
                      color: _formValidation()
                          ? AppColors.primary
                          : AppColors.primary20,
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
