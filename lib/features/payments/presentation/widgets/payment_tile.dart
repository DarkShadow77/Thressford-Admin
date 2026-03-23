import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../../referral_management/data/models/response/referral_response_model.dart';

class PaymentTile extends StatelessWidget {
  const PaymentTile({super.key, required this.payment});

  final ReferralModel payment;

  @override
  Widget build(BuildContext context) {
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
                        text: payment.fullName,
                        style: TextStyles.normalRegular14(context),
                      ),
                    ),
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        text: payment.email,
                        style: TextStyles.smallRegular12(context, opacity: .65),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: payment.getCommissionStatusColor().withValues(
                    alpha: .1,
                  ),
                  borderRadius: BorderRadius.circular(100.r),
                ),
                child: RichText(
                  text: TextSpan(
                    text: payment.commissionStatus.statusString.capitalize,
                    style: TextStyles.smallRegular12(
                      context,
                    ).copyWith(color: payment.getCommissionStatusColor()),
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
                    text: payment.course,
                    style: TextStyles.smallRegular12(context),
                  ),
                ),
                RichText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: TextSpan(
                    text: payment.country,
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
                                text: payment.referredBy,
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
                                text: formatDate(payment.createdAt),
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
                      "£${formatAmount(double.parse(payment.expectedCommission))}",
                  style: TextStyles.normalMedium14(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
