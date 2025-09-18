import 'package:dartway_router/dartway_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'dw_router_state.g.dart';

@riverpod
class DwRouterState extends _$DwRouterState {
  @override
  GoRouter build(DwRouterConfig config) {
    final redirects = config.redirectsProvider != null
        ? ref.watch(config.redirectsProvider!)
        : null;

    // Create a config with redirects applied
    final configWithRedirects = config.withRedirects(redirects);

    return configWithRedirects.build();
  }
}
