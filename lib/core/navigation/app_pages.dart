import 'package:get/get.dart';
import 'package:oshop_coderay/features/auth/presentation/navigation/auth_pages.dart';
import 'package:oshop_coderay/features/home/presentation/pages/dashboard_page.dart';

class AppPages {
  static final pages = [
    ...AuthPages.routes,
    GetPage(
      name: '/dashboard',
      page: () => DashboardPage(),
    ),
  ];
}
