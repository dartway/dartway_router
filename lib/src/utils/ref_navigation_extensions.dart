import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../ui/dw_menu_item.dart';
import '../core/navigation_params/navigation_parameters_providers.dart';
import '../core/navigation_params/navigation_params_mixin.dart';

extension WidgetRefNavigationExtension on WidgetRef {
  T? watchNavigationParam<T>(NavigationParamsMixin<T> param) => param.get(
        watch(navigationPathParametersProvider),
      );

  T? readNavigationParam<T>(NavigationParamsMixin<T> param) => param.get(
        read(navigationPathParametersProvider),
      );

  menuItemTap(
    DwMenuItem item, {
    Map<String, String>? pathParameters,
  }) {
    if (item.customOnPressed != null) {
      item.customOnPressed!(this);
    } else if (item.route != null) {
      context.goNamed(
        item.route!.name,
        pathParameters: pathParameters ?? {},
      );
    }
  }
}

extension RefNavigationExtension on Ref {
  T? watchNavigationParam<T>(NavigationParamsMixin<T> param) => param.get(
        watch(navigationPathParametersProvider),
      );

  T? readNavigationParam<T>(NavigationParamsMixin<T> param) => param.get(
        read(navigationPathParametersProvider),
      );
}
