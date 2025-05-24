import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lifesphere_essentials/core/constants/route_names.dart';
import 'package:lifesphere_essentials/core/utils/transition_animation.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/presentation/screens/login/login_screen.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/presentation/screens/login_or_signup.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/presentation/screens/signup/signup_screen.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/auth/presentation/screens/splash_screen.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/categories/presentation/screens/categories_screen.dart';
import 'package:lifesphere_essentials/modules/budgeting_app/features/dashboard/presentation/screens/dashboard_screen.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      path: RouteNames.loginOrSignup,
      pageBuilder:
          (context, state) => RouterTransitionFactory.getTransitionPage(
            context: context,
            state: state,
            child: const LoginOrSignUpScreen(),
            type: 'slide-right-to-left',
          ),
    ),
    GoRoute(
      path: RouteNames.loginScreen,
      pageBuilder:
          (context, state) => RouterTransitionFactory.getTransitionPage(
            context: context,
            state: state,
            child: const LoginScreen(),
            type: 'slide-right-to-left',
          ),
    ),
    GoRoute(
      path: RouteNames.signupScreen,
      pageBuilder:
          (context, state) => RouterTransitionFactory.getTransitionPage(
            context: context,
            state: state,
            child: const SignupScreen(),
            type: 'slide-right-to-left',
          ),
    ),
    GoRoute(
      path: RouteNames.dashboardScreen,
      pageBuilder:
          (context, state) => RouterTransitionFactory.getTransitionPage(
            context: context,
            state: state,
            child: const DashboardScreen(),
            type: 'slide-right-to-left',
          ),
    ),
    GoRoute(
      path: RouteNames.categoriesScreen,
      pageBuilder:
          (context, state) => RouterTransitionFactory.getTransitionPage(
            context: context,
            state: state,
            child: const CategoriesScreen(),
            type: 'slide-right-to-left',
          ),
    ),
  ],
);
