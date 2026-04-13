import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:thressford_admin/features/user_management/data/models/users_management_status_enum.dart';
import 'package:thressford_admin/features/user_management/presentation/widgets/user_status_success_dialog.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/constants/enums/app_enum.dart';
import '../../../../core/utils/helpers.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../data/models/response/users_response_model.dart';
import '../bloc/users_bloc.dart';

Future<dynamic> deactivateUserDialog({
  required UsersModel user,
  bool deactivate = true,
}) async {
  return Get.dialog(
    name: "deactivate_user_dialog",
    barrierColor: Colors.transparent,
    barrierDismissible: true,
    DeactivateUserDialog(user: user, deactivate: deactivate),
  );
}

class DeactivateUserDialog extends StatefulWidget {
  const DeactivateUserDialog({
    super.key,
    required this.user,
    required this.deactivate,
  });

  final UsersModel user;
  final bool deactivate;

  @override
  State<DeactivateUserDialog> createState() => _DeactivateUserDialogState();
}

class _DeactivateUserDialogState extends State<DeactivateUserDialog>
    with UIToolMixin {
  bool loading = false;

  void _loadingUsersState(BuildContext context, UsersLoadingState state) {
    if (state.type == UsersType.deactivateUser ||
        state.type == UsersType.unsuspendUser) {
      setState(() => loading = true);
    }
  }

  void _successUsersState(BuildContext context, UsersSuccessState state) {
    if (state.type == UsersType.deactivateUser ||
        state.type == UsersType.unsuspendUser) {
      context.read<UsersBloc>().add(GetAllUsersEvent());
      Future.delayed((Duration(seconds: 1)), () {
        setState(() => loading = false);
        Navigator.pop(context);
        userStatusSuccessfulDialog(
          user: widget.user,
          title: widget.deactivate ? "User Deactivated" : "User Reactivated",
          subTitle: widget.deactivate
              ? "${widget.user.fullName}’s account has been deactivated successfully."
              : "${widget.user.fullName}’s account has been successfully reactivated",
        );
      });
    }
  }

  void _failedUsersState(BuildContext context, UsersFailureState state) {
    if (state.type == UsersType.deactivateUser ||
        state.type == UsersType.unsuspendUser) {
      setState(() => loading = false);
      showMessage(context, state.message, status: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UsersBloc, UsersState>(
      listener: (context, state) {
        if (state is UsersLoadingState) {
          _loadingUsersState(context, state);
        } else if (state is UsersSuccessState) {
          _successUsersState(context, state);
        } else if (state is UsersFailureState) {
          _failedUsersState(context, state);
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
                                  ? AppColors.error5
                                  : AppColors.green5,
                              shape: BoxShape.circle,
                            ),
                            child: IconButton(
                              onPressed: () => Navigator.pop(context),
                              icon: HugeIcon(
                                icon: widget.deactivate
                                    ? HugeIcons.strokeRoundedCancel01
                                    : HugeIcons.strokeRoundedPlay,
                                color: widget.deactivate
                                    ? AppColors.error
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
                                  ? "Deactivate User?"
                                  : "Reactivate User?",
                              style: TextStyles.titleSemiBold20(context),
                            ),
                          ),
                          SizedBox(height: 16.h),
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text: widget.deactivate
                                  ? "This will deactivate ${widget.user.fullName}'s account. This action cannot be undone without a Super Admin Authority."
                                  : "Are you sure you want to reactivate ${widget.user.fullName}'s account?",
                              style: TextStyles.normalRegular14(
                                context,
                                opacity: .5,
                              ),
                            ),
                          ),
                          SizedBox(height: 56.h),
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
                                  onPressed: () {
                                    widget.deactivate
                                        ? context.read<UsersBloc>().add(
                                            DeactivateUserEvent(
                                              email: widget.user.email,
                                              status: UsersStatus.inactive,
                                            ),
                                          )
                                        : context.read<UsersBloc>().add(
                                            UnsuspendUserEvent(
                                              email: widget.user.email,
                                              status: UsersStatus.active,
                                            ),
                                          );
                                  },
                                  text: widget.deactivate
                                      ? "Deactivate"
                                      : "Reactivate",
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
