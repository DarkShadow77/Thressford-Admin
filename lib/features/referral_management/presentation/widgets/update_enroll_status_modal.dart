import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/features/referral_management/data/models/referral_status_enum.dart';
import 'package:thressford_admin/features/referral_management/presentation/widgets/add_notes_dialog.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/bottom_modals/show_modal_sheet.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/response/referral_response_model.dart';

Future updateEnrollStatusModal({
  required ReferralModel referral,
  required Function(EnrollReferralStatus, String?) onPressed,
}) {
  return Get.bottomSheet(
    isScrollControlled: true,
    ignoreSafeArea: true,
    isDismissible: true,
    enableDrag: true,
    backgroundColor: Colors.transparent,
    barrierColor: Colors.transparent,
    enterBottomSheetDuration: const Duration(milliseconds: 200),
    exitBottomSheetDuration: const Duration(milliseconds: 200),
    UpdateEnrollStatusModal(onPressed: onPressed, referral: referral),
  );
}

class UpdateEnrollStatusModal extends StatefulWidget {
  const UpdateEnrollStatusModal({
    super.key,
    required this.onPressed,
    required this.referral,
  });

  final Function(EnrollReferralStatus, String?) onPressed;
  final ReferralModel referral;

  @override
  State<UpdateEnrollStatusModal> createState() =>
      _UpdateEnrollStatusModalState();
}

class _UpdateEnrollStatusModalState extends State<UpdateEnrollStatusModal> {
  String searchText = "";

  List<String> searchData = [];

  @override
  void initState() {
    super.initState();
    search();
  }

  void search() {
    searchData.clear();

    if (searchText.isEmpty) {
      searchData.addAll(ReferralModel.getEnrollStatuses());
    } else {
      searchData.addAll(
        ReferralModel.getEnrollStatuses()
            .where(
              (element) =>
                  element.toLowerCase().contains(searchText.toLowerCase()),
            )
            .toList(),
      );
    }
  }

  void _onSubmit(String data) {
    if (data == EnrollReferralStatus.cancelled.statusString) {
      addNotesDialog(
        note: widget.referral.adminEnrollNote,
        onTap: (value) {
          widget.onPressed(
            EnrollReferralStatusExtension.fromString(data),
            value,
          );

          Navigator.of(context, rootNavigator: true).pop();
        },
      );
    } else {
      widget.onPressed(EnrollReferralStatusExtension.fromString(data), null);

      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShowModalSheet(
      maxHeight: 600.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 24.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Opacity(
                  opacity: 0,
                  child: Container(
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
                ),
                Expanded(
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: "Update Status",
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
            Flexible(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([SizedBox(height: 24.h)]),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: searchData.length * 2,
                      (ctx, idx) {
                        if (idx.isOdd) {
                          return SizedBox(height: 14.h);
                        }
                        final itemIndex = idx ~/ 2;

                        if (itemIndex > searchData.length) {
                          return null;
                        }

                        final data = searchData[itemIndex];
                        final selected =
                            data == widget.referral.enrollStatus.statusString;
                        return GestureDetector(
                          onTap: () => _onSubmit(data),
                          behavior: HitTestBehavior.opaque,
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 16.w,
                                  vertical: 12.h,
                                ),
                                decoration: BoxDecoration(
                                  color: ReferralModel.getEnrollStatusColor(
                                    EnrollReferralStatusExtension.fromString(
                                      data,
                                    ),
                                  ).withValues(alpha: .075),
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                child: RichText(
                                  maxLines: 1,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  text: TextSpan(
                                    text: data.capitalize,
                                    style: TextStyles.normalSemibold14(context)
                                        .copyWith(
                                          color: ReferralModel.getEnrollStatusColor(
                                            EnrollReferralStatusExtension.fromString(
                                              data,
                                            ),
                                          ),
                                        ),
                                  ),
                                ),
                              ),
                              if (selected)
                                Positioned(
                                  top: 6.h,
                                  right: 6.w,
                                  child: RichText(
                                    maxLines: 1,
                                    textAlign: TextAlign.center,
                                    overflow: TextOverflow.ellipsis,
                                    text: TextSpan(
                                      text: "Current Status",
                                      style: TextStyles.smallRegular12(
                                        context,
                                      ).copyWith(color: AppColors.primary),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(
                        height: 20.h + MediaQuery.of(context).padding.bottom,
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
