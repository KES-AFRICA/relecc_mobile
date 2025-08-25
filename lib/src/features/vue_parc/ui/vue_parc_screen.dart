import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/features/vue_parc/logic/controller/bloc/equipment_cubit.dart';
import 'package:sopaki_app/src/shared/components/app_drawer.dart';
import 'package:sopaki_app/src/shared/components/custom_appbar.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';

@RoutePage()
class GlobalMapScreen extends StatefulWidget implements AutoRouteWrapper {
  final String? source;
  const GlobalMapScreen({super.key, this.source});

  @override
  State<GlobalMapScreen> createState() => _GlobalMapScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => EquipmentCubit())],
      child: this,
    );
  }
}

class _GlobalMapScreenState extends State<GlobalMapScreen> {
  final MapController _mapController = MapController();
  List<Marker> _markers = [];
  List<Polyline> _polylines = [];
  bool _isMapReady = false;
  bool _isLoading = true;

  // Filtres
  String _selectedEquipmentType = 'Tous';
  String _selectedNetworkType = 'Tous';
  String? _selectedStreet;
  String? _selectedMunicipality;
  bool _showFilters = false;

  // Données pour les filtres
  Set<String> _streets = {};
  Set<String> _municipalities = {};

    final Location _locationService = Location();
  LatLng? _userPosition;
  bool _isTrackingLocation = false;
  StreamSubscription<LocationData>? _locationSubscription;

  static const LatLng initialPosition = LatLng(4.0511, 9.7605);

  @override
  void initState() {
    super.initState();
    _initLocationService();
    context.read<EquipmentCubit>().getAllStreetlights();
    context.read<EquipmentCubit>().getAllMeters();
    context.read<EquipmentCubit>().getAllCabinets();
  }

    @override
  void dispose() {
    _locationSubscription?.cancel();
    super.dispose();
  }

