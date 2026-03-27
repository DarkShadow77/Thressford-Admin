import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:thressford_admin/core/utils/local_storage.dart';
import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';
import 'package:thressford_admin/features/referral_management/data/models/request/update_commission_request_model.dart';
import 'package:thressford_admin/features/settings/presentation/widgets/warning_dialog.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../app/view/widgets/input/text_input_field.dart';
import '../../../../core/constants/enums/app_enum.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../data/models/response/referral_response_model.dart';
import '../bloc/referral_bloc.dart';

Future<dynamic> expectedCommissionDialog({
  required ReferralModel referral,
}) async {
  return Get.dialog(
    name: "expected_commission_dialog",
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    ExpectedCommissionDialog(referral: referral),
  );
}

class ExpectedCommissionDialog extends StatefulWidget {
  const ExpectedCommissionDialog({super.key, required this.referral});

  final ReferralModel referral;

  @override
  State<ExpectedCommissionDialog> createState() =>
      _ExpectedCommissionDialogState();
}

class _ExpectedCommissionDialogState extends State<ExpectedCommissionDialog>
    with UIToolMixin {
  final TextEditingController _commissionController = TextEditingController();
  String _rawValue = '';

  bool _isCommissionValid = false;
  bool _isFormValid = true;

  bool loading = false;

  @override
  void initState() {
    super.initState();
    _commissionController.text = widget.referral.expectedCommission.replaceAll(
      ",",
      "",
    );
  }

  @override
  void dispose() {
    _commissionController.dispose();
    super.dispose();
  }

  void _validateForm() {
    final value = int.tryParse(_rawValue);

    setState(() {
      _isCommissionValid = value != null && value > 1;
    });
  }

  bool _formValidation() {
    return _isCommissionValid;
  }

  void _submit() async {
    _validateForm();
    _isFormValid = _formValidation();
    if (_isFormValid) {
      if (widget.referral.commissionStatus == CommissionStatus.paid) {
        warningDialog(text: "Commission already paid");
      } else {
        context.read<ReferralBloc>().add(
          UpdateCommissionEvent(
            request: UpdateCommissionRequestModel(
              token: await LocalStorageHelper().getAccessToken() ?? "",
              email: widget.referral.email,
              comm: int.parse(_rawValue), // always use raw value for API
              commDate: DateTime.now().toLocal().toIso8601String(),
            ),
          ),
        );
      }
    }
  }

  void _loadingReferralState(BuildContext context, ReferralLoadingState state) {
    if (state.type == ReferralType.updateCommission) {
      setState(() => loading = true);
    }
  }

  void _successReferralState(BuildContext context, ReferralSuccessState state) {
    if (state.type == ReferralType.updateCommission) {
      context.read<ReferralBloc>().add(GetAllReferralEvent());
      Future.delayed((Duration(seconds: 1)), () {
        setState(() => loading = false);
        Navigator.pop(context);
        showMessage(context, state.message);
      });
    }
  }

  void _failedReferralState(BuildContext context, ReferralFailureState state) {
    if (state.type == ReferralType.updateCommission) {
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
              child: Container(color: Colors.black.withValues(alpha: 0.4)),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: 300.h,
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
                                text: "Expected Commission",
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
                      TextInputField(
                        controller: _commissionController,
                        enabled: !loading,
                        errorBool: !_isFormValid && !_isCommissionValid,
                        hintText: 'Enter expected commission ',
                        textInputType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter
                              .digitsOnly, // blocks everything except digits
                          _CommissionFormatter(), // formats display with commas
                        ],
                        onChanged: (value) {
                          // Strip commas to get raw int value
                          _rawValue = value.replaceAll(',', '');
                          _validateForm();
                        },
                      ),
                      Spacer(),
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

class _CommissionFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    if (newValue.text.isEmpty) return newValue;

    final number = int.tryParse(newValue.text.replaceAll(',', ''));
    if (number == null) return oldValue;

    // Format with commas e.g. 1000000 -> 1,000,000
    final formatted = NumberFormat('#,###').format(number);

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
