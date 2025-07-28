import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'admin_dashboard_screen.dart';
import 'user_dashboard_screen.dart';
import 'login_screen.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthService>(
      builder: (context, authService, child) {
        // Show login screen if not authenticated
        if (!authService.isLoggedIn) {
          return const LoginScreen();
        }

        // Show appropriate dashboard based on admin status
        if (authService.isAdmin) {
          return const AdminDashboardScreen();
        } else {
          return const UserDashboardScreen();
        }
      },
    );
  }
}