    Future<void> _initLocationService() async {
    bool serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) return;
    }

    PermissionStatus permission = await _locationService.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await _locationService.requestPermission();
      if (permission != PermissionStatus.granted) return;
    }

    _startLocationTracking();
  }

  void _startLocationTracking() {
    _locationSubscription = _locationService.onLocationChanged.listen((LocationData locationData) {
      if (locationData.latitude != null && locationData.longitude != null) {
        setState(() {
          _userPosition = LatLng(locationData.latitude!, locationData.longitude!);
          _isTrackingLocation = true;
        });
      }
    });
  }

  Marker _buildUserLocationMarker() {
  return Marker(
    point: _userPosition!,
    width: 25,
    height: 25,
    child: Container(
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.white,
          width: 2,
        ),
      ),
      child: const Center(
        child: Icon(
          Icons.person,
          color: Colors.white,
          size: 9,
        ),
      ),
    ),
  );
}


  void _extractFilterOptions(
    List<StoreStreetLightResponseComplet> streetlights,
    List<MeterResponse> meters,
    List<CabinetResponse> cabinets,
  ) {
    final streets = <String>{};
    final municipalities = <String>{};

    // Fonction pour extraire les informations de localisation
    void addLocationInfo(dynamic equipment) {
      try {
        // Gestion de la rue
        if (equipment.street is String) {
          streets.add(equipment.street);
        } else if (equipment.street != null && equipment.street.name != null) {
          streets.add(equipment.street.name);
        }

        // Gestion de la municipalité
        if (equipment.municipality is String) {
          municipalities.add(equipment.municipality);
        } else if (equipment.municipality != null &&
            equipment.municipality.name != null) {
          municipalities.add(equipment.municipality.name);
        } else if (equipment.street?.municipality is String) {
          municipalities.add(equipment.street.municipality);
        }
      } catch (e) {
        debugPrint('Erreur lors de l\'extraction des filtres: $e');
      }
    }

    // Traitement de tous les équipements
    streetlights.forEach(addLocationInfo);
    meters.forEach(addLocationInfo);
    cabinets.forEach(addLocationInfo);

    // Mise à jour de l'état
    setState(() {
      _streets = streets;
      _municipalities = municipalities;
    });
  }


  void _loadMarkersAndNetworks({
    List<StoreStreetLightResponseComplet>? streetlights,
    List<MeterResponse>? meters,
    List<CabinetResponse>? cabinets,
  }) {
    if (streetlights == null || meters == null || cabinets == null) return;

    List<Marker> markers = [];
    List<Polyline> polylines = [];

    // Extraire les options de filtre au premier chargement
    if (_streets.isEmpty && _municipalities.isEmpty) {
      _extractFilterOptions(streetlights, meters, cabinets);
    }

    // Filtrer les équipements selon les critères sélectionnés
    final filteredStreetlights = streetlights.where((light) {
      final matchesType = _selectedEquipmentType == 'Tous' ||
          _selectedEquipmentType == 'Lampadaire';
      final matchesStreet =
          _selectedStreet == null || (light.street == _selectedStreet);
      final matchesMunicipality = _selectedMunicipality == null ||
          (light.municipality == _selectedMunicipality);
      return matchesType && matchesStreet && matchesMunicipality;
    }).toList();

    final filteredMeters = meters.where((meter) {
      final matchesType = _selectedEquipmentType == 'Tous' ||
          _selectedEquipmentType == 'Compteur';
      final matchesStreet =
          _selectedStreet == null || (meter.street?.name == _selectedStreet);
      final matchesMunicipality = _selectedMunicipality == null ||
          (meter.municipality == _selectedMunicipality);
      return matchesType && matchesStreet && matchesMunicipality;
    }).toList();

    final filteredCabinets = cabinets.where((cabinet) {
      final matchesType = _selectedEquipmentType == 'Tous' ||
          _selectedEquipmentType == 'Armoire';
      final matchesStreet =
          _selectedStreet == null || (cabinet.street?.name == _selectedStreet);
      final matchesMunicipality = _selectedMunicipality == null ||
          (cabinet.municipality == _selectedMunicipality);
      return matchesType && matchesStreet && matchesMunicipality;
    }).toList();

    // Créer des maps avec des types explicites
    final Map<int, StoreStreetLightResponseComplet> streetlightMap = {
      for (var light in filteredStreetlights)
        if (light.id != null) light.id!: light
    };

    final Map<int, MeterResponse> meterMap = {
      for (var meter in filteredMeters)
        if (meter.id != null) meter.id!: meter
    };

    final Map<int, CabinetResponse> cabinetMap = {
      for (var cabinet in filteredCabinets)
        if (cabinet.id != null) cabinet.id!: cabinet
    };

    // Tracer les réseaux entre équipements connectés selon le filtre réseau
    if (_selectedNetworkType == 'Tous' || _selectedNetworkType == 'Complet') {
      _traceCompleteNetworks(
        streetlightMap: streetlightMap,
        meterMap: meterMap,
        cabinetMap: cabinetMap,
        polylines: polylines,
        context: context,
      );
    }

    if (_selectedNetworkType == 'Tous' ||
        _selectedNetworkType == 'Sans armoire') {
      _traceMeterOnlyNetworks(
        streetlightMap: streetlightMap,
        meterMap: meterMap,
        polylines: polylines,
        context: context,
      );
    }

    if (_selectedNetworkType == 'Tous' ||
        _selectedNetworkType == 'Sans compteur') {
      _traceCabinetOnlyNetworks(
        streetlightMap: streetlightMap,
        cabinetMap: cabinetMap,
        polylines: polylines,
        context: context,
      );
    }

    // Ajouter les marqueurs selon le filtre d'équipement
    if (_selectedEquipmentType == 'Tous' ||
        _selectedEquipmentType == 'Lampadaire') {
      for (final light in filteredStreetlights) {
        final location = _parseLocation(light.location);
        if (location != null) {
          markers.add(_buildEquipmentMarker(
            point: location,
            icon: Icons.lightbulb,
            color: _getLightColor(light),
            isLight: true,
            context: context,
            equipment: light,
          ));
        }
      }
    }

    if (_selectedEquipmentType == 'Tous' ||
        _selectedEquipmentType == 'Compteur') {
      for (final meter in filteredMeters) {
        final location = _parseLocation(meter.location);
        if (location != null) {
          markers.add(_buildEquipmentMarker(
            point: location,
            icon: Icons.speed,
            color: Colors.purple,
            context: context,
            equipment: meter,
          ));
        }
      }
    }

    if (_selectedEquipmentType == 'Tous' ||
        _selectedEquipmentType == 'Armoire') {
      for (final cabinet in filteredCabinets) {
        final location = _parseLocation(cabinet.location);
        if (location != null) {
          markers.add(_buildEquipmentMarker(
            point: location,
            icon: Icons.electrical_services,
            color: Colors.blue,
            context: context,
            equipment: cabinet,
          ));
        }
      }
    }

    setState(() {
      _markers = markers;
      _polylines = polylines;
      _isLoading = false;
    });

    if (_isMapReady && markers.isNotEmpty) {
      _mapController.move(markers.first.point, 15);
    }
  }

