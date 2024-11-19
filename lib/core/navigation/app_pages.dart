import 'package:get/get.dart';
import 'package:oshop_coderay/features/auth/presentation/bindings/auth_b.dart';
import '../../features/auth/presentation/navigation/auth_pages.dart';
import '../../features/home/presentation/pages/dashboard_page.dart';

class AppPages {
  static final pages = [
    ...AuthPages.routes,
    GetPage(name: '/dashboard', page: () => DashboardPage(), bindings: [
      AuthB(),
    ]),
  ];
}
