import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:thressford_admin/core/constants/app_assets.dart';
import 'package:thressford_admin/core/utils/helpers.dart';
import 'package:thressford_admin/features/withdrawal_request/data/models/response/transaction_response_model.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/transaction_enums.dart';
import '../bloc/transaction_bloc.dart';
import '../widgets/withdrawal_request_tile.dart';

class WithdrawalRequestPage extends StatefulWidget {
  const WithdrawalRequestPage({super.key});

  @override
  State<WithdrawalRequestPage> createState() => _WithdrawalRequestPageState();
}

class _WithdrawalRequestPageState extends State<WithdrawalRequestPage>
    with SingleTickerProviderStateMixin {
  late TabController tabController;

  List<TransactionModel> transactions = [];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 3, vsync: this);
    context.read<TransactionBloc>().add(GetAllTransactionEvent());
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionBloc, TransactionState>(
      builder: (context, state) {
        transactions = state.transactions
            .where(
              (element) =>
                  element.description.toLowerCase() == "withdrawal request" &&
                  element.type == PaymentType.withdrawal,
            )
            .toList();
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
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
                                    text: "Withdrawal Request",
                                    style: TextStyles.bodySemiBold16(context),
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    text:
                                        "${formatAmount(transactions.length)} requests",
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
                                AssetsSvgIcons.pound,
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
                      Divider(height: 1.h, color: AppColors.dynamic10),
                      SizedBox(height: 20.h),
                      Container(
                        height: 45.h,
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 2.h,
                        ),
                        decoration: BoxDecoration(
                          color: dynamicColor(.03),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: TabBar(
                          isScrollable: false,
                          padding: EdgeInsets.zero,
                          unselectedLabelStyle: TextStyles.normalRegular14(
                            context,
                          ),
                          dividerColor: Colors.transparent,
                          labelStyle: TextStyles.normalSemibold14(context),
                          labelColor: AppColors.white,
                          unselectedLabelColor: dynamicColor(.65),
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicatorColor: lighten(AppColors.primary, .9),
                          indicator: BoxDecoration(
                            color: AppColors.navyBlue,
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          controller: tabController,
                          tabs: [
                            Tab(text: 'Pending'),
                            Tab(text: 'Transferred '),
                            Tab(text: 'Rejected'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: tabController,
                    children: [
                      TabViewWidget(
                        status: PaymentStatus.pending,
                        transaction: transactions,
                      ),
                      TabViewWidget(
                        status: PaymentStatus.approved,
                        transaction: transactions,
                      ),
                      TabViewWidget(
                        status: PaymentStatus.rejected,
                        transaction: transactions,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class TabViewWidget extends StatelessWidget {
  const TabViewWidget({
    super.key,
    required this.status,
    required this.transaction,
  });

  final PaymentStatus status;
  final List<TransactionModel> transaction;

  List<TransactionModel> get filteredTransaction =>
      transaction.where((element) => element.status == status).toList();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: filteredTransaction.length,
      physics: BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 20.w),
      itemBuilder: (context, index) {
        final transaction = filteredTransaction[index];

        return WithdrawalRequestTile(transaction: transaction);
      },
      separatorBuilder: (_, _) => SizedBox(height: 16.h),
    );
  }
}
