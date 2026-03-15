import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:thressford_admin/app/view/widgets/buttons/icon_text_button.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/bottom_modals/show_modal_sheet.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers.dart';

Future selectDateModal({
  required Function(List<DateTime>) onPressed,
  required List<DateTime> dates,
}) {
  return Get.bottomSheet(
    isScrollControlled: true,
    ignoreSafeArea: true,
    isDismissible: true,
    enableDrag: true,
    enterBottomSheetDuration: const Duration(milliseconds: 200),
    exitBottomSheetDuration: const Duration(milliseconds: 200),
    SelectDateModal(onPressed: onPressed, dates: dates),
  );
}

class SelectDateModal extends StatefulWidget {
  const SelectDateModal({
    super.key,
    required this.onPressed,
    required this.dates,
  });

  final Function(List<DateTime>) onPressed;
  final List<DateTime> dates;
  @override
  State<SelectDateModal> createState() => _SelectDateModalState();
}

class _SelectDateModalState extends State<SelectDateModal> {
  List<DateTime> _dates = [];

  @override
  void initState() {
    super.initState();
    _dates = widget.dates;
  }

  @override
  Widget build(BuildContext ctx) {
    return ShowModalSheet(
      minHeight: 300.h,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.w),
        child: IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 4.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: AppColors.dynamic20,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32.h),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "Select Range",
                  style: TextStyles.bodyMedium16(context),
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 12.w,
                  vertical: 14.5.h,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primary07,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  spacing: 10.w,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RichText(
                      text: TextSpan(
                        text: formatDateRange(_dates)[0].capitalize,
                        style: TextStyles.normalRegular14(
                          context,
                        ).copyWith(color: AppColors.primary),
                      ),
                    ),
                  ],
                ),
              ),
              CalendarDatePicker2(
                config: CalendarDatePicker2Config(
                  calendarType: CalendarDatePicker2Type.single,
                ),
                value: _dates,

                onValueChanged: (dates) {
                  setState(() {
                    _dates = dates;
                  });
                  Logger().t("Dates $_dates");
                },
              ),

              IconTextButton(
                onPressed: () {
                  widget.onPressed(_dates);
                  Get.back();
                },
                text: "Apply",
              ),
              SizedBox(
                height: 20.h + MediaQuery.of(context).viewPadding.bottom,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
