// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    ArmoireDeploiementFormRoute.name: (routeData) {
      final args = routeData.argsAs<ArmoireDeploiementFormRouteArgs>();
      return AutoRoutePage<void>(
        routeData: routeData,
        child: WrappedRoute(
            child: ArmoireDeploiementFormScreen(
          key: args.key,
          missionResponse: args.missionResponse,
          qrCode: args.qrCode,
          photo: args.photo,
          source: args.source,
          meter: args.meter,
        )),
      );
    },
    CompteurDeploiementFormRoute.name: (routeData) {
      final args = routeData.argsAs<CompteurDeploiementFormRouteArgs>();
      return AutoRoutePage<void>(
        routeData: routeData,
        child: WrappedRoute(
            child: CompteurDeploiementFormScreen(
          key: args.key,
          missionResponse: args.missionResponse,
          qrCode: args.qrCode,
          photo: args.photo,
          source: args.source,
        )),
      );
    },
    EquipementRoute.name: (routeData) {
      final args = routeData.argsAs<EquipementRouteArgs>();
      return AutoRoutePage<void>(
        routeData: routeData,
        child: WrappedRoute(
            child: EquipementScreen(
          key: args.key,
          mission: args.mission,
          source: args.source,
        )),
      );
    },
    EquipmentDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<EquipmentDetailsRouteArgs>(
          orElse: () => const EquipmentDetailsRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: EquipmentDetailsScreen(
          key: args.key,
          cabinet: args.cabinet,
          meter: args.meter,
          streetLight: args.streetLight,
          source: args.source,
          mission: args.mission,
          networkLabel: args.networkLabel,
        ),
      );
    },
    GlobalMapRoute.name: (routeData) {
      final args = routeData.argsAs<GlobalMapRouteArgs>(
          orElse: () => const GlobalMapRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: WrappedRoute(
            child: GlobalMapScreen(
          key: args.key,
          source: args.source,
        )),
      );
    },
    LampadaireRoute.name: (routeData) {
      final args = routeData.argsAs<LampadaireRouteArgs>(
          orElse: () => const LampadaireRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: WrappedRoute(
            child: LampadaireScreen(
          key: args.key,
          missionResponse: args.missionResponse,
          qrCode: args.qrCode,
          photo: args.photo,
          source: args.source,
          cabinet: args.cabinet,
          meter: args.meter,
          isEditMode: args.isEditMode,
          streetLight: args.streetLight,
        )),
      );
    },
    LoginRoute.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: WrappedRoute(child: const LoginScreen()),
      );
    },
    MaintenanceEquipmentRoute.name: (routeData) {
      final args = routeData.argsAs<MaintenanceEquipmentRouteArgs>();
      return AutoRoutePage<void>(
        routeData: routeData,
        child: WrappedRoute(
            child: MaintenanceEquipmentScreen(
          key: args.key,
          mission: args.mission,
          source: args.source,
        )),
      );
    },
    MapRoute.name: (routeData) {
      final args =
          routeData.argsAs<MapRouteArgs>(orElse: () => const MapRouteArgs());
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: MapScreen(
          key: args.key,
          cabinet: args.cabinet,
          meter: args.meter,
          streetLight: args.streetLight,
          source: args.source,
        ),
      );
    },
    MissionRoute.name: (routeData) {
      final args = routeData.argsAs<MissionRouteArgs>(
          orElse: () => const MissionRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: WrappedRoute(
            child: MissionScreen(
          key: args.key,
          source: args.source,
        )),
      );
    },
    NetworkDetailsRoute.name: (routeData) {
      final args = routeData.argsAs<NetworkDetailsRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: NetworkDetailsScreen(
          key: args.key,
          network: args.network,
          cabinet: args.cabinet,
          meter: args.meter,
          streetLights: args.streetLights,
          networkLabel: args.networkLabel,
          mission: args.mission,
        ),
      );
    },
    PhotoRoute.name: (routeData) {
      final args = routeData.argsAs<PhotoRouteArgs>(
          orElse: () => const PhotoRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: PhotoScreen(
          key: args.key,
          mission: args.mission,
          qrCode: args.qrCode,
          source: args.source,
          intention: args.intention,
        ),
      );
    },
    QrcodeRoute.name: (routeData) {
      final args = routeData.argsAs<QrcodeRouteArgs>(
          orElse: () => const QrcodeRouteArgs());
      return AutoRoutePage<void>(
        routeData: routeData,
        child: QrcodeScreen(
          key: args.key,
          mission: args.mission,
          source: args.source,
          intention: args.intention,
          existingStreetLight: args.existingStreetLight,
        ),
      );
    },
    SplashRoute.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: const SplashScreen(),
      );
    },
    StreetLightComponentCompletRoute.name: (routeData) {
      final args = routeData.argsAs<StreetLightComponentCompletRouteArgs>();
      return AutoRoutePage<void>(
        routeData: routeData,
        child: StreetLightComponentCompletScreen(
          key: args.key,
          streetLight: args.streetLight,
          mission: args.mission,
          source: args.source,
          networkLabel: args.networkLabel,
        ),
      );
    },
    UserProfileRoute.name: (routeData) {
      return AutoRoutePage<void>(
        routeData: routeData,
        child: WrappedRoute(child: const UserProfileScreen()),
      );
    },
  };
}

