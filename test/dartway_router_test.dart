import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dartway_router/dartway_router.dart';

void main() {
  group('DwRouter', () {
    test('should create router with valid navigation zones', () {
      expect(() {
        DwRouter.config().addNavigationZones(TestRoutes.values).build();
      }, returnsNormally);
    });

    test('should throw error with empty navigation zones', () {
      expect(() {
        DwRouter.config().build();
      }, throwsArgumentError);
    });

    test('should throw error with empty zone in navigation zones', () {
      expect(() {
        DwRouter.config().addNavigationZones([]).build();
      }, throwsArgumentError);
    });

    test('should validate duplicate route paths', () {
      expect(() {
        DwRouter.config()
            .addNavigationZones(DuplicateTestRoutes.values)
            .build();
      }, throwsArgumentError);
    });

    test('should configure skipZoneInRouteNames correctly', () {
      DwRouter.configure(skipZoneInRouteNames: false);
      expect(DwRouter.skipZoneInRouteNames, isFalse);

      DwRouter.configure(skipZoneInRouteNames: true);
      expect(DwRouter.skipZoneInRouteNames, isTrue);
    });
  });

  group('DwRouterConfig', () {
    test('should validate empty navigation zones', () {
      final config = DwRouterConfig();
      expect(() => config.build(), throwsArgumentError);
    });

    test('should validate initial location format', () {
      expect(() {
        DwRouter.config()
            .addNavigationZones(TestRoutes.values)
            .setInitialLocation('invalid-location')
            .build();
      }, throwsArgumentError);
    });

    test('should validate initial location matches route', () {
      expect(() {
        DwRouter.config()
            .addNavigationZones(TestRoutes.values)
            .setInitialLocation('/nonexistent')
            .build();
      }, throwsArgumentError);
    });

    test('should build router with valid configuration', () {
      final router = DwRouter.config()
          .addNavigationZones(TestRoutes.values)
          .setNotFoundPage(const TestPage('Not Found'))
          .setInitialLocation('/home')
          .build();

      expect(router, isA<GoRouter>());
    });

    test('should support builder pattern chaining', () {
      final config = DwRouter.config()
          .addNavigationZones(TestRoutes.values)
          .setNotFoundPage(const TestPage('Not Found'))
          .setInitialLocation('/home');

      expect(config, isA<DwRouterConfig>());
      expect(() => config.build(), returnsNormally);
    });
  });

  group('NavigationParamsMixin', () {
    test('should parse int values correctly', () {
      final params = {'id': '123'};
      final value = TestRoutes.userDetail.get(params);
      expect(value, equals(123));
    });

    test('should parse string values correctly', () {
      final params = {'name': 'John'};
      final value = TestStringRoutes.userName.get(params);
      expect(value, equals('John'));
    });

    test('should parse double values correctly', () {
      final params = {'price': '19.99'};
      final value = TestDoubleRoutes.price.get(params);
      expect(value, equals(19.99));
    });

    test('should parse bool values correctly', () {
      final params = {'enabled': 'true'};
      final value = TestBoolRoutes.enabled.get(params);
      expect(value, equals(true));
    });

    test('should return null for missing parameters', () {
      final params = <String, String>{};
      final value = TestRoutes.userDetail.get(params);
      expect(value, isNull);
    });

    test('should return default value', () {
      final params = <String, String>{};
      final value = TestRoutes.userDetail.getOrDefault(params, 0);
      expect(value, equals(0));
    });

    test('should throw FormatException for invalid int values', () {
      final params = {'id': 'invalid'};
      expect(() => TestRoutes.userDetail.get(params), throwsFormatException);
    });

    test('should throw FormatException for invalid double values', () {
      final params = {'price': 'invalid'};
      expect(() => TestDoubleRoutes.price.get(params), throwsFormatException);
    });

    test('should return default value on parse error with getOrDefault', () {
      final params = {'id': 'invalid'};
      final value = TestRoutes.userDetail.getOrDefault(params, 0);
      expect(value, equals(0));
    });

    test('should set parameter values correctly', () {
      final result = TestRoutes.userDetail.set(123);
      expect(result, equals({'userDetail': '123'}));
    });
  });

  group('NavigationZoneRouteExtension', () {
    test('should return simple name when skipZoneInRouteNames is true', () {
      DwRouter.configure(skipZoneInRouteNames: true);
      expect(TestRoutes.home.name, equals('home'));
    });

    test('should return full name when skipZoneInRouteNames is false', () {
      DwRouter.configure(skipZoneInRouteNames: false);
      expect(TestRoutes.home.name, equals('TestRoutes.home'));
    });

    test('should generate correct route path', () {
      expect(TestRoutes.home.routePath, equals('/home'));
      expect(TestRoutes.profile.routePath, equals('/profile'));
    });

    test('should generate correct full path', () {
      expect(TestRoutes.home.fullPath, equals('/home'));
      expect(TestRoutes.userDetail.fullPath, equals('/user/:userDetail'));
    });
  });
}

// Test route enums
enum TestRoutes with NavigationParamsMixin<int> implements NavigationZoneRoute {
  home,
  profile,
  userDetail;

  @override
  String get root => '';

  @override
  NavigationRouteDescriptor get descriptor {
    switch (this) {
      case TestRoutes.home:
        return SimpleNavigationRouteDescriptor(page: const TestPage('Home'));
      case TestRoutes.profile:
        return SimpleNavigationRouteDescriptor(page: const TestPage('Profile'));
      case TestRoutes.userDetail:
        return ParameterizedNavigationRouteDescriptor(
          page: const TestPage('User Detail'),
          parameter: this,
        );
    }
  }
}

enum TestStringRoutes
    with NavigationParamsMixin<String>
    implements NavigationZoneRoute {
  userName;

  @override
  String get root => '';

  @override
  NavigationRouteDescriptor get descriptor {
    switch (this) {
      case TestStringRoutes.userName:
        return ParameterizedNavigationRouteDescriptor(
          page: const TestPage('User Name'),
          parameter: this,
        );
    }
  }
}

enum TestDoubleRoutes
    with NavigationParamsMixin<double>
    implements NavigationZoneRoute {
  price;

  @override
  String get root => '';

  @override
  NavigationRouteDescriptor get descriptor {
    switch (this) {
      case TestDoubleRoutes.price:
        return ParameterizedNavigationRouteDescriptor(
          page: const TestPage('Price'),
          parameter: this,
        );
    }
  }
}

enum TestBoolRoutes
    with NavigationParamsMixin<bool>
    implements NavigationZoneRoute {
  enabled;

  @override
  String get root => '';

  @override
  NavigationRouteDescriptor get descriptor {
    switch (this) {
      case TestBoolRoutes.enabled:
        return ParameterizedNavigationRouteDescriptor(
          page: const TestPage('Enabled'),
          parameter: this,
        );
    }
  }
}

enum DuplicateTestRoutes
    with NavigationParamsMixin<int>
    implements NavigationZoneRoute {
  home1,
  home2;

  @override
  String get root => '';

  @override
  NavigationRouteDescriptor get descriptor {
    switch (this) {
      case DuplicateTestRoutes.home1:
      case DuplicateTestRoutes.home2:
        return SimpleNavigationRouteDescriptor(page: const TestPage('Home'));
    }
  }
}

class TestPage extends StatelessWidget {
  const TestPage(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(child: Text(title)),
    );
  }
}
