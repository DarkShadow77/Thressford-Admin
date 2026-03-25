import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:thressford_admin/core/constants/app_assets.dart';
import 'package:thressford_admin/features/referral_management/data/models/response/referral_response_model.dart';
import 'package:thressford_admin/features/referral_management/presentation/widgets/filter_modal.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/input/search_text_input.dart';
import '../../../../app/view/widgets/loading/outer_loading.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../data/models/referral_status_enum.dart';
import '../bloc/referral_bloc.dart';
import '../widgets/referral_tile.dart';

class ReferralManagementPage extends StatefulWidget {
  const ReferralManagementPage({super.key});

  @override
  State<ReferralManagementPage> createState() => _ReferralManagementPageState();
}

class _ReferralManagementPageState extends State<ReferralManagementPage>
    with UIToolMixin {
  final TextEditingController _inputController = TextEditingController();

  String searchText = "";

  DateTime? fromDate;
  DateTime? toDate;

  String filterType = "";

  List<ReferralModel> searchData = [];
  List<ReferralModel> referrals = [];

  @override
  void initState() {
    super.initState();
    context.read<ReferralBloc>().add(GetAllReferralEvent());
    searchData.addAll(referrals);
  }

  void search() {
    setState(() {
      searchData = referrals.where((referral) {
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

        // Date filter
        bool matchesDate = true;
        if (fromDate != null || toDate != null) {
          DateTime referralDate = DateTime.parse(referral.createdAt);
          // Normalize dates to compare only date part (not time)
          DateTime referralDateOnly = DateTime(
            referralDate.year,
            referralDate.month,
            referralDate.day,
          );

          if (fromDate != null) {
            DateTime fromDateOnly = DateTime(
              fromDate!.year,
              fromDate!.month,
              fromDate!.day,
            );
            matchesDate =
                matchesDate && !referralDateOnly.isBefore(fromDateOnly);
          }

          if (toDate != null) {
            DateTime toDateOnly = DateTime(
              toDate!.year,
              toDate!.month,
              toDate!.day,
            );
            matchesDate = matchesDate && !referralDateOnly.isAfter(toDateOnly);
          }
        }

        // Type/Status filter
        bool matchesType =
            filterType.isEmpty ||
            referral.enrollStatus.statusString.toLowerCase() ==
                filterType.toLowerCase();

        return matchesSearch && matchesDate && matchesType;
      }).toList();
    });
  }

  void clearFilters() {
    setState(() {
      fromDate = null;
      toDate = null;
      filterType = "";
      searchText = "";
      _inputController.clear();
    });
    search();
  }

  void _loadingReferralState(BuildContext context, ReferralLoadingState state) {
    if (state.type == ReferralType.updateEnrollStatus) {
      outerLoadingDialog(text: "Updating User Status");
    }
  }

  void _successReferralState(BuildContext context, ReferralSuccessState state) {
    if (state.type == ReferralType.updateEnrollStatus) {
      context.read<ReferralBloc>().add(GetAllReferralEvent());
      Future.delayed((Duration(seconds: 1)), () {
        if (Get.isDialogOpen == true) Navigator.pop(context);
        showMessage(context, state.message);
      });
    }
  }

  void _failedReferralState(BuildContext context, ReferralFailureState state) {
    if (state.type == ReferralType.updateEnrollStatus ||
        state.type == ReferralType.updateCommissionStatus) {
      Future.delayed((Duration(seconds: 1)), () {
        if (Get.isDialogOpen == true) Navigator.pop(context);
        showMessage(context, state.message, status: true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ReferralBloc, ReferralState>(
      listener: (context, state) {
        if (state is ReferralLoadingState) {
          _loadingReferralState(context, state);
        } else if (state is ReferralSuccessState) {
          _successReferralState(context, state);
        } else if (state is ReferralFailureState) {
          _failedReferralState(context, state);
        }
      },
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          referrals = state.referral;
          search();
        });
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
                                text: "Referral Management",
                                style: TextStyles.bodySemiBold16(context),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    "${formatAmount(searchData.length)} total referral${searchData.length != 1 ? 's' : ''}",
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
                          color: AppColors.orange,
                        ),
                        child: Center(
                          child: SvgPicture.asset(
                            AssetsSvgIcons.stickyNote,
                            width: 20.sp,
                            height: 20.sp,
                            colorFilter: ColorFilter.mode(
                              AppColors.white,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  Row(
                    spacing: 10.w,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: SearchTextInput(
                          height: 56,
                          hintText: "Search Referrals",
                          controller: _inputController,
                          onChanged: (value) {
                            setState(() {
                              searchText = value;
                            });
                            search();
                          },
                        ),
                      ),
                      GestureDetector(
                        onTap: () => filterModal(
                          from: fromDate,
                          to: fromDate,
                          type: filterType,
                          onPressed: (from, to, type) {
                            setState(() {
                              fromDate = from;
                              fromDate = to;
                              filterType = type;
                            });
                            search();
                          },
                        ),
                        child: Container(
                          width: 56.w,
                          height: 56.h,
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.dynamic20),
                            borderRadius: BorderRadius.circular(14.r),
                            color:
                                (fromDate != null ||
                                    toDate != null ||
                                    filterType.isNotEmpty)
                                ? AppColors.primary10
                                : null,
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              AssetsSvgIcons.filter,
                              width: 24.w,
                              height: 24.h,
                              fit: BoxFit.contain,
                              colorFilter: ColorFilter.mode(
                                (fromDate != null ||
                                        toDate != null ||
                                        filterType.isNotEmpty)
                                    ? AppColors.primary
                                    : AppColors.dynamic,
                                BlendMode.srcIn,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (fromDate != null ||
                      toDate != null ||
                      filterType.isNotEmpty)
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: Wrap(
                        spacing: 8.w,
                        runSpacing: 8.h,
                        children: [
                          if (fromDate != null)
                            _buildFilterChip(
                              "From: ${_formatDate(fromDate!)}",
                              () {
                                setState(() => fromDate = null);
                                search();
                              },
                            ),
                          if (toDate != null)
                            _buildFilterChip("To: ${_formatDate(toDate!)}", () {
                              setState(() => toDate = null);
                              search();
                            }),
                          if (filterType.isNotEmpty)
                            _buildFilterChip(
                              "Status: ${filterType.capitalize}",
                              () {
                                setState(() => filterType = "");
                                search();
                              },
                            ),
                          GestureDetector(
                            onTap: clearFilters,
                            child: Text(
                              "Clear all",
                              style: TextStyles.smallRegular12(context)
                                  .copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  Expanded(
                    child: searchData.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.search_off,
                                  size: 48.sp,
                                  color: AppColors.dynamic50,
                                ),
                                SizedBox(height: 16.h),
                                Text(
                                  "No referrals found",
                                  style: TextStyles.bodyRegular16(
                                    context,
                                    opacity: 0.5,
                                  ),
                                ),
                                if (fromDate != null ||
                                    toDate != null ||
                                    filterType.isNotEmpty)
                                  TextButton(
                                    onPressed: clearFilters,
                                    child: Text("Clear filters"),
                                  ),
                              ],
                            ),
                          )
                        : ListView.separated(
                            itemCount: searchData.length,
                            physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics(),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 32.h),
                            itemBuilder: (context, index) {
                              final referral = searchData[index];
                              return ReferralTile(referral: referral);
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

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }

  Widget _buildFilterChip(String label, VoidCallback onRemove) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: TextStyles.smallRegular12(
              context,
            ).copyWith(color: AppColors.primary),
          ),
          SizedBox(width: 4.w),
          GestureDetector(
            onTap: onRemove,
            child: Icon(Icons.close, size: 16.sp, color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
