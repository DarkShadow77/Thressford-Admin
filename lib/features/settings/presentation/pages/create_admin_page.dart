import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../app/view/widgets/input/text_input_field.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/pages/successful_page.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../app/view/widgets/input/input_title.dart';
import '../../../../core/constants/enums/app_enum.dart';
import '../../../../core/constants/navigators/route_name.dart';
import '../../../../core/utils/ui_tool_mix.dart';

class CreateAdminPage extends StatefulWidget {
  const CreateAdminPage({super.key});

  @override
  State<CreateAdminPage> createState() => _CreateAdminPageState();
}

class _CreateAdminPageState extends State<CreateAdminPage> with UIToolMixin {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isOldPassValid = false;
  bool _isPassValid = false;
  bool _isConfirmPassValid = false;
  bool _isFormValid = true;

  bool loading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    String oldPassword = _oldPasswordController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    setState(() {
      _isOldPassValid = oldPassword.length > 1;
      _isPassValid = password.length > 1;
      _isConfirmPassValid = password == confirmPassword;
    });
  }

  bool _formValidation() {
    return _isOldPassValid && _isPassValid && _isConfirmPassValid;
  }

  void _submit() async {
    _validateForm();
    _isFormValid = _formValidation();
    if (_isFormValid) {
      setState(() => loading = true);

      Future.delayed(Duration(seconds: 2), () {
        setState(() => loading = false);

        Navigator.pushNamed(
          context,
          RouteName.successfulPage,
          arguments: SuccessfulPageParam(
            title: "Password Saved",
            subTitle: "Admin password has been updated successfully.",
            btnText: "Back to Dashboard",
            onTap: () {
              Navigator.of(context).pushNamedAndRemoveUntil(
                RouteName.dashboardPage,
                (route) => false,
              );
            },
          ),
        );
      });
      /*context.read<ProfileBloc>().add(
        ChangePasswordEvent(
          request: ChangePasswordRequestModel(
            token: await LocalStorageHelper().getAccessToken() ?? "",
            oldPassword: _oldPasswordController.text.trim(),
            newPassword: _passwordController.text.trim(),
            confirmNewPassword: _confirmPasswordController.text.trim(),
          ),
        ),
      );*/
    }
  }

  /* void _loadingProfileState(BuildContext context, ProfileLoadingState state) {
    if (state.type == ProfileType.changePassword) {
      setState(() => loading = true);
    }
  }

  void _successProfileState(BuildContext context, ProfileSuccessState state) {
    if (state.type == ProfileType.changePassword) {
      setState(() => loading = false);

      context.read<ProfileBloc>().add(GetProfileEvent());

      Navigator.pushNamed(
        context,
        RouteName.successfulPage,
        arguments: SuccessfulPageParam(
          title: "Password Saved",
          subTitle: "Your profile password has been updated successfully.",
          btnText: "Back to Dashboard",
          onTap: () {
            Navigator.of(
              context,
            ).pushNamedAndRemoveUntil(RouteName.profilePage, (route) => false);
          },
        ),
      );
    }
  }

  void _failedProfileState(BuildContext context, ProfileFailureState state) {
    if (state.type == ProfileType.changePassword) {
      setState(() => loading = false);
      showMessage(
        context,
        "Failed to Update Password",
        subText: state.message,
        status: true,
      );
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    /*return BlocListener<ProfileBloc, ProfileState>(
      listener: (context, state) {
        if (state is ProfileLoadingState) {
          _loadingProfileState(context, state);
        } else if (state is ProfileSuccessState) {
          _successProfileState(context, state);
        } else if (state is ProfileFailureState) {
          _failedProfileState(context, state);
        }
      },
      child:
    );*/
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 150.h + MediaQuery.of(context).padding.top,
            padding: EdgeInsets.symmetric(
              horizontal: 20.w,
              vertical: MediaQuery.of(context).padding.top,
            ),
            decoration: BoxDecoration(
              color: AppColors.navyBlue,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(32.r),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: kToolbarHeight + 20.h,
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
                              color: AppColors.navyBlue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                RichText(
                  text: TextSpan(
                    text: "Change Password",
                    style: TextStyles.bodySemiBold16(
                      context,
                    ).copyWith(color: AppColors.white),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: CustomScrollView(
              physics: BouncingScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      SizedBox(height: 40.h),
                      InputTitle(text: "Old Password"),
                      TextInputField(
                        enabled: !loading,
                        isPassword: true,
                        errorBool: !_isFormValid && !_isOldPassValid,
                        controller: _oldPasswordController,
                        hintText: 'Enter old password',
                        textInputType: TextInputType.visiblePassword,
                        onChanged: (value) => _validateForm(),
                      ),
                      SizedBox(height: 16.h),
                      InputTitle(text: "New Password"),
                      TextInputField(
                        enabled: !loading,
                        isPassword: true,
                        errorBool: !_isFormValid && !_isPassValid,
                        controller: _passwordController,
                        hintText: 'Enter your password',
                        textInputType: TextInputType.visiblePassword,
                        onChanged: (value) => _validateForm(),
                      ),
                      SizedBox(height: 16.h),
                      InputTitle(text: "Confirm Password"),
                      TextInputField(
                        enabled: !loading,
                        isPassword: true,
                        errorBool: !_isFormValid && !_isConfirmPassValid,
                        controller: _confirmPasswordController,
                        hintText: 'Enter new password again',
                        textInputType: TextInputType.visiblePassword,
                        onChanged: (value) => _validateForm(),
                      ),
                      SizedBox(height: 32.h),
                    ]),
                  ),
                ),
                SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  sliver: SliverFillRemaining(
                    hasScrollBody: false,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconTextButton(
                          onPressed: _submit,
                          text: "Save Changes",
                          color: _formValidation()
                              ? AppColors.primary
                              : AppColors.dynamic10,
                          buttonState: loading
                              ? AppButtonState.loading
                              : AppButtonState.idle,
                        ),
                        SizedBox(
                          height:
                              20.h + MediaQuery.of(context).viewPadding.bottom,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
