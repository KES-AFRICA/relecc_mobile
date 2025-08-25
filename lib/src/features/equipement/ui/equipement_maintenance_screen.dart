import 'dart:async';
import 'dart:io';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/features/mission/logic/controller/bloc/mission_cubit.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/shared/components/colors.dart';
import 'package:sopaki_app/src/shared/components/dialogs/api_error_dialog.dart';
import 'package:sopaki_app/src/shared/components/dialogs/dialog_builder.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';


@RoutePage<void>()
class MaintenanceEquipmentScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final MissionResponse mission;
  final String? source;

  const MaintenanceEquipmentScreen(
      {super.key, required this.mission, this.source});

  @override
  State<MaintenanceEquipmentScreen> createState() =>
      _MaintenanceEquipmentScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MissionCubit()),
      ],
      child: this,
    );
  }
}

class _MaintenanceEquipmentScreenState
    extends State<MaintenanceEquipmentScreen> {
  String _selectedType = "Tous";
  final MapController _mapController = MapController();
  bool _showMapView = false;
  late LocationData _currentLocation;
  final Location _locationService = Location();
  bool _locationLoaded = false;
  Map<LatLng, List<LatLng>> _polylines = {};
  Map<LatLng, double> _polylineProgress = {};
  Timer? _animationTimer;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
    if (widget.mission.id != null) {
      context
          .read<MissionCubit>()
          .getAllEquipmentsMissionMaintenance(widget.mission.id!);
    } else {
      ApiErrorDialog.show(context: context, error: 'Mission ID is null');
    }
  }

  @override
  void dispose() {
    _animationTimer?.cancel();
    super.dispose();
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    serviceEnabled = await _locationService.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await _locationService.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await _locationService.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await _locationService.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    final locationData = await _locationService.getLocation();
    setState(() {
      _currentLocation = locationData;
      _locationLoaded = true;
      _mapController.move(
        LatLng(_currentLocation.latitude!, _currentLocation.longitude!),
        _mapController.camera.zoom,
      );
    });
  }

  void _calculatePolylines(List<LatLng> equipmentPositions) {
  _polylines.clear();
  _polylineProgress.clear();

  if (!_locationLoaded) return; // Ne pas calculer si la position n'est pas disponible

  for (final equipmentPos in equipmentPositions) {
    final userPos = LatLng(_currentLocation.latitude!, _currentLocation.longitude!);
    _polylines[equipmentPos] = [userPos, equipmentPos];
    _polylineProgress[equipmentPos] = 0.0;
  }

  // Démarrer l'animation
  _animationTimer?.cancel();
  _animationTimer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
    setState(() {
      bool allCompleted = true;
      _polylineProgress.forEach((key, value) {
        if (value < 1.0) {
          _polylineProgress[key] = value + 0.01;
          allCompleted = false;
        }
      });
      if (allCompleted) {
        timer.cancel();
      }
    });
  });
}

  void _setSelectedType(String type) {
    setState(() {
      _selectedType = type;
    });
  }

  void _toggleView() {
    setState(() {
      _showMapView = !_showMapView;
    });
  }

  List<Marker> _buildMarkers({
    required List<CabinetResponse> cabinets,
    required List<MeterResponse> meters,
    required List<StoreStreetLightResponse> streetLights,
  }) {
    final markers = <Marker>[];
    final equipmentPositions = <LatLng>[];

    // Créer les marqueurs pour les armoires
    if (_selectedType == "Tous" || _selectedType == "Armoires") {
      for (final cabinet in cabinets) {
        final position = _parseCoordinates(cabinet.location);
        if (position != null) {
          equipmentPositions.add(position);
          markers.add(
            Marker(
              point: position,
              width: 15,
              height: 15,
              child: GestureDetector(
                onTap: () => _showEquipmentDetails(context, cabinet, 'cabinet'),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.electrical_services,
                      color: Colors.blue,
                      size: 10,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    // Créer les marqueurs pour les compteurs
    if (_selectedType == "Tous" || _selectedType == "Compteurs") {
      for (final meter in meters) {
        final position = _parseCoordinates(meter.location);
        if (position != null) {
          equipmentPositions.add(position);
          markers.add(
            Marker(
              point: position,
              width: 15,
              height: 15,
              child: GestureDetector(
                onTap: () => _showEquipmentDetails(context, meter, 'meter'),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.purple, width: 2),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.speed,
                      color: Colors.purple,
                      size: 10,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    // Créer les marqueurs pour les lampadaires
    if (_selectedType == "Tous" || _selectedType == "Lampadaires") {
      for (final light in streetLights) {
        final position = _parseCoordinates(light.location);
        if (position != null) {
          final color = _getLightColor(light);
          equipmentPositions.add(position);
          markers.add(
            Marker(
              point: position,
              width: 15,
              height: 15,
              child: GestureDetector(
                onTap: () =>
                    _showEquipmentDetails(context, light, 'streetLight'),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: color, width: 2),
                  ),
                  child: Center(
                    child: Icon(
                      Icons.lightbulb,
                      color: color,
                      size: 10,
                    ),
                  ),
                ),
              ),
            ),
          );
        }
      }
    }

    // Calculer les polylignes si la position est disponible
    if (_locationLoaded && equipmentPositions.isNotEmpty) {
      _calculatePolylines(equipmentPositions);
    }

    // Ajouter le marqueur de l'utilisateur
    if (_locationLoaded) {
      markers.add(
        Marker(
          point:
              LatLng(_currentLocation.latitude!, _currentLocation.longitude!),
          width: 25,
          height: 25,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.8),
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: const Center(
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        ),
      );
    }

    return markers;
  }

  Color _getLightColor(StoreStreetLightResponse light) {
    final isOnDay = light.isOnDay ?? 0;
    final isOnNight = light.isOnNight ?? 0;

    if ((isOnDay == 1 && isOnNight == 0) ||
        (isOnDay == 0 && isOnNight == 0) ||
        (isOnDay == 1 && isOnNight == 1)) {
      return Colors.red; // Problème détecté
    }
    return Colors.green; // Fonctionne correctement
  }

  LatLng? _parseCoordinates(String? location) {
    if (location == null) return null;
    final coords = location.split(',');
    if (coords.length != 2) return null;
    final lat = double.tryParse(coords[0]);
    final lng = double.tryParse(coords[1]);
    return (lat != null && lng != null) ? LatLng(lat, lng) : null;
  }

  void _showEquipmentDetails(
      BuildContext context, dynamic equipment, String type) {
    final isLight = type == 'streetLight';

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
                child: Image.asset(
                  isLight
                      ? Assets.lampadaire
                      : type == 'meter'
                          ? Assets.compteur
                          : Assets.armoire,
                  height: 200,
                  width: 120,
                  fit: BoxFit.cover,
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
              _buildLightDetails(equipment as StoreStreetLightResponse)
            else if (type == 'meter')
              _buildMeterDetails(equipment as MeterResponse)
            else if (type == 'cabinet')
              _buildCabinetDetails(equipment as CabinetResponse),
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
                Navigator.pop(context);
                context.router.push(EquipmentDetailsRoute(
                  cabinet: type == 'cabinet' ? equipment : null,
                  meter: type == 'meter' ? equipment : null,
                  streetLight: type == 'streetLight' ? equipment : null,
                  mission: widget.mission,
                  source: SourceProvider.MaintenanceProvider,
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Voir détails',
                style: TextStyle(
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

// Ajouter les méthodes de détails
  Widget _buildLightDetails(StoreStreetLightResponse light) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildDetailRow(
            Icons.location_on, light.street?.name ?? 'Localisation inconnue'),
        _buildDetailRow(
            Icons.lightbulb, 'Type: ${light.streetLightType?.name ?? 'N/A'}'),
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

  Widget _buildEquipmentPopup(
      BuildContext context, dynamic equipment, String type) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              equipment.name ??
                  (type == 'streetLight' ? 'Lampadaire' : 'Équipement'),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            if (equipment.street?.name != null)
              Text(
                equipment.street!.name,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.router.push(EquipmentDetailsRoute(
                  cabinet: type == 'cabinet' ? equipment : null,
                  meter: type == 'meter' ? equipment : null,
                  streetLight: type == 'streetLight' ? equipment : null,
                  mission: widget.mission,
                  source: SourceProvider.MaintenanceProvider,
                ));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: context.colorScheme.primary,
              ),
              child: const Text('Voir détails',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, int count,
      {required Function(String) onTap}) {
    final isActive = _selectedType == label;
    return GestureDetector(
      onTap: () => onTap(label),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        alignment: Alignment.center,
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: isActive ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: primaryColor, width: 1.5),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.3),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Semantics(
          button: true,
          label: 'Filter by $label',
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(text: label),
                TextSpan(
                  text: ' ($count)',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ],
            ),
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
              color: isActive ? Colors.white : primaryColor,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox, size: 60, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Aucun équipement trouvé pour ce filtre.',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Future<File?> getLocalCabinetImageFile(String name) async {
    final appDir = await getTemporaryDirectory();
    final folderPath = '${appDir.path}/cabinets/$name';

    final directory = Directory(folderPath);
    if (await directory.exists()) {
      final files = directory.listSync().whereType<File>().toList();
      if (files.isNotEmpty) {
        return files.first;
      }
    }
    return null;
  }

  Widget _buildEquipmentCard({
    required String title,
    required String location,
    required String imageUrl,
    required bool isAsset,
    required VoidCallback onTap,
    required DateTime? createdAt,
  }) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.grey.withOpacity(0.3),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              // Image en plein écran
              Positioned.fill(
                child: isAsset
                    ? Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: imageUrl,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                        ),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade200,
                          child: const Icon(
                            Icons.broken_image,
                            color: Colors.grey,
                            size: 40,
                          ),
                        ),
                      ),
              ),
              // Overlay avec dégradé et informations
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withOpacity(0.4),
                        Colors.black.withOpacity(0.8),
                      ],
                      stops: const [0.0, 0.5, 1.0],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          title.isEmpty ? 'N/A' : title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        if (location.isNotEmpty)
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 14,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  location,
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        if (createdAt != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              'Créé le: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(createdAt!)}',
                              style: const TextStyle(
                                fontSize: 10,
                                color: Colors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: context.colorScheme.primary,
        elevation: 0,
        title: Text(
          _showMapView ? "Carte des équipements" : "Liste des équipements",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => widget.source == SourceProvider.LampFormProvider
              ? context.router.replaceAll([MissionRoute()])
              : context.router.pop(),
        ),
        actions: [
          IconButton(
            icon: Icon(_showMapView ? Icons.list : Icons.map),
            onPressed: _toggleView,
            tooltip: _showMapView ? "Voir la liste" : "Voir la carte",
          ),
        ],
      ),
      body: BlocConsumer<MissionCubit, MissionState>(
        listener: (context, state) {
          state.whenOrNull(
            loading: () => LoadingDialog.show(context: context),
            successEquipmentMaintenance: (response) {
              LoadingDialog.hide(context: context);
            },
            failure: (error) {
              LoadingDialog.hide(context: context);
              ApiErrorDialog.show(context: context, error: error);
            },
          );
        },
        builder: (context, state) {
          final meterList = state.whenOrNull(
                  successEquipmentMaintenance: (response) =>
                      response.data?.meter) ??
              [];
          final cabinetList = state.whenOrNull(
                  successEquipmentMaintenance: (response) =>
                      response.data?.cabinet) ??
              [];
          final streetLightList = state.whenOrNull(
                  successEquipmentMaintenance: (response) =>
                      response.data?.streetlight) ??
              [];

          final totalCount =
              cabinetList.length + meterList.length + streetLightList.length;

// Collecter toutes les positions valides
          final allPositions = <LatLng>[];

// Ajouter les positions des armoires
          allPositions.addAll(cabinetList
              .map((cabinet) => _parseCoordinates(cabinet.location))
              .where((pos) => pos != null)
              .cast<LatLng>());

// Ajouter les positions des compteurs
          allPositions.addAll(meterList
              .map((meter) => _parseCoordinates(meter.location))
              .where((pos) => pos != null)
              .cast<LatLng>());

// Ajouter les positions des lampadaires
          allPositions.addAll(streetLightList
              .map((streetLight) => _parseCoordinates(streetLight.location))
              .where((pos) => pos != null)
              .cast<LatLng>());

// Calculer le centre
          final center = allPositions.isNotEmpty
              ? LatLng(
                  allPositions
                          .map((pos) => pos.latitude)
                          .reduce((a, b) => a + b) /
                      allPositions.length,
                  allPositions
                          .map((pos) => pos.longitude)
                          .reduce((a, b) => a + b) /
                      allPositions.length,
                )
              : const LatLng(4.0511, 9.7679); // Douala par défaut

          // Triez les équipements par date de création (du plus récent au plus ancien)
          final sortedCabinets = [...cabinetList]..sort((a, b) =>
              b.createdAt?.compareTo(a.createdAt ?? DateTime(0)) ?? 0);
          final sortedMeters = [...meterList]..sort((a, b) =>
              b.createdAt?.compareTo(a.createdAt ?? DateTime(0)) ?? 0);
          final sortedStreetLights = [...streetLightList]..sort((a, b) =>
              b.createdAt?.compareTo(a.createdAt ?? DateTime(0)) ?? 0);

          return Column(
            children: [
              // Filtres
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                child: Row(
                  children: [
                    _buildFilterButton("Tous", totalCount,
                        onTap: _setSelectedType),
                    _buildFilterButton("Armoires", cabinetList.length,
                        onTap: _setSelectedType),
                    _buildFilterButton("Compteurs", meterList.length,
                        onTap: _setSelectedType),
                    _buildFilterButton("Lampadaires", streetLightList.length,
                        onTap: _setSelectedType),
                  ],
                ),
              ),
              Divider(
                height: 1,
                thickness: 1,
                color: Colors.grey.shade300,
                indent: 16,
                endIndent: 16,
              ),
              // Contenu principal
              Expanded(
                child: state.maybeWhen(
                  successEquipmentMaintenance: (_) {
                    final showCabinets =
                        _selectedType == "Armoires" || _selectedType == "Tous";
                    final showMeters =
                        _selectedType == "Compteurs" || _selectedType == "Tous";
                    final showStreetLights = _selectedType == "Lampadaires" ||
                        _selectedType == "Tous";

                    if (!showCabinets && !showMeters && !showStreetLights ||
                        (cabinetList.isEmpty &&
                            meterList.isEmpty &&
                            streetLightList.isEmpty)) {
                      return _buildEmptyState();
                    }

                    if (_showMapView) {
                      final markers = _buildMarkers(
                        cabinets: sortedCabinets,
                        meters: sortedMeters,
                        streetLights: sortedStreetLights,
                      );

                      return FlutterMap(
                        mapController: _mapController,
                        options: MapOptions(
                          initialCenter: center,
                          initialZoom: 17,
                          onTap: (_, __) {}, // rien à cacher
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.kes.skt.releccud',
                          ),
                          MarkerLayer(markers: markers),
                          // if (_locationLoaded)
                          //   ..._polylines.entries.map((entry) {
                          //     final endPos = entry.key;
                          //     final progress = _polylineProgress[endPos] ?? 0.0;
                          //     final points = entry.value;

                          //     if (points.length < 2)
                          //       return const SizedBox.shrink();

                          //     // Calculer le point intermédiaire basé sur la progression
                          //     final intermediatePoint = LatLng(
                          //       points[0].latitude +
                          //           (points[1].latitude - points[0].latitude) *
                          //               progress,
                          //       points[0].longitude +
                          //           (points[1].longitude -
                          //                   points[0].longitude) *
                          //               progress,
                          //     );

                          //     return PolylineLayer(
                          //       polylines: [
                          //         Polyline(
                          //           points: [points[0], intermediatePoint],
                          //           color: Colors.blue.withOpacity(0.7),
                          //           strokeWidth: 3.0,
                          //           // isDotted: true,
                          //         ),
                          //       ],
                          //     );
                          //   }).toList(),
                        ],
                      );
                    } else {
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          int crossAxisCount = constraints.maxWidth < 600
                              ? 2
                              : constraints.maxWidth < 900
                                  ? 3
                                  : 4;

                          // Si "Tous" est sélectionné, mélangez tous les équipements triés par date
                          if (_selectedType == "Tous") {
                            final allEquipments = [
                              ...sortedCabinets
                                  .map((e) => _EquipmentItem(e, 'cabinet')),
                              ...sortedMeters
                                  .map((e) => _EquipmentItem(e, 'meter')),
                              ...sortedStreetLights
                                  .map((e) => _EquipmentItem(e, 'streetLight')),
                            ]..sort((a, b) =>
                                b.item.createdAt?.compareTo(
                                    a.item.createdAt ?? DateTime(0)) ??
                                0);

                            return GridView.builder(
                              physics: const BouncingScrollPhysics(),
                              padding: EdgeInsets.all(
                                  constraints.maxWidth < 600 ? 8.0 : 16.0),
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: crossAxisCount,
                                crossAxisSpacing: 8,
                                mainAxisSpacing: 8,
                                childAspectRatio: 0.7,
                              ),
                              itemCount: allEquipments.length,
                              itemBuilder: (context, index) {
                                final item = allEquipments[index];
                                return _buildEquipmentCard(
                                  title:
                                      '${item.item.name ?? item.type.capitalize()}',
                                  location: item.item.street?.name ??
                                      'Localisation inconnue',
                                  imageUrl: item.type == 'cabinet'
                                      ? Assets.armoire
                                      : item.type == 'meter'
                                          ? Assets.compteur
                                          : Assets.lampadaire,
                                  isAsset: false,
                                  createdAt: item.item.createdAt,
                                  onTap: () =>
                                      context.router.push(EquipmentDetailsRoute(
                                    cabinet: item.type == 'cabinet'
                                        ? item.item
                                        : null,
                                    meter:
                                        item.type == 'meter' 
                                        ? item.item 
                                        : null,
                                    streetLight: item.type == 'streetLight'
                                        ? item.item
                                        : null,
                                    mission: widget.mission,
                                    source: SourceProvider.MaintenanceProvider,
                                  )),
                                );
                              },
                            );
                          }

                          // Sinon, affichez les équipements par catégorie triés par date
                          return GridView(
                            physics: const BouncingScrollPhysics(),
                            padding: EdgeInsets.all(
                                constraints.maxWidth < 600 ? 8.0 : 16.0),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              crossAxisSpacing: 8,
                              mainAxisSpacing: 8,
                              childAspectRatio: 0.7,
                            ),
                            children: [
                              if (showCabinets && sortedCabinets.isNotEmpty)
                                ...sortedCabinets.map(
                                  (cabinet) => FutureBuilder<File?>(
                                    future:
                                        getLocalCabinetImageFile(cabinet.name!),
                                    builder: (context, snapshot) {
                                      final localFile = snapshot.data;
                                      final imagePath = (localFile != null &&
                                              localFile.existsSync())
                                          ? localFile.path
                                          : Assets.armoire;

                                      final isAsset = localFile == null ||
                                          !localFile.existsSync();

                                      return _buildEquipmentCard(
                                        imageUrl: imagePath,
                                        isAsset: isAsset,
                                        title: '${cabinet.name ?? 'Armoire'}',
                                        location: cabinet.street?.name ??
                                            'Localisation inconnue',
                                        createdAt: cabinet.createdAt,
                                        onTap: () => context.router.push(
                                          EquipmentDetailsRoute(
                                            cabinet: cabinet,
                                            mission: widget.mission,
                                            source: SourceProvider.MaintenanceProvider,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              if (showMeters && sortedMeters.isNotEmpty)
                                ...sortedMeters.map(
                                  (meter) => _buildEquipmentCard(
                                    imageUrl: Assets.compteur,
                                    isAsset: false,
                                    title: '${meter.name ?? 'Compteur'}',
                                    location: meter.street?.name ??
                                        'Localisation inconnue',
                                    createdAt: meter.createdAt,
                                    onTap: () => context.router
                                        .push(EquipmentDetailsRoute(
                                      meter: meter,
                                      mission: widget.mission,
                                      source: SourceProvider.MaintenanceProvider,
                                    )),
                                  ),
                                ),
                              if (showStreetLights &&
                                  sortedStreetLights.isNotEmpty)
                                ...sortedStreetLights.map(
                                  (streetLight) => _buildEquipmentCard(
                                    imageUrl: Assets.lampadaire,
                                    isAsset: false,
                                    title:
                                        '${streetLight.name ?? 'Lampadaire'}',
                                    location: streetLight.street?.name ??
                                        'Localisation inconnue',
                                    createdAt: streetLight.createdAt,
                                    onTap: () => context.router
                                        .push(EquipmentDetailsRoute(
                                      streetLight: streetLight,
                                      mission: widget.mission,
                                      source: SourceProvider.MaintenanceProvider,
                                    )),
                                  ),
                                ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  orElse: () => _buildEmptyState(),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// Classe helper pour gérer les équipements mélangés
class _EquipmentItem {
  final dynamic item; // Peut être CabinetResponse, MeterResponse ou StoreStreetLightResponse
  final String type; // 'cabinet', 'meter' ou 'streetLight'

  _EquipmentItem(this.item, this.type);
}

// Extension pour capitaliser la première lettre d'une chaîne
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
