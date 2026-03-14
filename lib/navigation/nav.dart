import 'package:after_call/screens/auth_page.dart';
import 'package:after_call/screens/edit_summary_screen.dart';
import 'package:after_call/screens/home_page.dart';
import 'package:after_call/screens/onboarding_page.dart';
import 'package:after_call/screens/processing_screen.dart';
import 'package:after_call/screens/record_screen.dart';
import 'package:after_call/screens/summary_screen.dart';
import 'package:after_call/sevices/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppRouter {
  static GoRouter createRouter(AuthService authService) {
    return GoRouter(
      initialLocation: AppRoutes.home,
      redirect: (context, state) {
        final isAuthenticated = authService.isAuthenticated;
        final isOnboarding = state.matchedLocation == AppRoutes.onboarding;
        final isAuth = state.matchedLocation == AppRoutes.auth;

        if (!isAuthenticated && !isOnboarding && !isAuth) {
          return AppRoutes.onboarding;
        }
        return null;
      },
      routes: [
        GoRoute(
          path: AppRoutes.onboarding,
          name: 'onboarding',
          pageBuilder:
              (context, state) => _transitionPage(const OnboardingPage()),
        ),
        GoRoute(
          path: AppRoutes.auth,
          name: 'auth',
          pageBuilder: (context, state) => _transitionPage(const AuthPage()),
        ),
        GoRoute(
          path: AppRoutes.home,
          name: 'home',
          pageBuilder: (context, state) => _transitionPage(const HomePage()),
        ),
        GoRoute(
          path: AppRoutes.record,
          name: 'record',
          pageBuilder:
              (context, state) => _transitionPage(const RecordScreen()),
        ),
        GoRoute(
          path: AppRoutes.processing,
          name: 'processing',
          pageBuilder: (context, state) {
            final audioPath = state.extra as String;
            return _transitionPage(ProcessingScreen(audioPath: audioPath));
          },
        ),
        GoRoute(
          path: AppRoutes.summary,
          name: 'summary',
          pageBuilder: (context, state) {
            final recordId = state.pathParameters['id']!;
            return _transitionPage(SummaryScreen(recordId: recordId));
          },
        ),

        GoRoute(
          path: AppRoutes.editSummary,
          name: 'edit-summary',
          pageBuilder: (context, state) {
            final recordId = state.pathParameters['id']!;
            return _transitionPage(EditSummaryScreen(recordId: recordId));
          },
        ),
      ],
    );
  }

  static CustomTransitionPage _transitionPage(Widget child) =>
      CustomTransitionPage(
        child: child,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final fade = CurvedAnimation(
            parent: animation,
            curve: Curves.easeOutCubic,
          );
          final offsetTween = Tween<Offset>(
            begin: const Offset(0, 0.02),
            end: Offset.zero,
          ).chain(CurveTween(curve: Curves.easeOutCubic));
          return FadeTransition(
            opacity: fade,
            child: SlideTransition(
              position: animation.drive(offsetTween),
              child: child,
            ),
          );
        },
        transitionDuration: const Duration(milliseconds: 260),
      );
}

class AppRoutes {
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String home = '/';
  static const String record = '/record';
  static const String processing = '/processing';
  static const String summary = '/summary/:id';
  static const String editSummary = '/edit-summary/:id';
}
