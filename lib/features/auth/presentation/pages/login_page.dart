import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:thressford_admin/core/constants/strings.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../app/view/widgets/input/text_input_field.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../app/view/widgets/input/input_title.dart';
import '../../../../app/view/widgets/thessford_icon.dart';
import '../../../../core/constants/enums/app_enum.dart';
import '../../../../core/constants/navigators/route_name.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../data/models/request/login_request_model.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with UIToolMixin {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isEmailValid = false;
  bool _isPassValid = false;
  bool _isFormValid = true;

  bool loading = false;
  bool waitingProfile = false;
  bool _isInit = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      setState(() => _isInit = true);
    });
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    setState(() {
      _isEmailValid = GetUtils.isEmail(email);
      _isPassValid = password.length > 1;
    });
  }

  bool _formValidation() {
    return _isEmailValid && _isPassValid;
  }

  void _submit() {
    _validateForm();
    _isFormValid = _formValidation();
    if (_isFormValid) {
      context.read<AuthBloc>().add(
        LoginEvent(
          request: LoginRequestModel(
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        ),
      );
    }
  }

  void _loadingAuthState(BuildContext context, AuthLoadingState state) {
    if (state.type == AuthType.login) {
      setState(() => loading = true);
    }
  }

  void _successAuthState(BuildContext context, AuthSuccessState state) {
    if (state.type == AuthType.login) {
      setState(() => loading = true);
      Future.delayed((Duration(seconds: 1)), () {
        setState(() => loading = false);
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil(RouteName.dashboardPage, (route) => false);
      });
    }
  }

  void _failedAuthState(BuildContext context, AuthFailureState state) {
    if (state.type == AuthType.login) {
      setState(() => loading = false);
      showMessage(context, state.message, status: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoadingState) {
          _loadingAuthState(context, state);
        } else if (state is AuthSuccessState) {
          _successAuthState(context, state);
        } else if (state is AuthFailureState) {
          _failedAuthState(context, state);
        }
      },
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedContainer(
              duration: Duration(seconds: 3),
              curve: Curves.easeInOut,
              height: (_isInit
                  ? 170.h + MediaQuery.of(context).padding.top
                  : AppSize.height),
              decoration: BoxDecoration(
                color: AppColors.navyBlue,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(_isInit ? 32.r : 0.r),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (_isInit)
                    SizedBox(height: 4.h + MediaQuery.of(context).padding.top),
                  TweenAnimationBuilder<double>(
                    duration: Duration(seconds: 3),
                    curve: Curves.easeInOut,
                    tween: Tween(begin: 80.0, end: _isInit ? 64.0 : 80.0),
                    builder: (context, size, child) {
                      return TweenAnimationBuilder<double>(
                        duration: Duration(seconds: 3),
                        curve: Curves.easeInOut,
                        tween: Tween(begin: 14.0, end: _isInit ? 24.0 : 14.0),
                        builder: (context, radius, child) {
                          return ThessfordIcon(
                            width: size.r,
                            height: size.r,
                            iconColor: AppColors.white,
                            bgColor: AppColors.primary,
                            radius: radius.r,
                          );
                        },
                      );
                    },
                  ),
                  if (_isInit) ...[
                    SizedBox(height: 16.h),
                    RichText(
                      text: TextSpan(
                        text: "Admin Portal",
                        style: TextStyles.bodySemiBold16(
                          context,
                        ).copyWith(color: AppColors.white),
                      ),
                    ).fadeIn(delay: Duration(seconds: 2)),
                    SizedBox(height: 4.h).fadeIn(delay: Duration(seconds: 2)),
                    RichText(
                      text: TextSpan(
                        text: "Thessford Global Control Center",
                        style: TextStyles.bodyRegular16(
                          context,
                        ).copyWith(color: AppColors.white50),
                      ),
                    ).fadeIn(delay: Duration(seconds: 2)),
                  ],
                ],
              ),
            ),
            if (_isInit)
              Expanded(
                child: CustomScrollView(
                  physics: BouncingScrollPhysics(),
                  slivers: [
                    SliverPadding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          SizedBox(height: 64.h),
                          InputTitle(
                            text: "Admin Email Address",
                          ).fadeInLeft(delay: Duration(seconds: 2)),
                          TextInputField(
                            enabled: !loading,
                            errorBool: !_isFormValid && !_isEmailValid,
                            controller: _emailController,
                            hintText: 'Enter your email',
                            textInputType: TextInputType.emailAddress,
                            onChanged: (value) => _validateForm(),
                          ).fadeInLeft(
                            delay: Duration(seconds: 2, milliseconds: 200),
                          ),
                          SizedBox(height: 16.h),
                          InputTitle(text: "Admin Password").fadeInLeft(
                            delay: Duration(seconds: 2, milliseconds: 400),
                          ),
                          TextInputField(
                            enabled: !loading,
                            isPassword: true,
                            errorBool: !_isFormValid && !_isPassValid,
                            controller: _passwordController,
                            hintText: 'Enter your password',
                            textInputType: TextInputType.visiblePassword,
                            onChanged: (value) => _validateForm(),
                          ).fadeInLeft(
                            delay: Duration(seconds: 2, milliseconds: 600),
                          ),
                          SizedBox(height: 32.h),
                        ]),
                      ),
                    ),
                    if (_isInit)
                      SliverPadding(
                        padding: EdgeInsets.symmetric(horizontal: 20.w),
                        sliver: SliverFillRemaining(
                          hasScrollBody: false,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconTextButton(
                                onPressed: _submit,
                                text: "Access Admin Panel",
                                color: _formValidation()
                                    ? AppColors.primary
                                    : AppColors.dynamic10,
                                buttonState: loading
                                    ? AppButtonState.loading
                                    : AppButtonState.idle,
                              ).fadeInLeft(
                                delay: Duration(seconds: 2, milliseconds: 800),
                              ),
                              SizedBox(
                                height:
                                    20.h +
                                    MediaQuery.of(context).viewPadding.bottom,
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
      ),
    );
  }
}
