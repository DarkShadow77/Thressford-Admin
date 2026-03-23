import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/bottom_modals/show_modal_sheet.dart';
import '../../../../core/constants/app_colors.dart';

Future adminAccessListModal({
  required List<Map<String, dynamic>> list,
  required Function(String) onPressed,
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
    AdminAccessListModal(list: list, onPressed: onPressed),
  );
}

class AdminAccessListModal extends StatefulWidget {
  const AdminAccessListModal({
    super.key,
    required this.list,
    required this.onPressed,
  });

  final List<Map<String, dynamic>> list;
  final Function(String) onPressed;

  @override
  State<AdminAccessListModal> createState() => _AdminAccessListModalState();
}

class _AdminAccessListModalState extends State<AdminAccessListModal> {
  @override
  void initState() {
    super.initState();
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
                Expanded(
                  child: RichText(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    text: TextSpan(
                      text: "Select Access Level",
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
            SizedBox(height: 24.h),
            Flexible(
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  SliverList(
                    delegate: SliverChildListDelegate([SizedBox(height: 24.h)]),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: widget.list.length * 2,
                      (ctx, idx) {
                        if (idx.isOdd) {
                          return SizedBox(height: 14.h);
                        }
                        final itemIndex = idx ~/ 2;

                        if (itemIndex > widget.list.length) {
                          return null;
                        }

                        final data = widget.list[itemIndex];
                        return GestureDetector(
                          onTap: () {
                            widget.onPressed(data["value"]);
                            Navigator.of(context, rootNavigator: true).pop();
                          },
                          behavior: HitTestBehavior.opaque,
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 12.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.dynamic025,
                              borderRadius: BorderRadius.circular(14.r),
                            ),
                            child: RichText(
                              maxLines: 1,
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              text: TextSpan(
                                text: data["label"].toString().capitalize,
                                children: [
                                  TextSpan(
                                    text: " (${data["access"]})",
                                    style: TextStyles.cardRegular10(
                                      context,
                                      opacity: .65,
                                    ),
                                  ),
                                ],
                                style: TextStyles.smallSemibold12(context),
                              ),
                            ),
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
