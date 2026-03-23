import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

import '../../../../../app/view/widgets/input/text_input_field.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/styles/text_styles.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../app/view/widgets/input/input_title.dart';
import '../../../../core/constants/enums/app_enum.dart';
import '../../../../core/constants/navigators/route_name.dart';
import '../../../../core/utils/local_storage.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../data/models/request/add_admin_request_model.dart';
import '../bloc/admin_bloc.dart';
import '../widgets/admin_access_list_modal.dart';
import 'create_admin_successful_page.dart';

class CreateAdminPage extends StatefulWidget {
  const CreateAdminPage({super.key});

  @override
  State<CreateAdminPage> createState() => _CreateAdminPageState();
}

class _CreateAdminPageState extends State<CreateAdminPage> with UIToolMixin {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _accessController = TextEditingController();

  bool _isFullNameValid = false;
  bool _isEmailValid = false;
  bool _isPassValid = false;
  bool _isAccessValid = false;
  bool _isFormValid = true;

  bool loading = false;

  String adminValue = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _accessController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> accessList = [
    {"id": 1, "value": "admin", "label": "Level 1", "access": "Submissions"},
    {
      "id": 2,
      "value": "sub_admin",
      "label": "Level 2",
      "access": "Submissions, Users Management, Referral Management",
    },
    {
      "id": 3,
      "value": "super_admin",
      "label": "Level 3",
      "access": "Everything",
    },
  ];

  void _validateForm() {
    String fullName = _fullNameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String access = _accessController.text.trim();

    setState(() {
      _isFullNameValid = fullName.split(" ").length > 1;
      _isEmailValid = GetUtils.isEmail(email);
      _isPassValid = password.length > 1;
      _isAccessValid = access.length > 1 && adminValue.isNotEmpty;
    });
  }

  bool _formValidation() {
    return _isFullNameValid && _isEmailValid && _isPassValid && _isAccessValid;
  }

  void _submit() async {
    _validateForm();
    _isFormValid = _formValidation();
    if (_isFormValid) {
      context.read<AdminBloc>().add(
        AddAdminEvent(
          request: AddAdminRequestModel(
            token: await LocalStorageHelper().getAccessToken() ?? "",
            fullName: _fullNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
            role: adminValue,
          ),
        ),
      );
    }
  }

  void _loadingAdminState(BuildContext context, AdminLoadingState state) {
    if (state.type == AdminType.addAdmin) {
      setState(() => loading = true);
    }
  }

  void _successAdminState(BuildContext context, AdminSuccessState state) {
    if (state.type == AdminType.addAdmin) {
      context.read<AdminBloc>().add(GetAllAdminEvent());
      Future.delayed((Duration(seconds: 1)), () {
        setState(() => loading = false);
        Navigator.of(context).pushNamed(
          RouteName.createAdminSuccessPage,
          arguments: CreateAdminSuccessPageParam(
            fullName: _fullNameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text.trim(),
          ),
        );
      });
    }
  }

  void _failedAdminState(BuildContext context, AdminFailureState state) {
    if (state.type == AdminType.addAdmin) {
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
        appBar: AppBar(
          titleSpacing: 20.w,
          automaticallyImplyLeading: false,
          toolbarHeight: kToolbarHeight + 20.h,
          title: Row(
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
                    color: AppColors.dynamic05,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.arrow_back_rounded,
                      size: 24.sp,
                      color: AppColors.dynamic,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: "Create New Admin",
                  style: TextStyles.bodySemiBold16(context),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: CustomScrollView(
                physics: BouncingScrollPhysics(),
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(height: 40.h),
                        InputTitle(text: "Admin Full Name"),
                        TextInputField(
                          enabled: !loading,
                          errorBool: !_isFormValid && !_isFullNameValid,
                          controller: _fullNameController,
                          hintText: 'Enter admin full name',
                          textInputType: TextInputType.text,
                          textCapitalization: TextCapitalization.words,
                          onChanged: (value) => _validateForm(),
                        ),
                        SizedBox(height: 16.h),
                        InputTitle(text: "Admin Email Address"),
                        TextInputField(
                          enabled: !loading,
                          errorBool: !_isFormValid && !_isEmailValid,
                          controller: _emailController,
                          hintText: 'Enter admin email',
                          textInputType: TextInputType.emailAddress,
                          onChanged: (value) => _validateForm(),
                        ),
                        SizedBox(height: 16.h),
                        InputTitle(text: "Admin Password"),
                        TextInputField(
                          enabled: !loading,
                          isPassword: true,
                          errorBool: !_isFormValid && !_isPassValid,
                          controller: _passwordController,
                          hintText: 'Create admin password',
                          textInputType: TextInputType.visiblePassword,
                          onChanged: (value) => _validateForm(),
                        ),
                        SizedBox(height: 16.h),
                        InputTitle(text: "Assign Access"),
                        TextInputField(
                          enabled: !loading,
                          isDropdown: true,
                          errorBool: !_isFormValid && !_isAccessValid,
                          controller: _accessController,
                          hintText: 'Select access level',
                          onChanged: (value) => _validateForm(),
                          onTap: () {
                            adminAccessListModal(
                              list: accessList,
                              onPressed: (value) {
                                final selectedAccess = accessList.firstWhere(
                                  (e) => e["value"] == value,
                                );

                                _accessController.text = selectedAccess["label"]
                                    .toString();
                                setState(() {
                                  adminValue = selectedAccess["value"];
                                });
                                _validateForm();
                              },
                            );
                          },
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
                            text: "Create Admin",
                            color: _formValidation()
                                ? AppColors.primary
                                : AppColors.dynamic10,
                            buttonState: loading
                                ? AppButtonState.loading
                                : AppButtonState.idle,
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
