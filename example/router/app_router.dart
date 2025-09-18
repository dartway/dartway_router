// Define your navigation parameters as a separate enum
import 'package:dartway_router/dartway_router.dart';

import '../pages/home_page.dart';
import '../pages/profile_page.dart';
import '../pages/settings_page.dart';
import '../pages/user_detail_page.dart';

part 'zones/app_routes.dart';

enum AppParams with NavigationParamsMixin<int> {
  userId;
}

final appRouterProvider = dwRouterStateProvider(
    DwRouter.config().addNavigationZones(AppNavigationZone.values));
