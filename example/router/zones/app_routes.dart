part of '../app_router.dart';

enum AppNavigationZone implements NavigationZoneRoute {
  home(SimpleNavigationRouteDescriptor(page: HomePage())),
  profile(SimpleNavigationRouteDescriptor(page: ProfilePage())),
  settings(SimpleNavigationRouteDescriptor(page: SettingsPage())),
  userDetail(ParameterizedNavigationRouteDescriptor(
    page: UserDetailPage(),
    parameter: AppParams.userId,
  ));

  const AppNavigationZone(this.descriptor);

  @override
  final NavigationRouteDescriptor descriptor;

  @override
  String get root => '';
}
