import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';

class SessionManager {
  SessionManager._();
  static final SessionManager instance = SessionManager._();

  static const _idleDuration = Duration(minutes: 1);
  static const _warningCountdown = Duration(seconds: 15);

  Timer? _idleTimer;
  Timer? _warningTimer;

  bool _isActive = false;
  bool get isActive => _isActive;

  int _loadingCount = 0;
  DateTime? _backgroundedAt;

  bool _hasObserver = false;
  bool get hasObserver => _hasObserver;

  VoidCallback? _onShowWarning;
  VoidCallback? _onTimeout;

  void start({
    required VoidCallback onShowWarning,
    required VoidCallback onTimeout,
  }) {
    log('[SESSION] start() called — resetting and starting idle timer');
    _onShowWarning = onShowWarning;
    _onTimeout = onTimeout;
    _isActive = true;
    _loadingCount = 0;
    _hasObserver = true;
    _scheduleIdleTimer();
  }

  void notifyLoading(bool isLoading) {
    if (!_isActive) {
      log('[SESSION] notifyLoading($isLoading) ignored — session not active');
      return;
    }
    if (isLoading) {
      _loadingCount++;
      log(
        '[SESSION] notifyLoading(true) — loadingCount=$_loadingCount, timers PAUSED',
      );
      _cancelTimers();
    } else {
      _loadingCount = (_loadingCount - 1).clamp(0, 9999);
      log('[SESSION] notifyLoading(false) — loadingCount=$_loadingCount');
      if (_loadingCount == 0) {
        log('[SESSION] All loading done — resuming idle timer');
        _scheduleIdleTimer();
      }
    }
  }

  void reset() {
    if (!_isActive) {
      log('[SESSION] reset() ignored — session not active');
      return;
    }
    if (_loadingCount > 0) {
      log('[SESSION] reset() ignored — loadingCount=$_loadingCount');
      return;
    }
    _cancelTimers();
    _scheduleIdleTimer();
  }

  void onBackground() {
    if (!_isActive) return;
    _backgroundedAt = DateTime.now();
    log('[SESSION] onBackground() — timestamp saved, timers cancelled');
    _cancelTimers();
  }

  bool onResume() {
    if (!_isActive) {
      log('[SESSION] onResume() — session not active, returning false');
      return false;
    }
    if (_backgroundedAt != null) {
      final away = DateTime.now().difference(_backgroundedAt!);
      log(
        '[SESSION] onResume() — was away for ${away.inSeconds}s (limit=${_idleDuration.inSeconds}s)',
      );
      _backgroundedAt = null;
      if (away >= _idleDuration) {
        log('[SESSION] onResume() — EXPIRED, disposing and returning true');
        dispose();
        return true;
      }
    }
    log('[SESSION] onResume() — not expired, restarting idle timer');
    _scheduleIdleTimer();
    return false;
  }

  void dispose() {
    log('[SESSION] dispose() called — isActive=$_isActive, stack trace below');
    log(
      '[SESSION] dispose() — idleTimer active: ${_idleTimer != null}, warningTimer active: ${_warningTimer != null}',
    );
    _cancelTimers();
    _isActive = false;
    _loadingCount = 0;
    _backgroundedAt = null;
    _onShowWarning = null;
    _onTimeout = null;
    _hasObserver = false;
    log('[SESSION] dispose() — done, session is now inactive');
  }

  void _scheduleIdleTimer() {
    _cancelTimers();
    if (!_isActive) {
      log('[SESSION] _scheduleIdleTimer() — skipped, not active');
      return;
    }
    log(
      '[SESSION] _scheduleIdleTimer() — idle timer set for ${_idleDuration.inSeconds}s',
    );
    _idleTimer = Timer(_idleDuration, _onIdle);
  }

  void _onIdle() {
    log(
      '[SESSION] _onIdle() fired — isActive=$_isActive, loadingCount=$_loadingCount',
    );
    if (!_isActive || _loadingCount > 0) {
      log('[SESSION] _onIdle() — rescheduling because loading is active');
      _scheduleIdleTimer();
      return;
    }
    log(
      '[SESSION] _onIdle() — calling _onShowWarning, onShowWarning is ${_onShowWarning == null ? "NULL ⚠️" : "set ✓"}',
    );
    _onShowWarning?.call();
    log(
      '[SESSION] _onIdle() — starting warning countdown for ${_warningCountdown.inSeconds}s',
    );
    _warningTimer = Timer(_warningCountdown, _onWarningExpired);
    log('[SESSION] _onIdle() — warningTimer created: ${_warningTimer != null}');
  }

  void _onWarningExpired() {
    log('[SESSION] _onWarningExpired() fired — isActive=$_isActive');
    log(
      '[SESSION] _onWarningExpired() — onTimeout is ${_onTimeout == null ? "NULL ⚠️ — this is the bug!" : "set ✓"}',
    );
    if (!_isActive) {
      log('[SESSION] _onWarningExpired() — skipped, session already disposed');
      return;
    }
    final callback = _onTimeout;
    dispose();
    log('[SESSION] _onWarningExpired() — calling onTimeout callback');
    callback?.call();
    log('[SESSION] _onWarningExpired() — done');
  }

  void _cancelTimers() {
    final hadIdle = _idleTimer != null;
    final hadWarning = _warningTimer != null;
    _idleTimer?.cancel();
    _idleTimer = null;
    _warningTimer?.cancel();
    _warningTimer = null;
    if (hadIdle || hadWarning) {
      log(
        '[SESSION] _cancelTimers() — cancelled: idle=$hadIdle, warning=$hadWarning',
      );
    }
  }

  void reattach({
    required VoidCallback onShowWarning,
    required VoidCallback onTimeout,
  }) {
    if (!_isActive) {
      log('[SESSION] reattach() — ignored, session not active');
      return;
    }
    log('[SESSION] reattach() — new observer attached');
    _onShowWarning = onShowWarning;
    _onTimeout = onTimeout;
    _hasObserver = true;
  }

  void clearObserver() {
    log('[SESSION] clearObserver() — observer removed, hasObserver=false');
    _hasObserver = false;
  }
}
