import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:thressford_admin/core/constants/app_assets.dart';
import 'package:thressford_admin/features/referral_management/data/models/response/referral_response_model.dart';

import '../../../../app/styles/text_styles.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers.dart';
import '../../../referral_management/data/models/referral_status_enum.dart';
import '../../../referral_management/presentation/bloc/referral_bloc.dart';
import '../../../user_management/data/models/response/users_response_model.dart';
import '../../../user_management/presentation/bloc/users_bloc.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => ReportPageState();
}

class ReportPageState extends State<ReportPage> {
  String filterType = "Week";

  List<ReferralModel> referrals = [];
  List<UsersModel> users = [];

  @override
  void initState() {
    super.initState();
    context.read<ReferralBloc>().add(GetAllReferralEvent());
    context.read<UsersBloc>().add(GetAllUsersEvent());
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReferralBloc, ReferralState>(
      builder: (context, state) {
        referrals = state.referral;
        return BlocBuilder<UsersBloc, UsersState>(
          builder: (context, state) {
            users = state.users;

            return Scaffold(
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
              body: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 10.h),
                          Row(
                            spacing: 16.w,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Column(
                                  spacing: 8.h,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RichText(
                                      text: TextSpan(
                                        text: "Reports & Analytics",
                                        style: TextStyles.bodySemiBold16(
                                          context,
                                        ),
                                      ),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: "Performance insights",
                                        style: TextStyles.bodyRegular16(
                                          context,
                                          opacity: .75,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: 40.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.dynamic05,
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    AssetsSvgIcons.rise,
                                    width: 20.sp,
                                    height: 20.sp,
                                    colorFilter: ColorFilter.mode(
                                      AppColors.dynamic60,
                                      BlendMode.srcIn,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16.h),
                          Divider(height: 1.h, color: AppColors.dynamic10),
                          SizedBox(height: 20.h),
                          Row(
                            spacing: 20.w,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 110.w,
                                child: PopupMenuButton<String>(
                                  color: surfaceColor(),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                  shadowColor: AppColors.dynamic20,
                                  position: PopupMenuPosition.under,
                                  onSelected: (value) {
                                    setState(() => filterType = value);
                                  },
                                  menuPadding: EdgeInsets.symmetric(
                                    vertical: 8.h,
                                    horizontal: 4.w,
                                  ),
                                  padding: EdgeInsets.zero,
                                  constraints: BoxConstraints(maxWidth: 170.w),
                                  itemBuilder: (context) =>
                                      ["Week", "Month", "Year"]
                                          .map(
                                            (e) => _buildPopupMenuItem(
                                              context,
                                              value: e,
                                              text: e,
                                              selected: filterType == e,
                                            ),
                                          )
                                          .toList(),
                                  child: InkWell(
                                    onTap: null,
                                    borderRadius: BorderRadius.circular(24.r),
                                    child: Ink(
                                      padding: EdgeInsets.symmetric(
                                        vertical: 4.h,
                                        horizontal: 10.w,
                                      ),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          24.r,
                                        ),
                                      ),
                                      child: Row(
                                        spacing: 12.w,
                                        children: [
                                          Flexible(
                                            child: RichText(
                                              text: TextSpan(
                                                text: filterType.capitalize,
                                                style:
                                                    TextStyles.bodySemiBold16(
                                                      context,
                                                    ),
                                              ),
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down_rounded,
                                            size: 24.sp,
                                            color: AppColors.dynamic60,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              PopupMenuButton<String>(
                                color: surfaceColor(),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.r),
                                ),
                                borderRadius: BorderRadius.circular(12.r),
                                shadowColor: AppColors.dynamic20,
                                position: PopupMenuPosition.under,
                                onSelected: (value) {
                                  setState(() => filterType = value);
                                },
                                menuPadding: EdgeInsets.symmetric(
                                  vertical: 8.h,
                                  horizontal: 4.w,
                                ),
                                padding: EdgeInsets.zero,
                                constraints: BoxConstraints(maxWidth: 170.w),
                                itemBuilder: (context) =>
                                    ["Week", "Month", "Year"]
                                        .map(
                                          (e) => _buildPopupMenuItem(
                                            context,
                                            value: e,
                                            text: e,
                                            selected: filterType == e,
                                          ),
                                        )
                                        .toList(),
                                child: Container(
                                  width: 56.w,
                                  height: 56.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.dynamic20,
                                    ),
                                    borderRadius: BorderRadius.circular(14.r),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      AssetsSvgIcons.filter,
                                      width: 24.w,
                                      height: 24.h,
                                      fit: BoxFit.contain,
                                      colorFilter: ColorFilter.mode(
                                        AppColors.dynamic,
                                        BlendMode.srcIn,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          vertical: 24.h,
                          horizontal: 20.w,
                        ),
                        child: Column(
                          spacing: 24.h,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            OverviewWidget(
                              filterType: filterType,
                              referrals: referrals,
                              users: users,
                            ),
                            ReferralPerformance(referrals: referrals),
                            RevenueTrend(referrals: referrals),
                            TopPerformers(referrals: referrals, users: users),
                            SizedBox(height: 20.h),
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
      },
    );
  }
}

class ReferralPerformance extends StatelessWidget {
  const ReferralPerformance({super.key, required this.referrals});

  final List<ReferralModel> referrals;

  // Returns the 6 months to display: 5 months ago → current month
  List<DateTime> get _months {
    final now = DateTime.now();
    return List.generate(6, (i) {
      final m = now.month - 5 + i;
      final y = now.year + (m <= 0 ? -1 : 0);
      final adjustedM = m <= 0 ? m + 12 : m;
      return DateTime(y, adjustedM);
    });
  }

  // Count referrals created in a given month
  int _referralsForMonth(DateTime month) {
    return referrals.where((r) {
      final d = DateTime.tryParse(r.createdAt);
      return d != null && d.year == month.year && d.month == month.month;
    }).length;
  }

  // Count conversions (enrollStatus.level >= 5) whose enrollModDate/updatedAt falls in month
  int _conversionsForMonth(DateTime month) {
    return referrals.where((r) {
      if (!r.enrollStatus.isConverted) return false;
      final raw = r.enrollModDate ?? r.updatedAt ?? r.createdAt;
      final d = DateTime.tryParse(raw);
      return d != null && d.year == month.year && d.month == month.month;
    }).length;
  }

  // Smart Y-axis step: max / 4, rounded to a "clean" number
  int _yStep(int maxVal) {
    if (maxVal == 0) return 1;
    final raw = maxVal / 4;
    for (final step in [1, 2, 5, 10, 20, 50, 100, 200, 500, 1000, 2000, 5000]) {
      if (step >= raw) return step;
    }
    return (raw / 1000).ceil() * 1000;
  }

  @override
  Widget build(BuildContext context) {
    final months = _months;
    final now = DateTime.now();

    final monthLabels = months.map((m) {
      final name = DateFormat('MMM').format(m);
      // Show year label if month is not in current year
      final showYear = m.year != now.year;
      return (label: name, year: showYear ? m.year.toString() : null);
    }).toList();

    final referralCounts = months.map(_referralsForMonth).toList();
    final conversionCounts = months.map(_conversionsForMonth).toList();

    final maxVal = [...referralCounts, ...conversionCounts].fold(0, max);
    final step = _yStep(maxVal);
    final yMax = step * 4; // always 4 steps above 0

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: surfaceColor(),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            color: AppColors.dynamic10,
            blurRadius: 5.r,
            spreadRadius: 2.r,
          ),
        ],
      ),
      child: Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: "Referral Performance",
                    style: TextStyles.normalRegular14(context),
                  ),
                ),
              ),
              SvgPicture.asset(
                AssetsSvgIcons.calender,
                width: 16.w,
                height: 16.h,
                colorFilter: ColorFilter.mode(
                  AppColors.dynamic,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 200.h,
            child: Row(
              spacing: 8.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Y-axis labels
                Padding(
                  padding: EdgeInsets.only(bottom: 35.w),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: List.generate(5, (i) {
                      final val = step * (4 - i); // 4→3→2→1→0
                      return RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: i == 4 ? '0' : '$val',
                          style: TextStyles.smallRegular12(
                            context,
                            opacity: .5,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                // Grid + bars
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 6.h),
                      Expanded(
                        child: CustomPaint(
                          painter: _GridPainter(
                            gridColor: AppColors.dynamic10,
                            lineCount: 4,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: List.generate(6, (i) {
                              final refCount = referralCounts[i];
                              final convCount = conversionCounts[i];
                              final label = monthLabels[i];

                              final chartHeight =
                                  160.h * (4 / 5); // top 4/5 is chart area
                              final refHeight = yMax == 0
                                  ? 0.0
                                  : (refCount / yMax) * chartHeight;
                              final convHeight = yMax == 0
                                  ? 0.0
                                  : (convCount / yMax) * chartHeight;
                              final barWidth = 10.w;

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  // Bars
                                  Row(
                                    spacing: 3.w,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Referral bar
                                      Container(
                                        width: barWidth,
                                        height: refHeight.clamp(
                                          2.0,
                                          double.infinity,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(4.r),
                                          ),
                                        ),
                                      ),
                                      // Conversion bar
                                      Container(
                                        width: barWidth,
                                        height: convHeight.clamp(
                                          2.0,
                                          double.infinity,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.dynamic,
                                          borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(4.r),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Month label
                                  SizedBox(
                                    height: 40.h,
                                    child: Column(
                                      children: [
                                        SizedBox(height: 6.h),
                                        RichText(
                                          text: TextSpan(
                                            text: label.label,
                                            style: TextStyles.smallRegular12(
                                              context,
                                              opacity: .6,
                                            ),
                                          ),
                                        ),
                                        if (label.year != null)
                                          RichText(
                                            text: TextSpan(
                                              text: label.year,
                                              style: TextStyles.cardRegular10(
                                                context,
                                                opacity: .4,
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            }),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            spacing: 20.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: _LegendDot(
                  color: AppColors.primary,
                  label: "Referrals",
                  context: context,
                ),
              ),
              Flexible(
                child: _LegendDot(
                  color: AppColors.dynamic,
                  label: "Conversions",
                  context: context,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Horizontal dashed grid lines
class _GridPainter extends CustomPainter {
  final Color gridColor;
  final int lineCount;

  _GridPainter({required this.gridColor, required this.lineCount});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    // Draw lineCount horizontal lines (not including bottom)
    for (int i = 0; i <= lineCount; i++) {
      final y = size.height * (4 / 5) * (i / lineCount);
      // Dashed line
      double x = 0;
      const dashWidth = 6.0;
      const dashSpace = 4.0;
      while (x < size.width) {
        canvas.drawLine(Offset(x, y), Offset(x + dashWidth, y), paint);
        x += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(_GridPainter old) => false;
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({
    required this.color,
    required this.label,
    required this.context,
  });

  final Color color;
  final String label;
  final BuildContext context;

  @override
  Widget build(BuildContext context) {
    return Row(
      spacing: 8.w,
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 12.w,
          height: 12.h,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        Flexible(
          child: RichText(
            text: TextSpan(
              text: label,
              style: TextStyles.smallRegular12(context, opacity: .65),
            ),
          ),
        ),
      ],
    );
  }
}

class RevenueTrend extends StatelessWidget {
  const RevenueTrend({super.key, required this.referrals});

  final List<ReferralModel> referrals;

  List<DateTime> get _months {
    final now = DateTime.now();
    return List.generate(6, (i) {
      final m = now.month - 5 + i;
      final y = now.year + (m <= 0 ? -1 : 0);
      final adjustedM = m <= 0 ? m + 12 : m;
      return DateTime(y, adjustedM);
    });
  }

  double _paidForMonth(DateTime month) {
    return referrals
        .where((r) {
          final isPaid =
              r.commissionStatus == CommissionStatus.paid ||
              r.enrollStatus == EnrollReferralStatus.paid;
          if (!isPaid) return false;
          final raw = r.enrollModDate ?? r.updatedAt ?? r.createdAt;
          final d = DateTime.tryParse(raw);
          return d != null && d.year == month.year && d.month == month.month;
        })
        .fold(
          0.0,
          (sum, r) => sum + (double.tryParse(r.expectedCommission) ?? 0),
        );
  }

  int _yStep(double maxVal) {
    if (maxVal == 0) return 1;
    final raw = maxVal / 4;
    for (final step in [
      1,
      2,
      5,
      10,
      20,
      50,
      100,
      200,
      500,
      1000,
      2000,
      5000,
      10000,
    ]) {
      if (step >= raw) return step;
    }
    return (raw / 1000).ceil() * 1000;
  }

  @override
  Widget build(BuildContext context) {
    final months = _months;
    final now = DateTime.now();

    final monthLabels = months.map((m) {
      final name = DateFormat('MMM').format(m);
      final showYear = m.year != now.year;
      return (label: name, year: showYear ? m.year.toString() : null);
    }).toList();

    final values = months.map(_paidForMonth).toList();
    final maxVal = values.fold(0.0, (a, b) => a > b ? a : b);
    final step = _yStep(maxVal);
    final yMax = (step * 4).toDouble();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: surfaceColor(),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: AppColors.dynamic10,
            blurRadius: 5.r,
            spreadRadius: 2.r,
          ),
        ],
      ),
      child: Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Header
          Row(
            spacing: 10.w,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: RichText(
                  text: TextSpan(
                    text: "Revenue Trend",
                    style: TextStyles.normalRegular14(context),
                  ),
                ),
              ),
              SvgPicture.asset(
                AssetsSvgIcons.rise,
                width: 16.w,
                height: 16.h,
                colorFilter: ColorFilter.mode(AppColors.green, BlendMode.srcIn),
              ),
            ],
          ),
          SizedBox(
            height: 200.h,
            child: Row(
              spacing: 8.w,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Y-axis labels
                Padding(
                  padding: EdgeInsets.only(bottom: 35.h),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(5, (i) {
                      final val = step * (4 - i);
                      return RichText(
                        text: TextSpan(
                          text: i == 4 ? '0' : '$val',
                          style: TextStyles.smallRegular12(
                            context,
                            opacity: .5,
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // Chart area
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 6.h),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final chartW = constraints.maxWidth;
                            final chartH = constraints.maxHeight;
                            final plotH =
                                chartH - 40.h; // reserve bottom for labels

                            // Compute point positions
                            final points = List.generate(6, (i) {
                              const hPad = 16.0;
                              final x = hPad + (chartW - hPad * 2) * i / 5;
                              final y = yMax == 0
                                  ? plotH
                                  : plotH - (values[i] / yMax) * plotH;
                              return Offset(x, y);
                            });

                            return CustomPaint(
                              painter: _LineChartPainter(
                                points: points,
                                gridColor: AppColors.dynamic10,
                                lineColor: AppColors.primary,
                                dotColor: AppColors.primary,
                                lineCount: 4,
                                plotHeight: plotH,
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8.w),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: List.generate(6, (i) {
                                    final label = monthLabels[i];
                                    return SizedBox(
                                      height: 40.h,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(height: 10.h),
                                          RichText(
                                            text: TextSpan(
                                              text: label.label,
                                              style: TextStyles.smallRegular12(
                                                context,
                                                opacity: .6,
                                              ),
                                            ),
                                          ),
                                          if (label.year != null)
                                            RichText(
                                              text: TextSpan(
                                                text: label.year,
                                                style: TextStyles.cardRegular10(
                                                  context,
                                                  opacity: .4,
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                    );
                                  }),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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

class _LineChartPainter extends CustomPainter {
  final List<Offset> points;
  final Color gridColor;
  final Color lineColor;
  final Color dotColor;
  final int lineCount;
  final double plotHeight;

  _LineChartPainter({
    required this.points,
    required this.gridColor,
    required this.lineColor,
    required this.dotColor,
    required this.lineCount,
    required this.plotHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // --- Dashed grid lines ---
    final gridPaint = Paint()
      ..color = gridColor
      ..strokeWidth = 1;

    for (int i = 0; i <= lineCount; i++) {
      final y = plotHeight * (i / lineCount);
      double x = 0;
      const dashW = 6.0, dashGap = 4.0;
      while (x < size.width) {
        canvas.drawLine(Offset(x, y), Offset(x + dashW, y), gridPaint);
        x += dashW + dashGap;
      }
    }

    if (points.length < 2) return;

    // --- Line ---
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final path = Path()..moveTo(points.first.dx, points.first.dy);
    for (int i = 1; i < points.length; i++) {
      // Slight curve via cubicTo for smooth line
      final prev = points[i - 1];
      final curr = points[i];
      final cpX = (prev.dx + curr.dx) / 2;
      path.cubicTo(cpX, prev.dy, cpX, curr.dy, curr.dx, curr.dy);
    }
    canvas.drawPath(path, linePaint);

    // --- Dots ---
    final dotFill = Paint()
      ..color = dotColor
      ..style = PaintingStyle.fill;
    final dotStroke = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    for (final p in points) {
      canvas.drawCircle(p, 5, dotFill);
      canvas.drawCircle(p, 5, dotStroke);
    }
  }

  @override
  bool shouldRepaint(_LineChartPainter old) =>
      old.points != points || old.plotHeight != plotHeight;
}

class TopPerformers extends StatelessWidget {
  const TopPerformers({
    super.key,
    required this.users,
    required this.referrals,
  });

  final List<UsersModel> users;
  final List<ReferralModel> referrals;

  double _totalPaidForUser(String userId) {
    return referrals
        .where((r) {
          final isPaid =
              r.commissionStatus == CommissionStatus.paid ||
              r.enrollStatus == EnrollReferralStatus.paid;
          return isPaid && r.referer == userId;
        })
        .fold(
          0.0,
          (sum, r) => sum + (double.tryParse(r.expectedCommission) ?? 0),
        );
  }

  int _totalReferralsForUser(String userId) =>
      referrals.where((r) => r.referer == userId).length;

  int _totalConversionsForUser(String userId) => referrals
      .where((r) => r.referer == userId && r.enrollStatus.isConverted)
      .length;

  @override
  Widget build(BuildContext context) {
    // Filter users with totalPaid > 0, sort by totalPaid desc, take top 5
    final ranked =
        users
            .map((u) => (user: u, paid: _totalPaidForUser(u.id)))
            .where((e) => e.paid > 0)
            .toList()
          ..sort((a, b) => b.paid.compareTo(a.paid));

    final top = ranked.take(5).toList();

    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: surfaceColor(),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 1),
            color: AppColors.dynamic10,
            blurRadius: 5.r,
            spreadRadius: 2.r,
          ),
        ],
      ),
      child: Column(
        spacing: 16.h,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RichText(
            text: TextSpan(
              text: "Top Performers",
              style: TextStyles.normalRegular14(context),
            ),
          ),
          ...List.generate(top.length, (i) {
            final entry = top[i];
            final rank = i + 1;
            final refs = _totalReferralsForUser(entry.user.id);
            final convs = _totalConversionsForUser(entry.user.id);

            return Column(
              children: [
                if (i > 0) Divider(height: 1.h, color: AppColors.dynamic10),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  child: Row(
                    spacing: 12.w,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: 36.r,
                        height: 36.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _badgeBg(rank),
                        ),
                        child: Center(
                          child: RichText(
                            text: TextSpan(
                              text: '$rank',
                              style: TextStyles.normalSemibold14(
                                context,
                              ).copyWith(color: _badgeColor(rank)),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Column(
                          spacing: 4.h,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(
                                text: entry.user.fullName,
                                style: TextStyles.normalSemibold14(context),
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    '${formatAmount(refs)} referrals • ${formatAmount(convs)} conversions',
                                style: TextStyles.smallRegular12(
                                  context,
                                  opacity: .55,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: '£${formatAmount(entry.paid.toInt())}',
                          style: TextStyles.normalRegular14(
                            context,
                          ).copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),

          if (top.isEmpty)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: "No paid commissions yet",
                    style: TextStyles.smallRegular12(context, opacity: .5),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Color _badgeBg(int rank) {
    return switch (rank) {
      1 => AppColors.orange.withValues(alpha: .12),
      2 => AppColors.dynamic05,
      3 => AppColors.error.withValues(alpha: .10),
      _ => AppColors.dynamic05,
    };
  }

  Color _badgeColor(int rank) {
    return switch (rank) {
      1 => AppColors.orange,
      2 => AppColors.dynamic60,
      3 => AppColors.error,
      _ => AppColors.dynamic40,
    };
  }
}

class OverviewWidget extends StatelessWidget {
  const OverviewWidget({
    super.key,
    required this.filterType,
    required this.referrals,
    required this.users,
  });
  final String filterType;
  final List<ReferralModel> referrals;
  final List<UsersModel> users;

  DateTimeRange _currentRange() {
    final now = DateTime.now();
    return switch (filterType) {
      "Week" => DateTimeRange(
        start: now.subtract(const Duration(days: 7)),
        end: now,
      ),
      "Month" => DateTimeRange(
        start: DateTime(now.year, now.month - 1, now.day),
        end: now,
      ),
      "Year" => DateTimeRange(
        start: DateTime(now.year - 1, now.month, now.day),
        end: now,
      ),
      _ => DateTimeRange(start: now, end: now),
    };
  }

  DateTimeRange _previousRange() {
    final current = _currentRange();
    final duration = current.end.difference(current.start);
    return DateTimeRange(
      start: current.start.subtract(duration),
      end: current.start,
    );
  }

  bool _inDateRange(String isoDate, DateTimeRange range) {
    final date = DateTime.tryParse(isoDate);
    if (date == null) return false;
    return date.isAfter(range.start) && date.isBefore(range.end);
  }

  // Replace your old _inRange to use current range
  bool _inRange(String isoDate) => _inDateRange(isoDate, _currentRange());

  double _calcDelta(double current, double previous) {
    if (previous == 0) return current > 0 ? 100 : 0;
    return ((current - previous) / previous) * 100;
  }

  // Total Users
  int get totalUsers => users.where((u) => _inRange(u.createdAt)).length;

  int get _prevTotalUsers =>
      users.where((u) => _inDateRange(u.createdAt, _previousRange())).length;

  double get totalUsersDelta =>
      _calcDelta(totalUsers.toDouble(), _prevTotalUsers.toDouble());

  // Total Referrals
  int get totalReferrals =>
      referrals.where((r) => _inRange(r.createdAt)).length;

  int get _prevTotalReferrals => referrals
      .where((r) => _inDateRange(r.createdAt, _previousRange()))
      .length;

  double get totalReferralsDelta =>
      _calcDelta(totalReferrals.toDouble(), _prevTotalReferrals.toDouble());

  // Conversion Rate
  double _conversionRateForRange(DateTimeRange range) {
    final ranged = referrals.where((r) {
      final date = r.enrollModDate ?? r.updatedAt ?? r.createdAt;
      return _inDateRange(date, range);
    });
    if (ranged.isEmpty) return 0;
    final converted = ranged.where((r) => r.enrollStatus.isConverted).length;
    return converted / ranged.length * 100;
  }

  double get conversionRate => _conversionRateForRange(_currentRange());
  double get conversionRateDelta =>
      _calcDelta(conversionRate, _conversionRateForRange(_previousRange()));

  // Total Paid
  double _totalPaidForRange(DateTimeRange range) {
    return referrals
        .where((r) {
          final isPaid =
              r.commissionStatus == CommissionStatus.paid ||
              r.enrollStatus == EnrollReferralStatus.paid;
          if (!isPaid) return false;
          final date = r.enrollModDate ?? r.updatedAt ?? r.createdAt;
          return _inDateRange(date, range);
        })
        .fold(
          0.0,
          (sum, r) => sum + (double.tryParse(r.expectedCommission) ?? 0),
        );
  }

  double get totalPaid => _totalPaidForRange(_currentRange());
  double get totalPaidDelta =>
      _calcDelta(totalPaid, _totalPaidForRange(_previousRange()));

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12.h,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          spacing: 12.w,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: OverviewSubWidget(
                title: "Total users",
                value: formatAmount(totalUsers),
                icon: AssetsSvgIcons.userGroup,
                percentage: totalUsersDelta,
              ),
            ),
            Expanded(
              child: OverviewSubWidget(
                title: "Conversion Rate",
                value: "${conversionRate.toStringAsFixed(1)}%",
                icon: AssetsSvgIcons.rise,
                percentage: conversionRateDelta,
              ),
            ),
          ],
        ),
        Row(
          spacing: 12.w,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: OverviewSubWidget(
                title: "Total Referrals",
                value: formatAmount(totalReferrals),
                icon: AssetsSvgIcons.stickyNote,
                percentage: totalReferralsDelta,
              ),
            ),
            Expanded(
              child: OverviewSubWidget(
                title: "Total Paid",
                value: "£${formatAmount(totalPaid.toInt())}",
                icon: AssetsSvgIcons.pound,
                percentage: totalPaidDelta,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class OverviewSubWidget extends StatelessWidget {
  const OverviewSubWidget({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    required this.percentage,
  });

  final String title;
  final String value;
  final String icon;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    bool isNegative = percentage < 0;
    bool isPositive = percentage > 0;
    final percentageAbs = percentage.abs();
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: surfaceColor(),
        borderRadius: BorderRadius.circular(14.r),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            color: AppColors.dynamic10,
            blurRadius: 5.r,
            spreadRadius: 2.r,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 12.w,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 40.r,
                width: 40.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.dynamic05,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    icon,
                    width: 20.w,
                    height: 20.h,
                    colorFilter: ColorFilter.mode(
                      AppColors.white,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 10.w),
                decoration: BoxDecoration(
                  color: isPositive
                      ? AppColors.green5
                      : isNegative
                      ? AppColors.error5
                      : AppColors.dynamic05,
                  borderRadius: BorderRadius.circular(16.r),
                ),
                child: RichText(
                  text: TextSpan(
                    text:
                        "${isPositive
                            ? "+"
                            : isNegative
                            ? "-"
                            : ""}${percentageAbs.floor()}%",
                    style: TextStyles.cardRegular10(context).copyWith(
                      color: isPositive
                          ? AppColors.green
                          : isNegative
                          ? AppColors.error
                          : AppColors.dynamic,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          RichText(
            text: TextSpan(
              text: value,
              style: TextStyles.titleSemiBold20(context),
            ),
          ),
          SizedBox(height: 4.h),
          RichText(
            text: TextSpan(
              text: title,
              style: TextStyles.smallRegular12(context, opacity: .75),
            ),
          ),
        ],
      ),
    );
  }
}

PopupMenuItem<String> _buildPopupMenuItem(
  BuildContext context, {
  required String value,
  required String text,
  bool? selected,
  Color? color,
  Widget? icon,
}) {
  return PopupMenuItem<String>(
    height: 26.h,
    padding: EdgeInsets.zero,
    value: value,
    child: Container(
      width: 250.w,
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: selected == true ? AppColors.dynamic10 : null,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        spacing: 4.w,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ?icon,
          RichText(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            text: TextSpan(
              text: text,
              style: TextStyles.normalRegular14(context).copyWith(
                color:
                    color ??
                    (selected == true
                        ? AppColors.dynamic70
                        : AppColors.dynamic50),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