/// generated route for
/// [ArmoireDeploiementFormScreen]
class ArmoireDeploiementFormRoute
    extends PageRouteInfo<ArmoireDeploiementFormRouteArgs> {
  ArmoireDeploiementFormRoute({
    Key? key,
    required MissionResponse missionResponse,
    String? qrCode,
    XFile? photo,
    String? source,
    MeterResponse? meter,
    List<PageRouteInfo>? children,
  }) : super(
          ArmoireDeploiementFormRoute.name,
          args: ArmoireDeploiementFormRouteArgs(
            key: key,
            missionResponse: missionResponse,
            qrCode: qrCode,
            photo: photo,
            source: source,
            meter: meter,
          ),
          initialChildren: children,
        );

  static const String name = 'ArmoireDeploiementFormRoute';

  static const PageInfo<ArmoireDeploiementFormRouteArgs> page =
      PageInfo<ArmoireDeploiementFormRouteArgs>(name);
}

class ArmoireDeploiementFormRouteArgs {
  const ArmoireDeploiementFormRouteArgs({
    this.key,
    required this.missionResponse,
    this.qrCode,
    this.photo,
    this.source,
    this.meter,
  });

  final Key? key;

  final MissionResponse missionResponse;

  final String? qrCode;

  final XFile? photo;

  final String? source;

  final MeterResponse? meter;

  @override
  String toString() {
    return 'ArmoireDeploiementFormRouteArgs{key: $key, missionResponse: $missionResponse, qrCode: $qrCode, photo: $photo, source: $source, meter: $meter}';
  }
}

/// generated route for
/// [CompteurDeploiementFormScreen]
class CompteurDeploiementFormRoute
    extends PageRouteInfo<CompteurDeploiementFormRouteArgs> {
  CompteurDeploiementFormRoute({
    Key? key,
    required MissionResponse missionResponse,
    String? qrCode,
    XFile? photo,
    String? source,
    List<PageRouteInfo>? children,
  }) : super(
          CompteurDeploiementFormRoute.name,
          args: CompteurDeploiementFormRouteArgs(
            key: key,
            missionResponse: missionResponse,
            qrCode: qrCode,
            photo: photo,
            source: source,
          ),
          initialChildren: children,
        );

  static const String name = 'CompteurDeploiementFormRoute';

  static const PageInfo<CompteurDeploiementFormRouteArgs> page =
      PageInfo<CompteurDeploiementFormRouteArgs>(name);
}

class CompteurDeploiementFormRouteArgs {
  const CompteurDeploiementFormRouteArgs({
    this.key,
    required this.missionResponse,
    this.qrCode,
    this.photo,
    this.source,
  });

  final Key? key;

  final MissionResponse missionResponse;

  final String? qrCode;

  final XFile? photo;

  final String? source;

  @override
  String toString() {
    return 'CompteurDeploiementFormRouteArgs{key: $key, missionResponse: $missionResponse, qrCode: $qrCode, photo: $photo, source: $source}';
  }
}

/// generated route for
/// [EquipementScreen]
class EquipementRoute extends PageRouteInfo<EquipementRouteArgs> {
  EquipementRoute({
    Key? key,
    required MissionResponse mission,
    String? source,
    List<PageRouteInfo>? children,
  }) : super(
          EquipementRoute.name,
          args: EquipementRouteArgs(
            key: key,
            mission: mission,
            source: source,
          ),
          initialChildren: children,
        );

  static const String name = 'EquipementRoute';

  static const PageInfo<EquipementRouteArgs> page =
      PageInfo<EquipementRouteArgs>(name);
}

class EquipementRouteArgs {
  const EquipementRouteArgs({
    this.key,
    required this.mission,
    this.source,
  });

  final Key? key;

  final MissionResponse mission;

  final String? source;

