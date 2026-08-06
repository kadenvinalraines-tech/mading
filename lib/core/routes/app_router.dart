import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/approval/presentation/pages/approval_dashboard_page.dart';
import '../../features/content_slider/presentation/pages/slider_management_page.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/login',
        name: 'login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const Placeholder(),
      ),
      GoRoute(
        path: '/approval',
        name: 'approval',
        builder: (context, state) => const ApprovalDashboardPage(),
      ),
      GoRoute(
        path: '/slider-management',
        name: 'slider-management',
        builder: (context, state) => const SliderManagementPage(),
      ),
    ],
  );
}
