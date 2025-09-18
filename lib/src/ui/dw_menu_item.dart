import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dartway_router/dartway_router.dart';

/// A menu item for bottom navigation bar.
///
/// Provides different factory constructors for creating menu items with
/// Material icons, SVG icons, or custom actions. Supports badges for
/// notifications and custom widgets.
///
/// Example:
/// ```dart
/// DwMenuItem.icon(
///   route: AppRoutes.home,
///   displayTitle: 'Home',
///   iconData: Icons.home,
///   activeIconData: Icons.home_filled,
///   badge: NotificationBadge(notificationProvider: messageCountProvider),
/// )
/// ```
class DwMenuItem {
  const DwMenuItem._({
    required this.route,
    required this.displayTitle,
    this.iconData,
    this.activeIconData,
    this.svgIcon,
    this.activeSvgIcon,
    this.customOnPressed,
    this.changeIconColor = true,
    this.badge,
  });

  /// Create a menu item with Material Design icon
  factory DwMenuItem.icon({
    required NavigationZoneRoute route,
    required String displayTitle,
    required IconData iconData,
    IconData? activeIconData,
    Function(WidgetRef)? customOnPressed,
    Widget? badge,
  }) {
    return DwMenuItem._(
      route: route,
      displayTitle: displayTitle,
      iconData: iconData,
      activeIconData: activeIconData,
      customOnPressed: customOnPressed,
      changeIconColor: false,
      badge: badge,
    );
  }

  /// Create a menu item with SVG icon
  factory DwMenuItem.svg({
    required NavigationZoneRoute route,
    required String displayTitle,
    required String svgIcon,
    String? activeSvgIcon,
    Function(WidgetRef)? customOnPressed,
    bool changeIconColor = true,
    Widget? badge,
  }) {
    return DwMenuItem._(
      route: route,
      displayTitle: displayTitle,
      svgIcon: svgIcon,
      activeSvgIcon: activeSvgIcon,
      customOnPressed: customOnPressed,
      changeIconColor: changeIconColor,
      badge: badge,
    );
  }

  /// Create a custom menu item with no route (for custom actions)
  factory DwMenuItem.custom({
    required String displayTitle,
    required IconData iconData,
    required Function(WidgetRef) onPressed,
    Widget? badge,
  }) {
    return DwMenuItem._(
      route: null,
      displayTitle: displayTitle,
      iconData: iconData,
      customOnPressed: onPressed,
      changeIconColor: false,
      badge: badge,
    );
  }

  final NavigationZoneRoute? route;
  final String displayTitle;
  final IconData? iconData;
  final String? svgIcon;
  final IconData? activeIconData;
  final String? activeSvgIcon;
  final Function(WidgetRef)? customOnPressed;
  final bool changeIconColor;
  final Widget? badge;
}
