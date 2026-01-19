import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/equipement/classes/reseau.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:latlong2/latlong.dart';

@RoutePage()
class NetworkDetailsScreen extends StatelessWidget {
  final IndividualNetwork network;
  final CabinetResponse? cabinet;
  final MeterResponse? meter;
  final List<StoreStreetLightResponse> streetLights;
  final MissionResponse mission;
  final String networkLabel; 

  const NetworkDetailsScreen(
      {super.key,
      required this.network,
      this.cabinet,
      this.meter,
      required this.streetLights,
      required this.networkLabel,
      required this.mission});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Détails du réseau $networkLabel',
          style: TextStyle(color: Colors.white),
        ),
        
        backgroundColor: context.colorScheme.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildNetworkHeader(context),
            const SizedBox(height: 24),
            if (meter != null) ...[
              _buildEquipmentSection(context,
                  title: "Compteur",
                  equipment: meter!,
                  // imageAsset: Assets.compteur,
                  imageAsset: meter!.photo ?? 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
                  icon: Icons.speed,
                  iconColor: Colors.purple,
                  onTap: () => context.router.push(EquipmentDetailsRoute(
                        meter: meter,
                        mission: mission,
                      ))),
              const SizedBox(height: 24),
            ],
            if (cabinet != null) ...[
              _buildEquipmentSection(context,
                  title: "Armoire",
                  equipment: cabinet!,
                  // imageAsset: Assets.armoire,
                  imageAsset: cabinet!.photo ?? 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
                  icon: Icons.electrical_services,
                  iconColor: Colors.blue,
                  onTap: () => context.router.push(EquipmentDetailsRoute(
                        cabinet: cabinet,
                        mission: mission,
                      ))),
              const SizedBox(height: 24),
            ],
            _buildStreetLightsSection(context),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

Widget _buildNetworkHeader(BuildContext context) {
  // 1. Collecter toutes les positions valides
  final equipmentLocations = <LatLng>[];
  final markers = <Marker>[];
  
  // 2. Déterminer le type de réseau
  final isCompleteNetwork = cabinet != null && meter != null;
  final isMeterOnlyNetwork = meter != null && cabinet == null;
  final isCabinetOnlyNetwork = cabinet != null && meter == null;

  // 3. Fonction pour ajouter un marqueur
  void addMarker(LatLng position, IconData icon, Color color, dynamic equipment, {bool isLight = false}) {
    markers.add(_buildEquipmentMarker(
      point: position,
      icon: icon,
      color: color,
      isLight: isLight,
      context: context,
      equipment: equipment,
    ));
  }

  // 4. Fonction pour parser les coordonnées
  LatLng? parseCoordinates(String? location) {
    if (location == null) return null;
    final coords = location.split(',');
    if (coords.length != 2) return null;
    final lat = double.tryParse(coords[0]);
    final lng = double.tryParse(coords[1]);
    return (lat != null && lng != null) ? LatLng(lat, lng) : null;
  }

  // 5. Traitement selon le type de réseau
  if (isCompleteNetwork) {
    // Réseau complet: lampadaires -> armoire -> compteur
    final cabinetPos = parseCoordinates(cabinet!.location);
    final meterPos = parseCoordinates(meter!.location);
    
    if (cabinetPos != null && meterPos != null) {
      // Ajouter les lampadaires
      for (final light in streetLights) {
        final lightPos = parseCoordinates(light.location);
        if (lightPos != null) {
          equipmentLocations.add(lightPos);
          addMarker(
            lightPos,
            Icons.lightbulb,
            _getLightColor(light),
            light,
            isLight: true,
          );
        }
      }
      
      // Ajouter l'armoire
      equipmentLocations.add(cabinetPos);
      addMarker(cabinetPos, Icons.electrical_services, Colors.blue, cabinet!);
      
      // Ajouter le compteur
      equipmentLocations.add(meterPos);
      addMarker(meterPos, Icons.speed, Colors.purple, meter!);
    }
  } 
  else if (isMeterOnlyNetwork) {
    // Réseau sans armoire: lampadaires -> compteur
    final meterPos = parseCoordinates(meter!.location);
    
    if (meterPos != null) {
      // Ajouter les lampadaires
      for (final light in streetLights) {
        final lightPos = parseCoordinates(light.location);
        if (lightPos != null) {
          equipmentLocations.add(lightPos);
          addMarker(
            lightPos,
            Icons.lightbulb,
            _getLightColor(light),
            light,
            isLight: true,
          );
        }
      }
      
      // Ajouter le compteur
      equipmentLocations.add(meterPos);
      addMarker(meterPos, Icons.speed, Colors.purple, meter!);
    }
  } 
  else if (isCabinetOnlyNetwork) {
    // Réseau sans compteur: lampadaires -> armoire
    final cabinetPos = parseCoordinates(cabinet!.location);
    
    if (cabinetPos != null) {
      // Ajouter les lampadaires
      for (final light in streetLights) {
        final lightPos = parseCoordinates(light.location);
        if (lightPos != null) {
          equipmentLocations.add(lightPos);
          addMarker(
            lightPos,
            Icons.lightbulb,
            _getLightColor(light),
            light,
            isLight: true,
          );
        }
      }
      
      // Ajouter l'armoire
      equipmentLocations.add(cabinetPos);
      addMarker(cabinetPos, Icons.electrical_services, Colors.blue, cabinet!);
    }
  }

  // 6. Calcul du centre de la carte
  final center = equipmentLocations.isNotEmpty
      ? LatLng(
          equipmentLocations.map((e) => e.latitude).reduce((a, b) => a + b) /
              equipmentLocations.length,
          equipmentLocations.map((e) => e.longitude).reduce((a, b) => a + b) /
              equipmentLocations.length,
        )
      : LatLng(0, 0);

  // 7. Construction de la carte
  return SizedBox(
    height: MediaQuery.of(context).size.height * 0.3,
    child: Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          width: 2,
          color: context.colorScheme.primary,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: FlutterMap(
          options: MapOptions(
            initialCenter: center,
            initialZoom: 17.0,
          ),
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              userAgentPackageName: 'com.kes.skt.releccud',
            ),
            if (equipmentLocations.length > 1)
              PolylineLayer(
                polylines: [
                  Polyline(
                    points: equipmentLocations,
                    color: context.colorScheme.primary,
                    strokeWidth: 2,
                  ),
                ],
              ),
            MarkerLayer(markers: markers),
          ],
        ),
      ),
    ),
  );
}

