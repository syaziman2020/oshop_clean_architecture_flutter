import 'package:get/get.dart';
import 'package:oshop_coderay/features/home/presentation/pages/see_all_page.dart';
import '../bindings/home_b.dart';
import 'home_routes.dart';
import '../pages/dashboard_page.dart';

import '../../../auth/presentation/bindings/auth_b.dart';

class HomeNavigation {
  static final routes = [
    GetPage(
      name: HomeRoutes.dashboard,
      page: () => DashboardPage(
        currentTab: 0,
      ),
      bindings: [AuthB(), HomeB()],
    ),
  ];
}
