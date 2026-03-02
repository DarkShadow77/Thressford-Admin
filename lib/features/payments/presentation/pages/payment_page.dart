import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thressford_admin/core/constants/app_assets.dart';
import 'package:thressford_admin/core/utils/helpers.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/input/search_text_input.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/response/payment_response_model.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _inputController = TextEditingController();

  String searchText = "";

  List<PaymentModel> searchData = [];
  List<PaymentModel> payments = [
    PaymentModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      status: "Paid",
      amount: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    PaymentModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      status: "Paid",
      amount: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    PaymentModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      status: "Paid",
      amount: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    PaymentModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      status: "Paid",
      amount: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    PaymentModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      status: "Paid",
      amount: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    PaymentModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      status: "Paid",
      amount: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
    PaymentModel(
      id: "0",
      fullName: "Fred Wright",
      email: "fred@example.com",
      course: "Biology",
      country: "Spain",
      referredBy: "Peter Rocky",
      status: "Paid",
      amount: 280,
      createdAt: DateTime(2026, 1, 26).toIso8601String(),
      updatedAt: null,
    ),
  ];

  @override
  void initState() {
    super.initState();
    search();
  }

  void search() {
    searchData.clear();

    if (searchText.isEmpty) {
      searchData.addAll(payments);
    } else {
      searchData.addAll(
        payments
            .where(
              (element) =>
                  element.fullName.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.email.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.course.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.country.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.amount.toString().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.referredBy.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ) ||
                  element.email.toLowerCase().contains(
                    searchText.toLowerCase(),
                  ),
            )
            .toList(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20.w,
        automaticallyImplyLeading: false,
        toolbarHeight: kToolbarHeight + 20.h,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.dynamic05,
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 10.h),
              Row(
                spacing: 16.w,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      spacing: 8.h,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: TextSpan(
                            text: "Payments",
                            style: TextStyles.bodySemiBold16(context),
                          ),
                        ),
                        RichText(
                          text: TextSpan(
                            text: "2,884 users paid",
                            style: TextStyles.bodyRegular16(
                              context,
                              opacity: .75,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 40.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.dynamic05,
                    ),
                    child: Center(
                      child: SvgPicture.asset(
                        AssetsSvgIcons.checkCircle,
                        width: 20.sp,
                        height: 20.sp,
                        colorFilter: ColorFilter.mode(
                          AppColors.dynamic60,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              SearchTextInput(
                hintText: "Search Wallets",
                controller: _inputController,
                onChanged: (value) {
                  setState(() {
                    searchText = value;
                  });
                  search();
                },
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: searchData.length,
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 20.h),
                  itemBuilder: (context, index) {
                    final payment = searchData[index];
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: payment.fullName,
                                        style: TextStyles.normalRegular14(
                                          context,
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      text: TextSpan(
                                        text: payment.email,
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
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.w,
                                  vertical: 4.h,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.error5,
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                                child: RichText(
                                  text: TextSpan(
                                    text: payment.status,
                                    style: TextStyles.smallRegular12(
                                      context,
                                    ).copyWith(color: AppColors.error),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 16.h,
                            ),
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Row(
                                      spacing: 8.w,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
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
                                                style:
                                                    TextStyles.normalRegular14(
                                                      context,
                                                    ),
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
                                            children: [
                                              TextSpan(
                                                text: formatDate(
                                                  payment.updatedAt ??
                                                      payment.createdAt,
                                                ),
                                                style:
                                                    TextStyles.normalRegular14(
                                                      context,
                                                    ),
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
                                  text: "£${formatAmount(payment.amount)}",
                                  style: TextStyles.normalMedium14(context),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (_, _) => SizedBox(height: 16.h),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
