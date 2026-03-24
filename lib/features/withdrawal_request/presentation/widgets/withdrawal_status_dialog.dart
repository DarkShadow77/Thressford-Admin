import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/core/utils/local_storage.dart';
import 'package:thressford_admin/features/withdrawal_request/data/models/response/transaction_response_model.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/constants/enums/app_enum.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../data/models/request/update_transaction_status_request_model.dart';
import '../../data/models/transaction_enums.dart';
import '../bloc/transaction_bloc.dart';
import 'withdrawal_success_dialog.dart';

Future<dynamic> withdrawalStatusDialog({
  required TransactionModel transaction,
  bool transferred = true,
}) async {
  return Get.dialog(
    name: "withdrawal_status_dialog",
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    WithdrawalStatusDialog(transaction: transaction, transferred: transferred),
  );
}

class WithdrawalStatusDialog extends StatefulWidget {
  const WithdrawalStatusDialog({
    super.key,
    required this.transaction,
    required this.transferred,
  });

  final TransactionModel transaction;
  final bool transferred;

  @override
  State<WithdrawalStatusDialog> createState() => _WithdrawalStatusDialogState();
}

class _WithdrawalStatusDialogState extends State<WithdrawalStatusDialog>
    with UIToolMixin {
  bool loading = false;

  _onSubmit() async {
    widget.transferred
        ? context.read<TransactionBloc>().add(
            UpdateTransactionStatusEvent(
              request: UpdateTransactionStatusRequestModel(
                token: await LocalStorageHelper().getAccessToken() ?? "",
                transactionId: widget.transaction.id,
                status: PaymentStatus.approved,
              ),
            ),
          )
        : context.read<TransactionBloc>().add(
            UpdateTransactionStatusEvent(
              request: UpdateTransactionStatusRequestModel(
                token: await LocalStorageHelper().getAccessToken() ?? "",
                transactionId: widget.transaction.id,
                status: PaymentStatus.rejected,
              ),
            ),
          );
  }

  void _loadingTransactionState(
    BuildContext context,
    TransactionLoadingState state,
  ) {
    if (state.type == TransactionType.updateTransactionStatus) {
      setState(() => loading = true);
    }
  }

  void _successTransactionState(
    BuildContext context,
    TransactionSuccessState state,
  ) {
    if (state.type == TransactionType.updateTransactionStatus) {
      context.read<TransactionBloc>().add(GetAllTransactionEvent());
      Future.delayed((Duration(seconds: 1)), () {
        setState(() => loading = false);
        Navigator.pop(context);
        withdrawalSuccessDialog(
          title: "Transaction Updated",
          subTitle:
              "This transaction has been updated as ${widget.transferred ? "transferred" : "rejected"}",
        );
      });
    }
  }

  void _failedTransactionState(
    BuildContext context,
    TransactionFailureState state,
  ) {
    if (state.type == TransactionType.updateTransactionStatus) {
      setState(() => loading = false);
      showMessage(context, state.message, status: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TransactionBloc, TransactionState>(
      listener: (context, state) {
        if (state is TransactionLoadingState) {
          _loadingTransactionState(context, state);
        } else if (state is TransactionSuccessState) {
          _successTransactionState(context, state);
        } else if (state is TransactionFailureState) {
          _failedTransactionState(context, state);
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60.r,
                            width: 60.r,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: widget.transferred
                                  ? AppColors.green5
                                  : AppColors.error5,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: HugeIcon(
                                icon: widget.transferred
                                    ? HugeIcons.strokeRoundedTick03
                                    : HugeIcons
                                          .strokeRoundedCancelCircleHalfDot,
                                color: widget.transferred
                                    ? AppColors.green
                                    : AppColors.error,
                                size: 24.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  "Update as ${widget.transferred ? "Transferred" : "Rejected"}?",
                              style: TextStyles.titleSemiBold20(context),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: widget.transferred
                                  ? "Kindly confirm that this transaction has been remitted to user account"
                                  : "Kindly confirm that this transaction has been rejected",
                              style: TextStyles.bodyRegular16(
                                context,
                                opacity: .5,
                              ),
                            ),
                          ),
                          SizedBox(height: 32.h),
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
                                  onPressed: _onSubmit,
                                  text: widget.transferred
                                      ? "Transferred"
                                      : "Rejected",
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