void _traceCompleteNetworks({
  required Map<int, StoreStreetLightResponseComplet> streetlightMap,
  required Map<int, MeterResponse> meterMap,
  required Map<int, CabinetResponse> cabinetMap,
  required List<Polyline> polylines,
  required BuildContext context,
}) {
  final primaryColor = context.colorScheme.primary;

  for (final cabinet in cabinetMap.values) {
    final cabinetPos = _parseLocation(cabinet.location);
    if (cabinetPos == null || cabinet.meterId == null) continue;

    final meter = meterMap[cabinet.meterId];
    if (meter == null) continue;

    final meterPos = _parseLocation(meter.location);
    if (meterPos == null) continue;

    final cabinetLights = streetlightMap.values
        .where((light) => light.cabinetId == cabinet.id)
        .where((light) => _parseLocation(light.location) != null)
        .toList();

    if (cabinetLights.isEmpty) continue;

    // Créer une liste ordonnée des points: compteur -> armoire -> lampadaires
    final points = [meterPos, cabinetPos];
    points.addAll(cabinetLights.map((l) => _parseLocation(l.location)!));

    polylines.add(Polyline(
      points: points,
      color: primaryColor,
      strokeWidth: 2.0,
    ));
  }
}

void _traceMeterOnlyNetworks({
  required Map<int, StoreStreetLightResponseComplet> streetlightMap,
  required Map<int, MeterResponse> meterMap,
  required List<Polyline> polylines,
  required BuildContext context,
}) {
  final primaryColor = context.colorScheme.primary;

  for (final meter in meterMap.values) {
    final meterPos = _parseLocation(meter.location);
    if (meterPos == null) continue;

    final meterLights = streetlightMap.values
        .where((light) => light.meterId == meter.id && light.cabinetId == null)
        .where((light) => _parseLocation(light.location) != null)
        .toList();

    if (meterLights.isEmpty) continue;

    // Créer une liste ordonnée des points: compteur -> lampadaires
    final points = [meterPos];
    points.addAll(meterLights.map((l) => _parseLocation(l.location)!));

    polylines.add(Polyline(
      points: points,
      color: primaryColor,
      strokeWidth: 2.0,
    ));
  }
}

