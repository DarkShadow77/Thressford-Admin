import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:thressford_admin/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:thressford_admin/features/settings/data/models/response/admin_response_model.dart';

import '../../../../../app/styles/text_styles.dart';
import '../../../../../core/constants/app_colors.dart';
import '../../../../app/view/widgets/buttons/icon_text_button.dart';
import '../../../../core/constants/navigators/route_name.dart';
import '../../../../core/utils/ui_tool_mix.dart';
import '../../data/models/admin_enum.dart';
import '../bloc/admin_bloc.dart';
import '../widgets/admin_tile.dart';

class ManageAdminPage extends StatefulWidget {
  const ManageAdminPage({super.key});

  @override
  State<ManageAdminPage> createState() => _ManageAdminPageState();
}

class _ManageAdminPageState extends State<ManageAdminPage> with UIToolMixin {
  List<AdminModel> admins = [];

  @override
  void initState() {
    super.initState();
    final adminBloc = context.read<AdminBloc>();
    admins = adminBloc.state.admins;
    adminBloc.add(GetAllAdminEvent());
  }

  @override
  Widget build(BuildContext context) {
    AdminRole currentRole = context.read<DashboardBloc>().state.profile.role;
    return BlocBuilder<AdminBloc, AdminState>(
      builder: (context, state) {
        admins = state.admins;
        return Scaffold(
          body: SafeArea(
            top: false,
            child: Column(
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
                          text: "Manage Admins",
                          style: TextStyles.bodySemiBold16(
                            context,
                          ).copyWith(color: AppColors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 32.h),
                        if (admins.isEmpty) ...[
                          RichText(
                            textAlign: TextAlign.center,
                            text: TextSpan(
                              text:
                                  "No admin. When you add new admins, they will appear here",
                              style: TextStyles.bodySemiBold16(context),
                            ),
                          ),
                          SizedBox(height: 124.h),
                        ],
                        IconTextButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            RouteName.createAdminPage,
                          ),
                          text: "Create New Admin",
                          color: AppColors.primary,
                        ),
                        if (admins.isNotEmpty)
                          Expanded(
                            child: ListView.separated(
                              itemCount: admins.length,
                              physics: BouncingScrollPhysics(
                                parent: AlwaysScrollableScrollPhysics(),
                              ),
                              padding: EdgeInsets.symmetric(vertical: 32.h),
                              itemBuilder: (context, index) {
                                final admin = admins[index];
                                return AdminTile(
                                  admin: admin,
                                  currentUserRole: currentRole,
                                );
                              },
                              separatorBuilder: (_, _) =>
                                  SizedBox(height: 16.h),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
