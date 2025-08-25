import 'package:auto_route/annotations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:latlong2/latlong.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/shared/components/app_drawer.dart';
import 'package:sopaki_app/src/shared/components/custom_appbar.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/responsive/screen.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

@RoutePage()
class MapScreen extends StatefulWidget {
  final CabinetResponse? cabinet;
  final MeterResponse? meter;
  final StoreStreetLightResponse? streetLight;
  final String? source;
  const MapScreen(
      {super.key, this.cabinet, this.meter, this.streetLight, this.source});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final MapController _mapController = MapController();
  List<Marker> _markers = [];
  String _selectedFilter = 'Tous';
  bool _isMapReady = false;

  // Initial position for the map (default location)
  static const LatLng initialPosition = LatLng(4.0511, 9.7605);

  // Function to parse location string and return latitude and longitude
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

  @override
  void initState() {
    super.initState();
  }

  void _loadMarkers() {
    List<Marker> markers = [];

    // Handle Cabinet
    if (widget.cabinet != null &&
        _selectedFilter != 'Lampadaire' &&
        _selectedFilter != 'Compteur') {
      final location = _parseLocation(widget.cabinet!.location);
      if (location != null) {
        markers.add(
          _buildEquipmentMarker(
            point: location,
            icon: Icons.electrical_services,
            color: Colors.blue,
            context: context,
            equipment: widget.cabinet!,
          ),
        );
      }
    }

    // Handle Meter
    if (widget.meter != null &&
        _selectedFilter != 'Lampadaire' &&
        _selectedFilter != 'Armoire') {
      final location = _parseLocation(widget.meter!.location);
      if (location != null) {
        markers.add(
          _buildEquipmentMarker(
            point: location,
            icon: Icons.speed,
            color: Colors.purple,
            context: context,
            equipment: widget.meter!,
          ),
        );
      }
    }

    // Handle StreetLight
    if (widget.streetLight != null &&
        _selectedFilter != 'Compteur' &&
        _selectedFilter != 'Armoire') {
      final location = _parseLocation(widget.streetLight!.location);
      if (location != null) {
        // Récupération des états avec valeur par défaut 0 si null
        final isOnDay = widget.streetLight!.isOnDay ?? 0;
        final isOnNight = widget.streetLight!.isOnNight ?? 0;

        // Détermination de la couleur selon la logique
        Color markerColor = Colors.green;
        if ((isOnDay == 1 && isOnNight == 0) ||
            (isOnDay == 0 && isOnNight == 0) ||
            (isOnDay == 1 && isOnNight == 1)) {
          markerColor = Colors.red;
        }

        markers.add(
          _buildEquipmentMarker(
            point: location,
            icon: Icons.lightbulb,
            color: markerColor,
            isLight: true,
            context: context,
            equipment: widget.streetLight!,
          ),
        );
      }
    }

    setState(() {
      _markers = markers;
    });

// Déplacez la caméra seulement si la carte est prête
    if (_isMapReady && markers.isNotEmpty) {
      _mapController.move(markers.first.point, 15);
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
      width: 20,
      height: 20,
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
              size: isLight ? 15 : 17,
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
                child:  CachedNetworkImage(
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
              _buildLightDetails(equipment as StoreStreetLightResponse)
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
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Fermer',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }

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

  Widget _buildFilterDropdown() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        children: [
          const Text(
            "Filtrer :",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 12),
          DropdownButton<String>(
            value: _selectedFilter,
            onChanged: (String? newValue) {
              if (newValue != null) {
                setState(() {
                  _selectedFilter = newValue;
                  _loadMarkers();
                });
              }
            },
            items: <String>['Tous', 'Lampadaire', 'Compteur', 'Armoire']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(hauteur(context, 50)),
        child: const CustomAppBar(
          title: "Vue de l'équipement",
          leadingIcon: Icons.arrow_back_ios,
        ),
      ),
      drawer: widget.source != SourceProvider.EquipmentDetailProvider
          ? const AppDrawer(selected: 3)
          : null,
      body: Column(
        children: [
          Visibility(
            visible: widget.source != SourceProvider.EquipmentDetailProvider,
            child: _buildFilterDropdown(),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: FlutterMap(
                  mapController: _mapController,
                  options: MapOptions(
                    initialCenter: initialPosition,
                    initialZoom: 14.0,
                    onMapReady: () {
                      // La carte est maintenant prête
                      setState(() {
                        _isMapReady = true;
                      });
                      // Redessin forcé pour éviter les tuiles invisibles au premier chargement
                      Future.delayed(Duration(milliseconds: 100), () {
                        final center = _mapController.camera.center;
                        final zoom = _mapController.camera.zoom;
                        _mapController.move(center, zoom);
                      });
                      _loadMarkers(); // Chargez les marqueurs maintenant
                    },
                  ),
                  children: [
                    TileLayer(
                      urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                      userAgentPackageName: 'com.kes.skt.releccud',
                    ),
                    MarkerLayer(markers: _markers),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
