import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'INI DASHBOARD',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