// Fonction helper pour déterminer la couleur des lampadaires
Color _getLightColor(StoreStreetLightResponse light) {
  final isOnDay = light.isOnDay ?? 0;
  final isOnNight = light.isOnNight ?? 0;

  if ((isOnDay == 1 && isOnNight == 0) ||
      (isOnDay == 0 && isOnNight == 0) ||
      (isOnDay == 1 && isOnNight == 1)) {
    return Colors.red;
  }
  return Colors.green;
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
                backgroundColor:
                    context.colorScheme.primary, // Couleur de fond bleue
                foregroundColor: Colors.white, // Couleur du texte blanc
                // Optionnel: ajouter du padding ou d'autres styles
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8), // Bordures arrondies
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
            const SizedBox(height: 40),
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

  Widget _buildEquipmentSection(
    BuildContext context, {
    required String title,
    required dynamic equipment,
    required String imageAsset,
    required IconData icon,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    final isCabinet = equipment is CabinetResponse;
    final isMeter = equipment is MeterResponse;

    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: iconColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: iconColor,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Icon(
                    icon,
                    size: 16,
                    color: iconColor,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
              side: BorderSide(
                width: 2,
                color: context.colorScheme.primary,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: context.colorScheme.primary.withOpacity(0.05),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child:CachedNetworkImage(
                            imageUrl: equipment.photo??'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
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
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                          ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          equipment.name ?? 'N/A',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        if (equipment.street?.name != null) ...[
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                size: 16,
                                color: context.colorScheme.primary
                                    .withOpacity(0.6),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                equipment.street!.name.length > 16
                                    ? '${equipment.street!.name.substring(0, 16)}...'
                                    : equipment.street!.name,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                        ],
                        if (isMeter) ...[
                          Text(
                            'Modèle: ${equipment.model ?? 'N/A'}',
                            style: const TextStyle(fontSize: 13),
                          ),
                          if (equipment.brand != null) ...[
                            Text(
                              'Marque: ${equipment.brand}',
                              style: const TextStyle(fontSize: 13),
                            ),
                          ],
                        ],
                        if (equipment.createdAt != null) ...[
                          const SizedBox(height: 4),
                          Text(
                            'Créé le: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(equipment.createdAt!)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.primary,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStreetLightsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.green.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.green,
                  width: 2,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.lightbulb,
                  size: 16,
                  color: Colors.green,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.2),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: Colors.red,
                  width: 2,
                ),
              ),
              child: const Center(
                child: Icon(
                  Icons.lightbulb,
                  size: 16,
                  color: Colors.red,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              'Lampadaires (${streetLights.length})',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...streetLights.map((light) => Card(
              margin: const EdgeInsets.only(bottom: 12),
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(
                  width: 2,
                  color: context.colorScheme.primary,
                ),
              ),
              child: InkWell(
                onTap: () => context.router.push(EquipmentDetailsRoute(
                  streetLight: light,
                  mission: mission,
                )),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: context.colorScheme.primary.withOpacity(0.05),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            imageUrl: light.photo??'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
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
                                child: Icon(
                                  Icons.broken_image,
                                  color: Colors.grey.shade400,
                                ),
                              ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              light.name ?? 'Lampadaire',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.colorScheme.primary,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 4),
                            if (light.street?.name != null) ...[
                              Row(
                                children: [
                                  Icon(
                                    Icons.location_on,
                                    size: 16,
                                    color: context.colorScheme.primary
                                        .withOpacity(0.6),
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    light.street!.name.length > 16
                                        ? '${light.street!.name.substring(0, 16)}...'
                                        : light.street!.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                            ],
                            Text(
                              'Type: ${light.streetLightType?.name ?? 'N/A'}',
                              style: const TextStyle(fontSize: 13),
                            ),
                            Text(
                              'Puissance: ${light.power ?? 'N/A'}W',
                              style: const TextStyle(fontSize: 13),
                            ),
                            if (light.createdAt != null) ...[
                              const SizedBox(height: 4),
                              Text(
                                'Créé le: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(light.createdAt!)}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: context.colorScheme.primary,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )),
      ],
    );
  }
}
