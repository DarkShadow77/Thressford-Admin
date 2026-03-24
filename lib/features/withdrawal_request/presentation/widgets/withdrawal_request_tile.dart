import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thressford_admin/features/user_management/data/models/response/users_response_model.dart';
import 'package:thressford_admin/features/withdrawal_request/data/models/transaction_enums.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../../user_management/presentation/bloc/users_bloc.dart';
import '../../data/models/response/transaction_response_model.dart';
import 'withdrawal_status_dialog.dart';

class WithdrawalRequestTile extends StatelessWidget {
  const WithdrawalRequestTile({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    UsersModel? user = context.read<UsersBloc>().state.users.firstWhereOrNull(
      (e) => e.id.toLowerCase() == transaction.userId.toLowerCase(),
    );
    final isPending = transaction.status == PaymentStatus.pending;
    final isApproved = transaction.status == PaymentStatus.approved;
    final isRejected = transaction.status == PaymentStatus.rejected;

    return Container(
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
            spacing: 20.w,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  spacing: 4.h,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: user?.fullName ?? "--",
                        style: TextStyles.normalRegular14(context),
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: user?.email ?? "--",
                        style: TextStyles.smallRegular12(context, opacity: .65),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: transaction.getTransactionStatusColor().withValues(
                    alpha: .1,
                  ),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: RichText(
                  text: TextSpan(
                    text: transaction.status.statusString.capitalize,
                    style: TextStyles.smallRegular12(
                      context,
                    ).copyWith(color: transaction.getTransactionStatusColor()),
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
                    text: "Request",
                    style: TextStyles.smallRegular12(context, opacity: .4),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: "Withdrawal amount",
                          style: TextStyles.smallRegular12(context),
                        ),
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: "£${formatAmount(transaction.absAmount)}",
                        style: TextStyles.normalRegular14(context),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: "Transaction fee",
                          style: TextStyles.smallRegular12(context),
                        ),
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: "-£${formatAmount(20)}",
                        style: TextStyles.normalRegular14(
                          context,
                        ).copyWith(color: AppColors.error),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.h),
                  child: Divider(height: 1.h, color: AppColors.dynamic10),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RichText(
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(
                          text: "You will receive",
                          style: TextStyles.normalRegular14(context),
                        ),
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: "£${formatAmount(transaction.absAmount - 20)}",
                        style: TextStyles.bodySemiBold16(
                          context,
                        ).copyWith(color: AppColors.green),
                      ),
                    ),
                  ],
                ),
              ],
            ),
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
                  text: isPending
                      ? "Submitted: "
                      : isApproved
                      ? "Transferred: "
                      : isRejected
                      ? "Rejected: "
                      : "Created: ",
                  children: [
                    TextSpan(
                      text: isPending
                          ? formatDate(transaction.createdAt)
                          : formatDate(
                              transaction.updatedAt ?? transaction.createdAt,
                            ),
                    ),
                  ],
                  style: TextStyles.normalRegular14(context, opacity: .5),
                ),
              ),
            ],
          ),
          Row(
            spacing: 10.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (isPending || isApproved)
                Expanded(
                  child: IconTextButton(
                    onPressed: () => withdrawalStatusDialog(
                      transaction: transaction,
                      transferred: false,
                    ),
                    height: 42,
                    text: "Reject",
                    iconWidget: Icon(
                      Icons.cancel_outlined,
                      color: AppColors.error,
                      size: 20.sp,
                    ),
                    textColor: AppColors.error,
                    color: AppColors.error5,
                  ),
                ),
              if (isPending || isRejected)
                Expanded(
                  child: IconTextButton(
                    onPressed: () => withdrawalStatusDialog(
                      transaction: transaction,
                      transferred: true,
                    ),
                    height: 42,
                    text: "Transferred",
                    icon: AssetsSvgIcons.checkCircle,
                    iconColor: AppColors.white,
                    textColor: AppColors.white,
                    color: AppColors.green,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
