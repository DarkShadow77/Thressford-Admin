import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thressford_admin/core/constants/app_assets.dart';
import 'package:thressford_admin/core/utils/helpers.dart';
import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/input/search_text_input.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../referral_management/data/models/response/referral_response_model.dart';
import '../../../referral_management/presentation/bloc/referral_bloc.dart';
import '../widgets/payment_tile.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final TextEditingController _inputController = TextEditingController();

  String searchText = "";

  List<ReferralModel> searchData = [];
  List<ReferralModel> payments = [];

  @override
  void initState() {
    super.initState();
    context.read<ReferralBloc>().add(GetAllReferralEvent());
    searchData.addAll(payments);
  }

  void search() {
    setState(() {
      searchData = payments.where((referral) {
        // Text search
        bool matchesSearch =
            searchText.isEmpty ||
            referral.fullName.toLowerCase().contains(
              searchText.toLowerCase(),
            ) ||
            referral.email.toLowerCase().contains(searchText.toLowerCase()) ||
            referral.course.toLowerCase().contains(searchText.toLowerCase()) ||
            referral.country.toLowerCase().contains(searchText.toLowerCase()) ||
            referral.expectedCommission.toString().contains(searchText) ||
            referral.referredBy.toLowerCase().contains(
              searchText.toLowerCase(),
            );

        return matchesSearch;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferralBloc, ReferralState>(
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          payments = state.referral;
          search();
        });
        final paid = payments
            .where((e) => e.commissionStatus == CommissionStatus.paid)
            .toList()
            .length;
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
                                text: "${formatAmount(paid)} users paid",
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
                        return PaymentTile(payment: payment);
                      },
                      separatorBuilder: (_, _) => SizedBox(height: 16.h),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
