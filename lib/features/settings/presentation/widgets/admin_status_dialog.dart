import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/core/utils/local_storage.dart';
import 'package:thressford_admin/features/settings/data/models/request/update_admin_status_request_model.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/constants/enums/app_enum.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../data/models/admin_enum.dart';
import '../../data/models/response/admin_response_model.dart';
import '../bloc/admin_bloc.dart';
import 'admin_success_dialog.dart';

Future<dynamic> adminStatusDialog({
  required AdminModel admin,
  bool deactivate = true,
}) async {
  return Get.dialog(
    name: "admin_status_dialog",
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    AdminStatusDialog(admin: admin, deactivate: deactivate),
  );
}

class AdminStatusDialog extends StatefulWidget {
  const AdminStatusDialog({
    super.key,
    required this.admin,
    required this.deactivate,
  });

  final AdminModel admin;
  final bool deactivate;

  @override
  State<AdminStatusDialog> createState() => _AdminStatusDialogState();
}

class _AdminStatusDialogState extends State<AdminStatusDialog>
    with UIToolMixin {
  bool loading = false;

  _onSubmit() async {
    widget.deactivate
        ? context.read<AdminBloc>().add(
            UpdateAdminStatusEvent(
              request: UpdateAdminStatusRequestModel(
                token: await LocalStorageHelper().getAccessToken() ?? "",
                email: widget.admin.email,
                status: AdminStatus.inactive,
              ),
            ),
          )
        : context.read<AdminBloc>().add(
            UpdateAdminStatusEvent(
              request: UpdateAdminStatusRequestModel(
                token: await LocalStorageHelper().getAccessToken() ?? "",
                email: widget.admin.email,
                status: AdminStatus.active,
              ),
            ),
          );
  }

  void _loadingAdminState(BuildContext context, AdminLoadingState state) {
    if (state.type == AdminType.updateAdminStatus) {
      setState(() => loading = true);
    }
  }

  void _successAdminState(BuildContext context, AdminSuccessState state) {
    if (state.type == AdminType.updateAdminStatus) {
      context.read<AdminBloc>().add(GetAllAdminEvent());
      Future.delayed((Duration(seconds: 1)), () {
        setState(() => loading = false);
        Navigator.pop(context);
        adminSuccessDialog(
          title: widget.deactivate ? "Admin Deactivated" : "Admin Active",
          subTitle: widget.deactivate
              ? "${widget.admin.fullName}’s access has been deactivated successfully."
              : "${widget.admin.fullName}’s access has been activated successfully.",
        );
      });
    }
  }

  void _failedAdminState(BuildContext context, AdminFailureState state) {
    if (state.type == AdminType.updateAdminStatus) {
      setState(() => loading = false);
      showMessage(context, state.message, status: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AdminBloc, AdminState>(
      listener: (context, state) {
        if (state is AdminLoadingState) {
          _loadingAdminState(context, state);
        } else if (state is AdminSuccessState) {
          _successAdminState(context, state);
        } else if (state is AdminFailureState) {
          _failedAdminState(context, state);
        }
      },
      child: Scaffold(
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
                  height: 525.h,
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 16.h,
                  ),
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    color: surfaceColor(),
                    borderRadius: BorderRadius.circular(32.r),
                  ),
                  child: Stack(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
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
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 60.r,
                            width: 60.r,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: widget.deactivate
                                  ? AppColors.orange5
                                  : AppColors.green5,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: HugeIcon(
                                icon: widget.deactivate
                                    ? HugeIcons.strokeRoundedPause
                                    : HugeIcons.strokeRoundedPlay,
                                color: widget.deactivate
                                    ? AppColors.orange
                                    : AppColors.green,
                                size: 18.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: widget.deactivate
                                  ? "Deactivate Admin?"
                                  : "Activate Admin?",
                              style: TextStyles.titleSemiBold20(context),
                            ),
                          ),
                          SizedBox(height: 24.h),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: widget.deactivate
                                  ? "Are you sure you want to deactivate this admin?"
                                  : "Are you sure you want to activate this admin’s access?",
                              style: TextStyles.bodyRegular16(
                                context,
                                opacity: .5,
                              ),
                            ),
                          ),
                          SizedBox(height: 32.h),
                          Row(
                            spacing: 10.w,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              if (!loading)
                                Expanded(
                                  child: IconTextButton(
                                    height: 53,
                                    onPressed: () => Navigator.pop(context),
                                    text: "Cancel",
                                    color: surfaceColor(),
                                    textColor: AppColors.dynamic,
                                    borderColor: AppColors.dynamic30,
                                  ),
                                ),
                              Expanded(
                                child: IconTextButton(
                                  height: 53,
                                  onPressed: _onSubmit,
                                  text: widget.deactivate
                                      ? "Deactivate"
                                      : "Activate",
                                  buttonState: loading
                                      ? AppButtonState.loading
                                      : AppButtonState.idle,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.h),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
