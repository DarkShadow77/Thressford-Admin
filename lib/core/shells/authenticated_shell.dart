import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../../app/view/widgets/dialog/still_there_dialog.dart';
import '../constants/navigators/route_name.dart';
import '../session/session_manager.dart';

class AuthenticatedShell extends StatefulWidget {
  const AuthenticatedShell({super.key, required this.child});
  final Widget child;

  @override
  State<AuthenticatedShell> createState() => _AuthenticatedShellState();
}

class _AuthenticatedShellState extends State<AuthenticatedShell>
    with WidgetsBindingObserver {
  bool _isOwner = false;
  bool _dialogOpen = false;

  @override
  void initState() {
    super.initState();
    if (!SessionManager.instance.isActive) {
      _becomeOwner();
      SessionManager.instance.start(
        onShowWarning: _showWarningDialog,
        onTimeout: () {
          Logger().w("TimeOut");
          log("TimeOut");
          _navigateToLogin();
        },
      );
    } else if (!SessionManager.instance.hasObserver) {
      _becomeOwner();
      SessionManager.instance.reattach(
        onShowWarning: _showWarningDialog,
        onTimeout: () {
          Logger().w("TimeOut");
          log("TimeOut");
          _navigateToLogin();
        },
      );
    }
  }

  void _becomeOwner() {
    _isOwner = true;
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    if (_isOwner) {
      WidgetsBinding.instance.removeObserver(this);
      SessionManager.instance.clearObserver();
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_isOwner) return;
    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        SessionManager.instance.onBackground();
        break;
      case AppLifecycleState.resumed:
        final expired = SessionManager.instance.onResume();
        Logger().w("Resumed");
        log("Resumed");
        if (expired && mounted) _navigateToLogin();
        break;
      default:
        break;
    }
  }

  void _showWarningDialog() {
    if (!mounted || _dialogOpen) return;
    _dialogOpen = true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => StillThereDialog(
        onConfirm: () {
          _dialogOpen = false;
          Navigator.of(ctx).pop();
          SessionManager.instance.reset();
        },
      ),
    ).whenComplete(() => _dialogOpen = false);
  }

  void _navigateToLogin() {
    Logger().w("Navigating to Login");
    log("Navigating to Login");
    if (!mounted) return;
    _dialogOpen = false;
    // Use the navigator key's current context to close dialog + navigate
    // regardless of what's on top of the stack
    final navigator = Navigator.of(context, rootNavigator: true);
    navigator.popUntil((route) => route.isFirst);
    navigator.pushNamedAndRemoveUntil(RouteName.loginPage, (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (_) => SessionManager.instance.reset(),
      onPointerMove: (_) => SessionManager.instance.reset(),
      child: widget.child,
    );
  }
}
