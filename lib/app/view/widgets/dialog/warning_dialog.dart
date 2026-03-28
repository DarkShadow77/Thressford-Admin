import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thressford_admin/core/constants/strings.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/ui_tool_mix.dart';

Future<dynamic> warningDialog({required String text}) async {
  return Get.dialog(
    name: "warning_dialog",
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    WarningDialog(text: text),
  );
}

class WarningDialog extends StatefulWidget {
  const WarningDialog({super.key, required this.text});

  final String text;

  @override
  State<WarningDialog> createState() => _WarningDialogState();
}

class _WarningDialogState extends State<WarningDialog> with UIToolMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
            child: Container(color: Colors.black.withValues(alpha: 0.2)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: BoxConstraints(
                  maxHeight:
                      AppSize.height -
                      50.h -
                      MediaQuery.of(context).padding.top -
                      MediaQuery.of(context).viewPadding.bottom,
                  minHeight: 50.h,
                ),
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                decoration: BoxDecoration(
                  color: surfaceColor(),
                  borderRadius: BorderRadius.circular(32.r),
                ),
                child: Column(
                  spacing: 20.h,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Flexible(
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: widget.text,
                          style: TextStyles.normalSemibold14(
                            context,
                            opacity: .5,
                          ),
                        ),
                      ),
                    ),
                    IconTextButton(
                      height: 53,
                      onPressed: () => Navigator.pop(context),
                      text: "Close",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
