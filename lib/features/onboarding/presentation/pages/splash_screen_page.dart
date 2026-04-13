import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:thressford_admin/features/auth/presentation/pages/login_page.dart';

import '../../../../app/view/widgets/thessford_icon.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/utils/helpers.dart';

class SplashScreenPage extends StatefulWidget {
  const SplashScreenPage({super.key});

  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  /*Widget nextScreen() {
    final hasProfile = context.read<ProfileBloc>().state is ProfileSuccessState;
    if (hasProfile) {
      return const WelcomeBackPage();
    } else {
      return const OnboardingPage();
    }
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: surfaceColor(),
      body: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: AnimatedSplashScreen(
          splash: Splash(),
          splashIconSize: double.infinity,
          duration: 10000,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          animationDuration: Duration(milliseconds: 600),
          pageTransitionType: PageTransitionType.bottomToTop,
          splashTransition: SplashTransition.fadeTransition,
          nextScreen: const LoginPage(),
        ),
      ),
    );
  }
}

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _scale;
  late Animation<double> _textOpacity;

  @override
  void initState() {
    super.initState();

    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..forward();

    _scale = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 20),
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeInOut)),
        weight: 10,
      ),
      TweenSequenceItem(tween: ConstantTween(1.0), weight: 50),
    ]).animate(_ctrl);

    _textOpacity = TweenSequence([
      TweenSequenceItem(tween: ConstantTween(0.0), weight: 30),
      // t=2.4–4.0s: slide from under the logo → fully visible to the right
      TweenSequenceItem(
        tween: Tween(
          begin: 0.0,
          end: 1.0,
        ).chain(CurveTween(curve: Curves.easeOut)),
        weight: 10,
      ),
    ]).animate(_ctrl);
  }

  @override
  dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.navyBlue,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            FadeTransition(
              opacity: _textOpacity,
              child: Container(
                width: 80.w,
                height: 80.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14.r),
                  color: AppColors.primary,
                ),
              ),
            ),
            Center(
              child: ScaleTransition(
                scale: _scale,
                child: ThessfordIcon(iconColor: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
