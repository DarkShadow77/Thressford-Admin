import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StillThereDialog extends StatefulWidget {
  const StillThereDialog({super.key, required this.onConfirm});
  final VoidCallback onConfirm;

  @override
  State<StillThereDialog> createState() => _StillThereDialogState();
}

class _StillThereDialogState extends State<StillThereDialog> {
  // Mirror the same countdown used in SessionManager so the UI is accurate.
  static const _totalSeconds = 15;
  int _secondsLeft = _totalSeconds;
  late final _ticker = Stream.periodic(
    const Duration(seconds: 1),
    (i) => _totalSeconds - i - 1,
  ).take(_totalSeconds);

  @override
  void initState() {
    super.initState();
    _ticker.listen((s) {
      if (mounted) setState(() => _secondsLeft = s);
    });
  }

  @override
  Widget build(BuildContext context) {
    final progress = _secondsLeft / _totalSeconds;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Padding(
        padding: EdgeInsets.all(24.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Countdown ring
            SizedBox(
              width: 72.r,
              height: 72.r,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 5.r,
                    backgroundColor: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    valueColor: AlwaysStoppedAnimation(
                      _secondsLeft > 5
                          ? Theme.of(context).colorScheme.primary
                          : Colors.orange,
                    ),
                  ),
                  Text(
                    '$_secondsLeft',
                    style: TextStyle(
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Still there?',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Text(
              'You\'ve been inactive for a while. '
              'You\'ll be signed out automatically.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: .6),
              ),
            ),
            SizedBox(height: 24.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: widget.onConfirm,
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Yes, I\'m here',
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