void _traceCabinetOnlyNetworks({
  required Map<int, StoreStreetLightResponseComplet> streetlightMap,
  required Map<int, CabinetResponse> cabinetMap,
  required List<Polyline> polylines,
  required BuildContext context,
}) {
  final primaryColor = context.colorScheme.primary;

  for (final cabinet in cabinetMap.values) {
    if (cabinet.meterId != null) continue;

    final cabinetPos = _parseLocation(cabinet.location);
    if (cabinetPos == null) continue;

    final cabinetLights = streetlightMap.values
        .where((light) => light.cabinetId == cabinet.id)
        .where((light) => _parseLocation(light.location) != null)
        .toList();

    if (cabinetLights.isEmpty) continue;

    // Créer une liste ordonnée des points: armoire -> lampadaires
    final points = [cabinetPos];
    points.addAll(cabinetLights.map((l) => _parseLocation(l.location)!));

    polylines.add(Polyline(
      points: points,
      color: primaryColor,
      strokeWidth: 2.0,
    ));
  }
}
  double _distance(LatLng p1, LatLng p2) {
    final dx = p1.latitude - p2.latitude;
    final dy = p1.longitude - p2.longitude;
    return dx * dx + dy * dy;
  }

  Color _getLightColor(StoreStreetLightResponseComplet light) {
    final isOnDay = light.isOnDay ?? 0;
    final isOnNight = light.isOnNight ?? 0;

    if ((isOnDay == 1 && isOnNight == 0) ||
        (isOnDay == 0 && isOnNight == 0) ||
        (isOnDay == 1 && isOnNight == 1)) {
      return Colors.red;
    }
    return Colors.green;
  }

  LatLng? _parseLocation(String? location) {
    if (location == null || location.isEmpty) return null;

    try {
      final coords = location.split(',');
      if (coords.length != 2) return null;

      final lat = double.tryParse(coords[0].trim());
      final lng = double.tryParse(coords[1].trim());

      if (lat == null || lng == null) return null;

      return LatLng(lat, lng);
    } catch (e) {
      return null;
    }
  }

  Marker _buildEquipmentMarker({
    required LatLng point,
    required IconData icon,
    required Color color,
    bool isLight = false,
    required BuildContext context,
    required dynamic equipment,
  }) {
    return Marker(
      point: point,
      width: 15,
      height: 15,
      child: GestureDetector(
        onTap: () => _showEquipmentDetails(context, equipment, isLight),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color, width: 2),
          ),
          child: Center(
            child: Icon(
              icon,
              color: color,
              size: isLight ? 10 : 12,
            ),
          ),
        ),
      ),
    );
  }

  void _showEquipmentDetails(
      BuildContext context, dynamic equipment, bool isLight) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      backgroundColor: Colors.white,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CachedNetworkImage(
                      imageUrl: equipment.photo??'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
                      height: 200,
                      width: 120,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        isLight
                            ? Assets.lampadaire
                            : equipment is MeterResponse
                                ? Assets.compteur
                                : Assets.armoire,
                        height: 200,
                        width: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              equipment.name ?? (isLight ? 'Lampadaire' : 'Équipement'),
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            if (isLight)
              _buildLightDetails(equipment as StoreStreetLightResponseComplet)
            else if (equipment is MeterResponse)
              _buildMeterDetails(equipment)
            else if (equipment is CabinetResponse)
              _buildCabinetDetails(equipment),
            if (equipment.createdAt != null)
              Padding(
                padding: const EdgeInsets.only(top: 8, bottom: 16),
                child: Text(
                  'Créé le: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(equipment.createdAt!)}',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                    fontSize: 14,
                  ),
                ),
              ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Fermer le modal

                // Si c'est un lampadaire, naviguer vers la page de détails
                if (isLight) {
                  context.router.push(StreetLightComponentCompletRoute(
                    streetLight: equipment,
                    source: widget.source ?? "",
                    networkLabel: "",
                  ));
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                isLight
                    ? 'Détails'
                    : 'Fermer', // Afficher "Détails" ou "Fermer" selon le type
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildLightDetails(StoreStreetLightResponseComplet light) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
            Icons.location_on, light.street ?? 'Localisation inconnue'),
        _buildDetailRow(
            Icons.lightbulb, 'Type: ${light.streetLightType ?? 'N/A'}'),
        _buildDetailRow(Icons.bolt, 'Puissance: ${light.power ?? 'N/A'}W'),
        if (light.location != null)
          _buildDetailRow(Icons.gps_fixed, 'Position: ${light.location}'),
      ],
    );
  }

  Widget _buildMeterDetails(MeterResponse meter) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
            Icons.location_on, meter.street?.name ?? 'Localisation inconnue'),
        _buildDetailRow(Icons.speed, 'Modèle: ${meter.model ?? 'N/A'}'),
        if (meter.brand != null)
          _buildDetailRow(Icons.branding_watermark, 'Marque: ${meter.brand}'),
        if (meter.location != null)
          _buildDetailRow(Icons.gps_fixed, 'Position: ${meter.location}'),
      ],
    );
  }

  Widget _buildCabinetDetails(CabinetResponse cabinet) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
            Icons.location_on, cabinet.street?.name ?? 'Localisation inconnue'),
        _buildDetailRow(
            Icons.lightbulb_outline, 'Lampadaires: ${cabinet.lampCount ?? 0}'),
        if (cabinet.location != null)
          _buildDetailRow(Icons.gps_fixed, 'Position: ${cabinet.location}'),
      ],
    );
  }

  Widget _buildDetailRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }

  Widget _buildFilterMenu(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        elevation: 8,
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Filtrer la carte',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              // Filtre par type d'équipement
              const Text('Type d\'équipement:'),
              DropdownButton<String>(
                value: _selectedEquipmentType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedEquipmentType = newValue!;
                  });
                },
                items: <String>['Tous', 'Lampadaire', 'Compteur', 'Armoire']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Filtre par type de réseau
              const Text('Type de réseau:'),
              DropdownButton<String>(
                value: _selectedNetworkType,
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedNetworkType = newValue!;
                  });
                },
                items: <String>[
                  'Tous',
                  'Complet',
                  'Sans armoire',
                  'Sans compteur'
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),

              // Filtre par rue
              Container(
                constraints: BoxConstraints(
                    maxWidth: 200), // Ajustez cette valeur selon vos besoins
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Rue:'),
                    DropdownButton<String>(
                      isExpanded: true, // Important pour gérer les textes longs
                      value: _selectedStreet,
                      hint: const Text('Toutes'),
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedStreet = newValue;
                        });
                      },
                      items: [
                        const DropdownMenuItem<String>(
                          value: null,
                          child:
                              Text('Toutes', overflow: TextOverflow.ellipsis),
                        ),
                        ..._streets.map((street) {
                          return DropdownMenuItem<String>(
                            value: street,
                            child: Text(
                              street,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          );
                        }).toList(),
                      ],
                      underline:
                          Container(), // Supprime la ligne de soulignement par défaut
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Filtre par commune
              const Text('Commune:'),
              DropdownButton<String>(
                value: _selectedMunicipality,
                hint: const Text('Toutes'),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedMunicipality = newValue;
                  });
                },
                items: [
                  const DropdownMenuItem<String>(
                    value: null,
                    child: Text('Toutes'),
                  ),
                  ..._municipalities.map((municipality) {
                    return DropdownMenuItem<String>(
                      value: municipality,
                      child: Text(municipality),
                    );
                  }).toList(),
                ],
              ),
              const SizedBox(height: 24),

              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showFilters = false;
                    final state = context.read<EquipmentCubit>().state;
                    state.maybeWhen(
                      loaded: (streetlights, meters, cabinets) {
                        _loadMarkersAndNetworks(
                          streetlights: streetlights,
                          meters: meters,
                          cabinets: cabinets,
                        );
                      },
                      orElse: () {},
                    );
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: primaryColor,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Appliquer les filtres'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    
    return BlocConsumer<EquipmentCubit, EquipmentState>(
      listener: (context, state) {
        state.whenOrNull(
          loaded: (streetlights, meters, cabinets) {
            _loadMarkersAndNetworks(
              streetlights: streetlights,
              meters: meters,
              cabinets: cabinets,
            );
          },
        );
      },
      builder: (context, state) {
         final userMarkers = _userPosition != null 
          ? [_buildUserLocationMarker()]
          : [];

        return Scaffold(
          appBar: const CustomAppBar(title: "Vue globale du parc"),
          drawer: const AppDrawer(selected: 3),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              setState(() {
                _showFilters = !_showFilters;
              });
            },
            backgroundColor: Theme.of(context).colorScheme.primary,
            child: const Icon(Icons.filter_list, color: Colors.white),
          ),
          body: Stack(
            children: [
              Column(
                children: [
                  state.maybeWhen(
                    loading: () => const Expanded(
                      child: Center(child: CircularProgressIndicator()),
                    ),
                    loaded: (streetlights, meters, cabinets) => Expanded(
                      child: FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: initialPosition,
                          initialZoom: 14.0,
                          onMapReady: () {
                            setState(() => _isMapReady = true);
                            Future.delayed(Duration(milliseconds: 100), () {
                              final center = _mapController.camera.center;
                              final zoom = _mapController.camera.zoom;
                              _mapController.move(center, zoom);
                            });
                          },
                        ),
                        children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.kes.skt.releccud',
                ),
                PolylineLayer(polylines: _polylines),
                MarkerLayer(markers: [..._markers, ...userMarkers]),
              ],
                      ),
                    ),
                    orElse: () => const Expanded(
                      child: Center(child: Text('Une erreur est survenue')),
                    ),
                  ),
                ],
              ),
               if (_showFilters) _buildFilterMenu(context),
            if (!_isTrackingLocation)
              Positioned(
                bottom: 20,
                right: 20,
                child: FloatingActionButton(
                  onPressed: _initLocationService,
                  child: const Icon(Icons.my_location),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
