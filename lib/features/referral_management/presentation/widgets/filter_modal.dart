import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:intl/intl.dart';
import 'package:thressford_admin/app/view/widgets/buttons/icon_text_button.dart';
import 'package:thressford_admin/features/referral_management/data/models/response/referral_response_model.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/bottom_modals/list_modal.dart';
import '../../../../app/view/widgets/bottom_modals/show_modal_sheet.dart';
import '../../../../app/view/widgets/input/input_title.dart';
import '../../../../app/view/widgets/input/text_input_field.dart';
import '../../../../core/constants/app_colors.dart';
import 'select_date_modal.dart';

Future filterModal({
  required DateTime? from,
  required DateTime? to,
  required String type,
  required Function(DateTime? from, DateTime? to, String type) onPressed,
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
    FilterModal(from: from, to: to, type: type, onPressed: onPressed),
  );
}

class FilterModal extends StatefulWidget {
  const FilterModal({
    super.key,
    required this.from,
    required this.to,
    required this.type,
    required this.onPressed,
  });

  final DateTime? from;
  final DateTime? to;
  final String type;
  final Function(DateTime? from, DateTime? to, String type) onPressed;

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final TextEditingController _fromDateController = TextEditingController();
  final TextEditingController _toDateController = TextEditingController();
  final TextEditingController _typeController = TextEditingController();

  DateTime? _selectedFromDate;
  DateTime? _selectedToDate;
  String _selectedType = "";

  String? _dateError;

  @override
  void initState() {
    super.initState();
    _selectedFromDate = widget.from;
    _selectedToDate = widget.to;
    _selectedType = widget.type;

    _fromDateController.text = _selectedFromDate != null
        ? _formatDate(_selectedFromDate!)
        : "";
    _toDateController.text = _selectedToDate != null
        ? _formatDate(_selectedToDate!)
        : "";
    _typeController.text = _selectedType;
  }

  @override
  void dispose() {
    _toDateController.dispose();
    _typeController.dispose();
    super.dispose();
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd - MM - yyyy').format(date);
  }

  bool _validateDates() {
    if (_selectedFromDate != null && _selectedToDate != null) {
      // Normalize to date only (remove time component)
      final from = DateTime(
        _selectedFromDate!.year,
        _selectedFromDate!.month,
        _selectedFromDate!.day,
      );
      final to = DateTime(
        _selectedToDate!.year,
        _selectedToDate!.month,
        _selectedToDate!.day,
      );

      if (from.isAfter(to)) {
        setState(() {
          _dateError = "From date cannot be after To date";
        });
        return false;
      }
    }

    // Check if dates are in the future
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    if (_selectedFromDate != null) {
      final from = DateTime(
        _selectedFromDate!.year,
        _selectedFromDate!.month,
        _selectedFromDate!.day,
      );
      if (from.isAfter(today)) {
        setState(() {
          _dateError = "From date cannot be in the future";
        });
        return false;
      }
    }

    if (_selectedToDate != null) {
      final to = DateTime(
        _selectedToDate!.year,
        _selectedToDate!.month,
        _selectedToDate!.day,
      );
      if (to.isAfter(today)) {
        setState(() {
          _dateError = "To date cannot be in the future";
        });
        return false;
      }
    }

    setState(() => _dateError = null);
    return true;
  }

  void _applyFilter() {
    if (!_validateDates()) return;

    widget.onPressed(_selectedFromDate, _selectedToDate, _selectedType);
    Get.back();
  }

  void _clearAll() {
    setState(() {
      _selectedFromDate = null;
      _selectedToDate = null;
      _selectedType = "";
      _fromDateController.clear();
      _toDateController.clear();
      _typeController.clear();
      _dateError = null;
    });
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
                      text: "Expected Commission",
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
            SizedBox(height: 35.h),
            InputTitle(text: "From"),
            TextInputField(
              isDropdown: true,
              controller: _fromDateController,
              hintText: "Select start date",
              textInputType: TextInputType.text,
              onTap: () {
                selectDateModal(
                  dates: _selectedFromDate != null
                      ? [_selectedFromDate!]
                      : [DateTime.now()],
                  onPressed: (dates) {
                    setState(() {
                      _selectedFromDate = dates.first;
                      _fromDateController.text = _formatDate(dates.first);
                      _dateError = null;
                    });
                  },
                );
              },
            ),

            SizedBox(height: 16.h),
            InputTitle(text: "To Date"),
            TextInputField(
              isDropdown: true,
              controller: _toDateController,
              hintText: "Select end date",
              textInputType: TextInputType.text,
              onTap: () {
                selectDateModal(
                  dates: _selectedToDate != null
                      ? [_selectedToDate!]
                      : [DateTime.now()],
                  onPressed: (dates) {
                    setState(() {
                      _selectedToDate = dates.first;
                      _toDateController.text = _formatDate(dates.first);
                      _dateError = null;
                    });
                  },
                );
              },
            ),

            if (_dateError != null)
              Padding(
                padding: EdgeInsets.only(top: 8.h),
                child: Text(
                  _dateError!,
                  style: TextStyles.smallRegular12(
                    context,
                  ).copyWith(color: AppColors.error),
                ),
              ),

            SizedBox(height: 16.h),
            InputTitle(text: "Type"),
            TextInputField(
              isDropdown: true,
              controller: _typeController,
              hintText: 'All Statuses',
              textInputType: TextInputType.text,
              onTap: () {
                plainListModal(
                  title: "Type",
                  onPressed: (value) {
                    setState(() {
                      _selectedType = value;
                      _typeController.text = value.capitalize ?? "";
                    });
                  },
                  list: ReferralModel.getEnrollStatuses(),
                );
              },
            ),
            SizedBox(height: 32.h),
            Row(
              children: [
                Expanded(
                  child: IconTextButton(
                    onPressed: _clearAll,
                    text: "Clear All",
                    color: AppColors.dynamic10,
                    textColor: AppColors.dynamic,
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: IconTextButton(
                    onPressed: _applyFilter,
                    text: "Apply Filter",
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h + MediaQuery.of(context).viewPadding.bottom),
          ],
        ),
      ),
    );
  }
}