  @override
  String toString() {
    return 'EquipementRouteArgs{key: $key, mission: $mission, source: $source}';
  }
}

/// generated route for
/// [EquipmentDetailsScreen]
class EquipmentDetailsRoute extends PageRouteInfo<EquipmentDetailsRouteArgs> {
  EquipmentDetailsRoute({
    Key? key,
    CabinetResponse? cabinet,
    MeterResponse? meter,
    StoreStreetLightResponse? streetLight,
    String? source,
    MissionResponse? mission,
    String? networkLabel,
    List<PageRouteInfo>? children,
  }) : super(
          EquipmentDetailsRoute.name,
          args: EquipmentDetailsRouteArgs(
            key: key,
            cabinet: cabinet,
            meter: meter,
            streetLight: streetLight,
            source: source,
            mission: mission,
            networkLabel: networkLabel,
          ),
          initialChildren: children,
        );

  static const String name = 'EquipmentDetailsRoute';

  static const PageInfo<EquipmentDetailsRouteArgs> page =
      PageInfo<EquipmentDetailsRouteArgs>(name);
}

class EquipmentDetailsRouteArgs {
  const EquipmentDetailsRouteArgs({
    this.key,
    this.cabinet,
    this.meter,
    this.streetLight,
    this.source,
    this.mission,
    this.networkLabel,
  });

  final Key? key;

  final CabinetResponse? cabinet;

  final MeterResponse? meter;

  final StoreStreetLightResponse? streetLight;

  final String? source;

  final MissionResponse? mission;

  final String? networkLabel;

  @override
  String toString() {
    return 'EquipmentDetailsRouteArgs{key: $key, cabinet: $cabinet, meter: $meter, streetLight: $streetLight, source: $source, mission: $mission, networkLabel: $networkLabel}';
  }
}

/// generated route for
/// [GlobalMapScreen]
class GlobalMapRoute extends PageRouteInfo<GlobalMapRouteArgs> {
  GlobalMapRoute({
    Key? key,
    String? source,
    List<PageRouteInfo>? children,
  }) : super(
          GlobalMapRoute.name,
          args: GlobalMapRouteArgs(
            key: key,
            source: source,
          ),
          initialChildren: children,
        );

  static const String name = 'GlobalMapRoute';

  static const PageInfo<GlobalMapRouteArgs> page =
      PageInfo<GlobalMapRouteArgs>(name);
}

class GlobalMapRouteArgs {
  const GlobalMapRouteArgs({
    this.key,
    this.source,
  });

  final Key? key;

  final String? source;

  @override
  String toString() {
    return 'GlobalMapRouteArgs{key: $key, source: $source}';
  }
}

/// generated route for
/// [LampadaireScreen]
class LampadaireRoute extends PageRouteInfo<LampadaireRouteArgs> {
  LampadaireRoute({
    Key? key,
    MissionResponse? missionResponse,
    String? qrCode,
    XFile? photo,
    String? source,
    CabinetResponse? cabinet,
    MeterResponse? meter,
    bool? isEditMode,
    StoreStreetLightResponse? streetLight,
    List<PageRouteInfo>? children,
  }) : super(
          LampadaireRoute.name,
          args: LampadaireRouteArgs(
            key: key,
            missionResponse: missionResponse,
            qrCode: qrCode,
            photo: photo,
            source: source,
            cabinet: cabinet,
            meter: meter,
            isEditMode: isEditMode,
            streetLight: streetLight,
          ),
          initialChildren: children,
        );

  static const String name = 'LampadaireRoute';

  static const PageInfo<LampadaireRouteArgs> page =
      PageInfo<LampadaireRouteArgs>(name);
}

class LampadaireRouteArgs {
  const LampadaireRouteArgs({
    this.key,
    this.missionResponse,
    this.qrCode,
    this.photo,
    this.source,
    this.cabinet,
    this.meter,
    this.isEditMode,
    this.streetLight,
  });

  final Key? key;

  final MissionResponse? missionResponse;

  final String? qrCode;

  final XFile? photo;

  final String? source;

  final CabinetResponse? cabinet;

  final MeterResponse? meter;

  final bool? isEditMode;

  final StoreStreetLightResponse? streetLight;

  @override
  String toString() {
    return 'LampadaireRouteArgs{key: $key, missionResponse: $missionResponse, qrCode: $qrCode, photo: $photo, source: $source, cabinet: $cabinet, meter: $meter, isEditMode: $isEditMode, streetLight: $streetLight}';
  }
}

