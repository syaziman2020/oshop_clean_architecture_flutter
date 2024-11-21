import '../../features/auth/presentation/navigation/auth_navigation.dart';
import '../../features/home/presentation/navigation/home_navigation.dart';

class AppNavigations {
  static final pages = [
    ...AuthNavigation.routes,
    ...HomeNavigation.routes,
  ];
}
