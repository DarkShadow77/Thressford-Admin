import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';
import 'package:thressford_admin/app/view/widgets/loading/outer_loading.dart';
import 'package:thressford_admin/core/utils/helpers.dart';
import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';
import 'package:thressford_admin/features/referral_management/data/models/response/referral_response_model.dart';
import 'package:thressford_admin/features/user_management/data/models/response/users_response_model.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/input/search_text_input.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../../referral_management/presentation/bloc/referral_bloc.dart';
import '../../../referral_management/presentation/widgets/referral_tile.dart';

class UserReferralsPage extends StatefulWidget {
  const UserReferralsPage({super.key, required this.param});

  final UserReferralsPageParam param;

  @override
  State<UserReferralsPage> createState() => _UserReferralsPageState();
}

class _UserReferralsPageState extends State<UserReferralsPage>
    with UIToolMixin {
  final TextEditingController _inputController = TextEditingController();

  String searchText = "";

  List<ReferralModel> searchData = [];
  List<ReferralModel> userReferrals = [];

  UsersModel get user => widget.param.user;

  @override
  void initState() {
    super.initState();
    final referralBloc = context.read<ReferralBloc>();
    userReferrals = referralBloc.state.referral
        .where((e) => e.referer == user.id)
        .toList();
    searchData.addAll(userReferrals);
    referralBloc.add(GetAllReferralEvent());
  }

  void search() {
    setState(() {
      searchData = userReferrals.where((referral) {
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
          userReferrals = state.referral
              .where((e) => e.referer == widget.param.user.id)
              .toList();
          search();
        });
        return Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: AppColors.navyBlue,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(32.r),
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).viewPadding.top),
                    SizedBox(
                      height: kToolbarHeight,
                      child: Row(
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
                                color: AppColors.white,
                              ),
                              child: Center(
                                child: Icon(
                                  Icons.arrow_back_rounded,
                                  size: 24.sp,
                                  color: AppColors.black,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
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
                                  text: "Total Referrals",
                                  style: TextStyles.bodySemiBold16(
                                    context,
                                  ).copyWith(color: AppColors.white),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "${user.fullName.capitalize}",
                                  style: TextStyles.bodyRegular16(
                                    context,
                                    opacity: .75,
                                  ).copyWith(color: AppColors.white),
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
                    SizedBox(height: 24.h),
                    Row(
                      spacing: 12.w,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: _buildContainer(
                            context,
                            value: formatAmount(userReferrals.length),
                            title: "Total",
                          ),
                        ),
                        Expanded(
                          child: _buildContainer(
                            context,
                            value: formatAmount(
                              userReferrals
                                  .where(
                                    (e) =>
                                        e.enrollStatus ==
                                        EnrollReferralStatus.paid,
                                  )
                                  .toList()
                                  .length,
                            ),
                            title: "Paid",
                          ),
                        ),
                        Expanded(
                          child: _buildContainer(
                            context,
                            value: formatAmount(
                              userReferrals
                                  .where(
                                    (e) =>
                                        e.enrollStatus !=
                                        EnrollReferralStatus.paid,
                                  )
                                  .toList()
                                  .length,
                            ),
                            title: "Pending",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 24.h),
                      SearchTextInput(
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
                                  ],
                                ),
                              )
                            : ListView.separated(
                                itemCount: searchData.length,
                                physics: BouncingScrollPhysics(
                                  parent: AlwaysScrollableScrollPhysics(),
                                ),
                                padding: EdgeInsets.only(
                                  top: 32.h,
                                  bottom:
                                      32.h +
                                      MediaQuery.of(context).viewPadding.bottom,
                                ),
                                itemBuilder: (context, index) {
                                  final referral = searchData[index];
                                  return ReferralTile(referral: referral);
                                },
                                separatorBuilder: (_, _) =>
                                    SizedBox(height: 16.h),
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContainer(
    BuildContext context, {
    required String title,
    required String value,
  }) {
    return LiquidGlassLayer(
      settings: LiquidGlassSettings(lightAngle: 10, ambientStrength: .3),
      child: LiquidGlass(
        shape: LiquidRoundedSuperellipse(borderRadius: 14.r),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          decoration: BoxDecoration(
            color: Color(0xffEBECED).withValues(alpha: .12),
            borderRadius: BorderRadius.circular(14.r),
          ),
          child: Column(
            spacing: 4.h,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: value,
                  style: TextStyles.bigTitleSemiBold24(
                    context,
                  ).copyWith(color: AppColors.white),
                ),
              ),
              RichText(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                text: TextSpan(
                  text: title,
                  style: TextStyles.smallRegular12(
                    context,
                  ).copyWith(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UserReferralsPageParam {
  final UsersModel user;

  UserReferralsPageParam({required this.user});
}