/// generated route for
/// [LoginScreen]
class LoginRoute extends PageRouteInfo<void> {
  const LoginRoute({List<PageRouteInfo>? children})
      : super(
          LoginRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [MaintenanceEquipmentScreen]
class MaintenanceEquipmentRoute
    extends PageRouteInfo<MaintenanceEquipmentRouteArgs> {
  MaintenanceEquipmentRoute({
    Key? key,
    required MissionResponse mission,
    String? source,
    List<PageRouteInfo>? children,
  }) : super(
          MaintenanceEquipmentRoute.name,
          args: MaintenanceEquipmentRouteArgs(
            key: key,
            mission: mission,
            source: source,
          ),
          initialChildren: children,
        );

  static const String name = 'MaintenanceEquipmentRoute';

  static const PageInfo<MaintenanceEquipmentRouteArgs> page =
      PageInfo<MaintenanceEquipmentRouteArgs>(name);
}

class MaintenanceEquipmentRouteArgs {
  const MaintenanceEquipmentRouteArgs({
    this.key,
    required this.mission,
    this.source,
  });

  final Key? key;

  final MissionResponse mission;

  final String? source;

  @override
  String toString() {
    return 'MaintenanceEquipmentRouteArgs{key: $key, mission: $mission, source: $source}';
  }
}

/// generated route for
/// [MapScreen]
class MapRoute extends PageRouteInfo<MapRouteArgs> {
  MapRoute({
    Key? key,
    CabinetResponse? cabinet,
    MeterResponse? meter,
    StoreStreetLightResponse? streetLight,
    String? source,
    List<PageRouteInfo>? children,
  }) : super(
          MapRoute.name,
          args: MapRouteArgs(
            key: key,
            cabinet: cabinet,
            meter: meter,
            streetLight: streetLight,
            source: source,
          ),
          initialChildren: children,
        );

  static const String name = 'MapRoute';

  static const PageInfo<MapRouteArgs> page = PageInfo<MapRouteArgs>(name);
}

class MapRouteArgs {
  const MapRouteArgs({
    this.key,
    this.cabinet,
    this.meter,
    this.streetLight,
    this.source,
  });

  final Key? key;

  final CabinetResponse? cabinet;

  final MeterResponse? meter;

  final StoreStreetLightResponse? streetLight;

  final String? source;

  @override
  String toString() {
    return 'MapRouteArgs{key: $key, cabinet: $cabinet, meter: $meter, streetLight: $streetLight, source: $source}';
  }
}

/// generated route for
/// [MissionScreen]
class MissionRoute extends PageRouteInfo<MissionRouteArgs> {
  MissionRoute({
    Key? key,
    String? source,
    List<PageRouteInfo>? children,
  }) : super(
          MissionRoute.name,
          args: MissionRouteArgs(
            key: key,
            source: source,
          ),
          initialChildren: children,
        );

  static const String name = 'MissionRoute';

  static const PageInfo<MissionRouteArgs> page =
      PageInfo<MissionRouteArgs>(name);
}

class MissionRouteArgs {
  const MissionRouteArgs({
    this.key,
    this.source,
  });

  final Key? key;

  final String? source;

  @override
  String toString() {
    return 'MissionRouteArgs{key: $key, source: $source}';
  }
}

/// generated route for
/// [NetworkDetailsScreen]
class NetworkDetailsRoute extends PageRouteInfo<NetworkDetailsRouteArgs> {
  NetworkDetailsRoute({
    Key? key,
    required IndividualNetwork network,
    CabinetResponse? cabinet,
    MeterResponse? meter,
    required List<StoreStreetLightResponse> streetLights,
    required String networkLabel,
    required MissionResponse mission,
    List<PageRouteInfo>? children,
  }) : super(
          NetworkDetailsRoute.name,
          args: NetworkDetailsRouteArgs(
            key: key,
            network: network,
            cabinet: cabinet,
            meter: meter,
            streetLights: streetLights,
            networkLabel: networkLabel,
            mission: mission,
          ),
          initialChildren: children,
        );

  static const String name = 'NetworkDetailsRoute';

  static const PageInfo<NetworkDetailsRouteArgs> page =
      PageInfo<NetworkDetailsRouteArgs>(name);
}

class NetworkDetailsRouteArgs {
  const NetworkDetailsRouteArgs({
    this.key,
    required this.network,
    this.cabinet,
    this.meter,
    required this.streetLights,
    required this.networkLabel,
    required this.mission,
  });

  final Key? key;

  final IndividualNetwork network;

  final CabinetResponse? cabinet;

  final MeterResponse? meter;

  final List<StoreStreetLightResponse> streetLights;

  final String networkLabel;

  final MissionResponse mission;

  @override
  String toString() {
    return 'NetworkDetailsRouteArgs{key: $key, network: $network, cabinet: $cabinet, meter: $meter, streetLights: $streetLights, networkLabel: $networkLabel, mission: $mission}';
  }
}

/// generated route for
/// [PhotoScreen]
class PhotoRoute extends PageRouteInfo<PhotoRouteArgs> {
  PhotoRoute({
    Key? key,
    MissionResponse? mission,
    String? qrCode,
    String? source,
    String? intention,
    List<PageRouteInfo>? children,
  }) : super(
          PhotoRoute.name,
          args: PhotoRouteArgs(
            key: key,
            mission: mission,
            qrCode: qrCode,
            source: source,
            intention: intention,
          ),
          initialChildren: children,
        );

  static const String name = 'PhotoRoute';

  static const PageInfo<PhotoRouteArgs> page = PageInfo<PhotoRouteArgs>(name);
}

class PhotoRouteArgs {
  const PhotoRouteArgs({
    this.key,
    this.mission,
    this.qrCode,
    this.source,
    this.intention,
  });

  final Key? key;

  final MissionResponse? mission;

  final String? qrCode;

  final String? source;

  final String? intention;

  @override
  String toString() {
    return 'PhotoRouteArgs{key: $key, mission: $mission, qrCode: $qrCode, source: $source, intention: $intention}';
  }
}

/// generated route for
/// [QrcodeScreen]
class QrcodeRoute extends PageRouteInfo<QrcodeRouteArgs> {
  QrcodeRoute({
    Key? key,
    MissionResponse? mission,
    String? source,
    String? intention,
    StoreStreetLightResponse? existingStreetLight,
    List<PageRouteInfo>? children,
  }) : super(
          QrcodeRoute.name,
          args: QrcodeRouteArgs(
            key: key,
            mission: mission,
            source: source,
            intention: intention,
            existingStreetLight: existingStreetLight,
          ),
          initialChildren: children,
        );

  static const String name = 'QrcodeRoute';

  static const PageInfo<QrcodeRouteArgs> page = PageInfo<QrcodeRouteArgs>(name);
}

class QrcodeRouteArgs {
  const QrcodeRouteArgs({
    this.key,
    this.mission,
    this.source,
    this.intention,
    this.existingStreetLight,
  });

  final Key? key;

  final MissionResponse? mission;

  final String? source;

  final String? intention;

  final StoreStreetLightResponse? existingStreetLight;

  @override
  String toString() {
    return 'QrcodeRouteArgs{key: $key, mission: $mission, source: $source, intention: $intention, existingStreetLight: $existingStreetLight}';
  }
}

/// generated route for
/// [SplashScreen]
class SplashRoute extends PageRouteInfo<void> {
  const SplashRoute({List<PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [StreetLightComponentCompletScreen]
class StreetLightComponentCompletRoute
    extends PageRouteInfo<StreetLightComponentCompletRouteArgs> {
  StreetLightComponentCompletRoute({
    Key? key,
    StoreStreetLightResponseComplet? streetLight,
    MissionResponse? mission,
    required String source,
    required String? networkLabel,
    List<PageRouteInfo>? children,
  }) : super(
          StreetLightComponentCompletRoute.name,
          args: StreetLightComponentCompletRouteArgs(
            key: key,
            streetLight: streetLight,
            mission: mission,
            source: source,
            networkLabel: networkLabel,
          ),
          initialChildren: children,
        );

  static const String name = 'StreetLightComponentCompletRoute';

  static const PageInfo<StreetLightComponentCompletRouteArgs> page =
      PageInfo<StreetLightComponentCompletRouteArgs>(name);
}

class StreetLightComponentCompletRouteArgs {
  const StreetLightComponentCompletRouteArgs({
    this.key,
    this.streetLight,
    this.mission,
    required this.source,
    required this.networkLabel,
  });

  final Key? key;

  final StoreStreetLightResponseComplet? streetLight;

  final MissionResponse? mission;

  final String source;

  final String? networkLabel;

  @override
  String toString() {
    return 'StreetLightComponentCompletRouteArgs{key: $key, streetLight: $streetLight, mission: $mission, source: $source, networkLabel: $networkLabel}';
  }
}

/// generated route for
/// [UserProfileScreen]
class UserProfileRoute extends PageRouteInfo<void> {
  const UserProfileRoute({List<PageRouteInfo>? children})
      : super(
          UserProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'UserProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
