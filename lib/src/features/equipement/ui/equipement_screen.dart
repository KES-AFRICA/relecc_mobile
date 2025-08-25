import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/equipement/classes/reseau.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/features/mission/logic/controller/bloc/mission_cubit.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/shared/components/dialogs/api_error_dialog.dart';
import 'package:sopaki_app/src/shared/components/dialogs/dialog_builder.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

class _EquipmentItem {
  final dynamic item;
  final String type;
  final String? networkLabel;

  _EquipmentItem(this.item, this.type, {this.networkLabel});
}

class LocationFilters {
  final Set<String> selectedRues;
  final Set<String> selectedQuartiers;
  final Set<String> selectedCommunes;
  final DateTimeRange? dateRange;
  final String? selectedType; // Ajoutez cette ligne

  LocationFilters({
    Set<String>? selectedRues,
    Set<String>? selectedQuartiers,
    Set<String>? selectedCommunes,
    this.dateRange,
    this.selectedType, // Ajoutez cette ligne
  })  : selectedRues = selectedRues ?? {},
        selectedQuartiers = selectedQuartiers ?? {},
        selectedCommunes = selectedCommunes ?? {};

  LocationFilters copyWith({
    Set<String>? selectedRues,
    Set<String>? selectedQuartiers,
    Set<String>? selectedCommunes,
    DateTimeRange? dateRange,
    String? selectedType, // Ajoutez cette ligne
  }) {
    return LocationFilters(
      selectedRues: selectedRues ?? this.selectedRues,
      selectedQuartiers: selectedQuartiers ?? this.selectedQuartiers,
      selectedCommunes: selectedCommunes ?? this.selectedCommunes,
      dateRange: dateRange ?? this.dateRange,
      selectedType: selectedType ?? this.selectedType, // Ajoutez cette ligne
    );
  }

  bool get hasActiveFilters =>
      selectedRues.isNotEmpty ||
      selectedQuartiers.isNotEmpty ||
      selectedCommunes.isNotEmpty ||
      dateRange != null;

  bool matchesEquipment(dynamic equipment) {
    final street = equipment.street;
    if (street == null && hasActiveFilters) return false;

    bool matchesRue = selectedRues.isEmpty ||
        (street?.name != null && selectedRues.contains(street?.name));

    bool matchesQuartier = selectedQuartiers.isEmpty;
    if (!matchesQuartier && street != null) {
      if (street is Map) {
        matchesQuartier = (street['district'] != null &&
                selectedQuartiers.contains(street['district'])) ||
            (street['quartier'] != null &&
                selectedQuartiers.contains(street['quartier']));
      } else {
        try {
          matchesQuartier = (street.district != null &&
                  selectedQuartiers.contains(street.district)) ||
              (street.quartier != null &&
                  selectedQuartiers.contains(street.quartier));
        } catch (e) {
          matchesQuartier = false;
        }
      }
    }

    bool matchesCommune = selectedCommunes.isEmpty ||
        (street?.municipality != null &&
            selectedCommunes.contains(street?.municipality));

    bool matchesDate = true;
    if (dateRange != null && equipment.createdAt != null) {
      matchesDate = equipment.createdAt!.isAfter(dateRange!.start) &&
          equipment.createdAt!.isBefore(dateRange!.end);
    }

    return matchesRue && matchesQuartier && matchesCommune && matchesDate;
  }
}

@RoutePage<void>()
class EquipementScreen extends StatefulWidget implements AutoRouteWrapper {
  final MissionResponse mission;
  final String? source;

  const EquipementScreen({super.key, required this.mission, this.source});

  @override
  State<EquipementScreen> createState() => _EquipementScreenState();

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

class _EquipementScreenState extends State<EquipementScreen> {
  String _selectedType = "Tous";
  String _selectedNetworkType = "Tous Réseaux";
  bool _showNetworkView = false;
  List<NetworkSummary> networks = [];
  LocationFilters _locationFilters = LocationFilters();
  Map<String, String> _networkLabels = {};
  int _networkCounter = 1;
  bool _isLoadingNetworks = false;
   bool _isLoadingEquipment = false; 

@override
void initState() {
  super.initState();
  _isLoadingEquipment = true;
  if (widget.mission.id != null) {
    context.read<MissionCubit>().getAllEquipmentsMission(widget.mission.id!);
  } else {
    ApiErrorDialog.show(context: context, error: 'Mission ID is null');
  }
}

  void _setSelectedType(String type) {
    setState(() {
      _selectedType = type;
    });
  }

  void _setSelectedNetworkType(String type) {
    setState(() {
      _selectedNetworkType = type;
    });
  }



  String _getOrCreateNetworkLabel(String networkId) {
    if (!_networkLabels.containsKey(networkId)) {
      _networkLabels[networkId] = 'R${_networkCounter++}';
    }
    return _networkLabels[networkId]!;
  }

  String? _getEquipmentNetworkLabel(dynamic equipment) {
    for (final networkSummary in networks) {
      for (final network in networkSummary.networks) {
        bool belongsToNetwork = false;

        if (equipment is StoreStreetLightResponse) {
          belongsToNetwork = network.streetLightIds.contains(equipment.id);
        } else if (equipment is CabinetResponse) {
          belongsToNetwork = network.cabinetId == equipment.id;
        } else if (equipment is MeterResponse) {
          belongsToNetwork = network.meterId == equipment.id;
        }

        if (belongsToNetwork) {
          return _getOrCreateNetworkLabel(network.id);
        }
      }
    }
    return null;
  }

  Map<String, Set<String>> _extractFilterOptions(
    List<CabinetResponse> cabinets,
    List<MeterResponse> meters,
    List<StoreStreetLightResponse> streetLights,
  ) {
    final rues = <String>{};
    final quartiers = <String>{};
    final communes = <String>{};

    void extractFromStreet(dynamic street) {
      if (street != null) {
        if (street is Map) {
          if (street['name'] != null) rues.add(street['name']);
          if (street['district'] != null) quartiers.add(street['district']);
          if (street['quartier'] != null) quartiers.add(street['quartier']);
          if (street['municipality'] != null)
            communes.add(street['municipality']);
        } else {
          if (street.name != null) rues.add(street.name);
          try {
            if (street.district != null) quartiers.add(street.district);
          } catch (e) {}
          try {
            if (street.quartier != null) quartiers.add(street.quartier);
          } catch (e) {}
          try {
            if (street.municipality != null) communes.add(street.municipality);
          } catch (e) {}
        }
      }
    }

    for (final cabinet in cabinets) {
      extractFromStreet(cabinet.street);
    }
    for (final meter in meters) {
      extractFromStreet(meter.street);
    }
    for (final streetLight in streetLights) {
      extractFromStreet(streetLight.street);
    }

    return {
      'rues': rues,
      'quartiers': quartiers,
      'communes': communes,
    };
  }

Widget _buildLoadingIndicator() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).primaryColor),
        ),
        const SizedBox(height: 16),
        Text(
          _showNetworkView ? 'Chargement des réseaux...' : 'Chargement des équipements...',
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    ),
  );
}

  Future<void> _showFilterModal() async {
    final state = context.read<MissionCubit>().state;

    state.whenOrNull(
      successEquipment: (response) async {
        final meterList = response.data?.meters ?? [];
        final cabinetList = response.data?.cabinets ?? [];
        final streetLightList = response.data?.streetlights ?? [];

        final filterOptions =
            _extractFilterOptions(cabinetList, meterList, streetLightList);

        final newFilters = await showModalBottomSheet<LocationFilters>(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.transparent,
          builder: (context) => _FilterModal(
            isNetworkView: _showNetworkView,
            filterOptions: filterOptions,
            currentFilters: _locationFilters,
            allCabinets: cabinetList,
            allMeters: meterList,
            allStreetLights: streetLightList,
            onTypeSelected:
                _showNetworkView ? _setSelectedNetworkType : _setSelectedType,
          ),
        );

        if (newFilters != null) {
          setState(() {
            _locationFilters = newFilters;
          });
        }
      },
    );
  }

  List<NetworkSummary> _calculateNetworks(
    List<CabinetResponse> cabinets,
    List<MeterResponse> meters,
    List<StoreStreetLightResponse> streetLights,
  ) {
    final filteredCabinets =
        cabinets.where(_locationFilters.matchesEquipment).toList();
    final filteredMeters =
        meters.where(_locationFilters.matchesEquipment).toList();
    final filteredStreetLights =
        streetLights.where(_locationFilters.matchesEquipment).toList();

    final completeNetworks = <IndividualNetwork>[];
    final meterOnlyNetworks = <IndividualNetwork>[];
    final cabinetOnlyNetworks = <IndividualNetwork>[];

    // ✅ CORRECTION 1: Créer un map des relations armoire-compteur
    final cabinetToMeterMap = <int, int>{};

    // D'abord, identifier toutes les relations armoire-compteur existantes
    for (final light in filteredStreetLights) {
      if (light.cabinetId != null && light.meterId != null) {
        cabinetToMeterMap[light.cabinetId!] = light.meterId!;
      }
    }

    // ✅ CORRECTION 2: Regrouper TOUS les lampadaires par armoire d'abord
    final cabinetGroups = <int, List<StoreStreetLightResponse>>{};
    for (final light
        in filteredStreetLights.where((l) => l.cabinetId != null)) {
      cabinetGroups.putIfAbsent(light.cabinetId!, () => []).add(light);
    }

    // ✅ CORRECTION 3: Regrouper les lampadaires sans armoire par compteur
    final meterOnlyGroups = <int, List<StoreStreetLightResponse>>{};
    for (final light in filteredStreetLights
        .where((l) => l.cabinetId == null && l.meterId != null)) {
      meterOnlyGroups.putIfAbsent(light.meterId!, () => []).add(light);
    }

    // ✅ CORRECTION 4: Traiter les groupes d'armoires
    cabinetGroups.forEach((cabinetId, lights) {
      final cabinet = filteredCabinets.firstWhere((c) => c.id == cabinetId);

      // Vérifier si cette armoire est liée à un compteur
      final meterId = cabinetToMeterMap[cabinetId];

      if (meterId != null) {
        // ✅ Réseau complet : armoire + compteur + lampadaires
        final meter = filteredMeters.firstWhere((m) => m.id == meterId);

        completeNetworks.add(IndividualNetwork(
          id: '${cabinetId}_${meterId}',
          type: "complet",
          cabinetId: cabinetId,
          meterId: meterId,
          streetLightCount: lights.length,
          location: _getLocation(lights),
          streetLightIds: lights.map((l) => l.id).whereType<int>().toList(),
        ));
      } else {
        // ✅ Réseau armoire seule (pas de compteur associé)
        cabinetOnlyNetworks.add(IndividualNetwork(
          id: 'cabinet_$cabinetId',
          type: "armoire sans compteur",
          cabinetId: cabinetId,
          streetLightCount: lights.length,
          location: _getLocation(lights),
          streetLightIds: lights.map((l) => l.id).whereType<int>().toList(),
        ));
      }
    });

    // ✅ CORRECTION 5: Traiter les compteurs seuls (sans armoire)
    meterOnlyGroups.forEach((meterId, lights) {
      final meter = filteredMeters.firstWhere((m) => m.id == meterId);

      meterOnlyNetworks.add(IndividualNetwork(
        id: 'meter_$meterId',
        type: "compteur sans armoire",
        meterId: meterId,
        streetLightCount: lights.length,
        location: _getLocation(lights),
        streetLightIds: lights.map((l) => l.id).whereType<int>().toList(),
      ));
    });

    // ✅ CORRECTION 6: Trier chaque type de réseau par date du dernier équipement
    completeNetworks.sort((a, b) => _getLastEquipmentDate(
            b, filteredCabinets, filteredMeters, filteredStreetLights)
        .compareTo(_getLastEquipmentDate(
            a, filteredCabinets, filteredMeters, filteredStreetLights)));

    meterOnlyNetworks.sort((a, b) => _getLastEquipmentDate(
            b, filteredCabinets, filteredMeters, filteredStreetLights)
        .compareTo(_getLastEquipmentDate(
            a, filteredCabinets, filteredMeters, filteredStreetLights)));

    cabinetOnlyNetworks.sort((a, b) => _getLastEquipmentDate(
            b, filteredCabinets, filteredMeters, filteredStreetLights)
        .compareTo(_getLastEquipmentDate(
            a, filteredCabinets, filteredMeters, filteredStreetLights)));

    return [
      NetworkSummary(
        type: "complet",
        count: completeNetworks.length,
        cabinetCount: completeNetworks.length,
        meterCount: completeNetworks.length,
        streetLightCount:
            completeNetworks.fold(0, (sum, n) => sum + n.streetLightCount),
        networks: completeNetworks,
      ),
      NetworkSummary(
        type: "compteur sans armoire",
        count: meterOnlyNetworks.length,
        cabinetCount: 0,
        meterCount: meterOnlyNetworks.length,
        streetLightCount:
            meterOnlyNetworks.fold(0, (sum, n) => sum + n.streetLightCount),
        networks: meterOnlyNetworks,
      ),
      NetworkSummary(
        type: "armoire sans compteur",
        count: cabinetOnlyNetworks.length,
        cabinetCount: cabinetOnlyNetworks.length,
        meterCount: 0,
        streetLightCount:
            cabinetOnlyNetworks.fold(0, (sum, n) => sum + n.streetLightCount),
        networks: cabinetOnlyNetworks,
      ),
    ];
  }

Future<void> _calculateNetworksAsync() async {
  setState(() {
    _isLoadingNetworks = true;
  });

  final state = context.read<MissionCubit>().state;
  await state.whenOrNull(
    successEquipment: (response) async {
      final meterList = response.data?.meters ?? [];
      final cabinetList = response.data?.cabinets ?? [];
      final streetLightList = response.data?.streetlights ?? [];

      // ✅ Utiliser un délai pour montrer le loading (optionnel)
      await Future.delayed(const Duration(milliseconds: 100));

      networks = _calculateNetworks(cabinetList, meterList, streetLightList);

      if (mounted) {
        setState(() {
          _isLoadingNetworks = false;
        });
      }
    },
  );
}

void _toggleView() {
  setState(() {
    _showNetworkView = !_showNetworkView;
    if (_showNetworkView) {
      _isLoadingNetworks = true;
      _calculateNetworksAsync();
    }
  });
}

  // ✅ NOUVELLE FONCTION: Obtenir la date du dernier équipement d'un réseau
  DateTime _getLastEquipmentDate(
    IndividualNetwork network,
    List<CabinetResponse> cabinets,
    List<MeterResponse> meters,
    List<StoreStreetLightResponse> streetLights,
  ) {
    DateTime? lastDate;

    // Vérifier l'armoire
    if (network.cabinetId != null) {
      final cabinet = cabinets.firstWhere((c) => c.id == network.cabinetId);
      if (cabinet.createdAt != null) {
        lastDate = cabinet.createdAt;
      }
    }

    // Vérifier le compteur
    if (network.meterId != null) {
      final meter = meters.firstWhere((m) => m.id == network.meterId);
      if (meter.createdAt != null &&
          (lastDate == null || meter.createdAt!.isAfter(lastDate))) {
        lastDate = meter.createdAt;
      }
    }

    // Vérifier tous les lampadaires du réseau
    final networkStreetLights = streetLights
        .where((light) => network.streetLightIds.contains(light.id))
        .toList();

    for (final light in networkStreetLights) {
      if (light.createdAt != null &&
          (lastDate == null || light.createdAt!.isAfter(lastDate))) {
        lastDate = light.createdAt;
      }
    }

    return lastDate ?? DateTime(0); // Date par défaut si aucune date trouvée
  }

  String? _getLocation(List<StoreStreetLightResponse> lights) {
    for (final light in lights) {
      final street = light.street;
      if (street != null) {
        if (street is Map) {
          if (street.name != null) return street.name;
        } else {
          if (street.name != null) return street.name;
        }
      }
    }
    return null;
  }

  Widget _buildNoResultsWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 60, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'Aucun résultat ne correspond à vos filtres',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey.shade600,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _locationFilters = LocationFilters();
                _selectedType = "Tous";
                _selectedNetworkType = "Tous Réseaux";
              });
            },
            child: const Text('Réinitialiser les filtres'),
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
    String? networkLabel,
  }) {
      final effectiveImageUrl = imageUrl.isNotEmpty 
      ? imageUrl 
      : 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg';
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
              Positioned.fill(
                child: isAsset
                    ? Image.asset(
                        imageUrl,
                        fit: BoxFit.cover,
                      )
                    : CachedNetworkImage(
                        imageUrl: effectiveImageUrl,
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
                          networkLabel != null
                              ? '${title.isEmpty ? 'N/A' : title}, $networkLabel'
                              : (title.isEmpty ? 'N/A' : title),
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

  Widget _buildIndividualNetworkCard(IndividualNetwork network,
      {List<CabinetResponse>? cabinets,
      List<MeterResponse>? meters,
      List<StoreStreetLightResponse>? streetLights}) {
    final cabinet = network.cabinetId != null && cabinets != null
        ? cabinets.firstWhere((c) => c.id == network.cabinetId)
        : null;

    final meter = network.meterId != null && meters != null
        ? meters.firstWhere((m) => m.id == network.meterId)
        : null;

    final networkStreetLights = streetLights
        ?.where((light) => network.streetLightIds.contains(light.id))
        .toList();

    DateTime? lastUpdated;
    dynamic lastEquipment;

    if (cabinet?.createdAt != null) {
      lastUpdated = cabinet!.createdAt;
      lastEquipment = cabinet;
    }

    if (meter?.createdAt != null &&
        (lastUpdated == null || meter!.createdAt!.isAfter(lastUpdated))) {
      lastUpdated = meter?.createdAt;
      lastEquipment = meter;
    }

    if (networkStreetLights != null) {
      for (final light in networkStreetLights) {
        if (light.createdAt != null &&
            (lastUpdated == null || light.createdAt!.isAfter(lastUpdated))) {
          lastUpdated = light.createdAt;
          lastEquipment = light;
        }
      }
    }

    final networkLabel = _getOrCreateNetworkLabel(network.id);

    return InkWell(
      onTap: () {
        final networkLabel = _getOrCreateNetworkLabel(network.id);
        context.router.push(
          NetworkDetailsRoute(
            network: network,
            cabinet: cabinet,
            meter: meter,
            streetLights: networkStreetLights ?? [],
            mission: widget.mission,
            networkLabel: networkLabel,
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(
            color: context.colorScheme.primary,
            width: 2,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            networkLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          network.type,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: context.colorScheme.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${network.streetLightCount} lamp.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                  // if (lastEquipment != null)
                  //   ClipRRect(
                  //     borderRadius: BorderRadius.circular(12),
                  //     child: Image.asset(
                  //       // lastEquipment is CabinetResponse
                  //       //     ? Assets.armoire
                  //       //     : lastEquipment is MeterResponse
                  //       //         ? Assets.compteur
                  //       //         : Assets.lampadaire,
                  //       lastEquipment.photo,
                  //       width: 40,
                  //       height: 40,
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  if (lastEquipment != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: lastEquipment.photo ?? 'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: Colors.grey.shade200,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: context.colorScheme.primary,
                            strokeWidth: 2,
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade200,
                        child: Icon(
                          Icons.broken_image,
                          color: Colors.grey.shade400,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if (network.location != null) ...[
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(Icons.location_on,
                        size: 16, color: context.colorScheme.primary),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        network.location!,
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                  ],
                ),
              ],
              if (lastUpdated != null) ...[
                const SizedBox(height: 8),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: context.colorScheme.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Dernier équipement: ${DateFormat('dd/MM/yyyy HH:mm:ss').format(lastUpdated)}',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
              if (network.cabinetId != null || network.meterId != null) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    if (network.cabinetId != null)
                      _buildNetworkChip(
                        icon:
                            Image.asset(Assets.armoire, width: 20, height: 20),
                        label: 'Armoire ${cabinet?.name}',
                        context: context,
                      ),
                    if (network.meterId != null)
                      _buildNetworkChip(
                        icon:
                            Image.asset(Assets.compteur, width: 20, height: 20),
                        label: 'Compteur ${meter?.name}',
                        context: context,
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNetworkChip({
    required Widget icon,
    required String label,
    required BuildContext context,
  }) {
    return Chip(
      backgroundColor: context.colorScheme.primary.withOpacity(0.1),
      labelPadding: const EdgeInsets.symmetric(horizontal: 4),
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          icon,
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }

// ✅ CORRECTION 7: Modifier _getFilteredNetworks pour respecter le tri
  List<IndividualNetwork> _getFilteredNetworks(List<NetworkSummary> networks) {
    List<IndividualNetwork> networksToShow = [];

    if (_selectedNetworkType == "Tous Réseaux") {
      // Récupérer tous les réseaux et les trier par date globalement
      networksToShow = networks.expand((n) => n.networks).toList();

      // ✅ Tri global par date du dernier équipement
      final state = context.read<MissionCubit>().state;
      state.whenOrNull(
        successEquipment: (response) {
          final meterList = response.data?.meters ?? [];
          final cabinetList = response.data?.cabinets ?? [];
          final streetLightList = response.data?.streetlights ?? [];

          networksToShow.sort((a, b) =>
              _getLastEquipmentDate(b, cabinetList, meterList, streetLightList)
                  .compareTo(_getLastEquipmentDate(
                      a, cabinetList, meterList, streetLightList)));
        },
      );
    } else if (_selectedNetworkType == "complets") {
      networksToShow = networks.firstWhere((n) => n.type == "complet").networks;
    } else if (_selectedNetworkType == "sans compteur") {
      networksToShow = networks
          .firstWhere((n) => n.type == "armoire sans compteur")
          .networks;
    } else if (_selectedNetworkType == "sans armoire") {
      networksToShow = networks
          .firstWhere((n) => n.type == "compteur sans armoire")
          .networks;
    }

    return networksToShow;
  }

  Widget _buildNetworkView(
    List<IndividualNetwork> networks, {
    required List<CabinetResponse> cabinets,
    required List<MeterResponse> meters,
    required List<StoreStreetLightResponse> streetLights,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: ListView.builder(
        padding: const EdgeInsets.only(bottom: 16),
        itemCount: networks.length,
        itemBuilder: (context, index) {
          final network = networks[index];
          return _buildIndividualNetworkCard(
            network,
            cabinets: cabinets,
            meters: meters,
            streetLights: streetLights,
          );
        },
      ),
    );
  }

  Widget _buildEquipmentView({
    required bool showCabinets,
    required bool showMeters,
    required bool showStreetLights,
    required List<CabinetResponse> sortedCabinets,
    required List<MeterResponse> sortedMeters,
    required List<StoreStreetLightResponse> sortedStreetLights,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth < 600
            ? 2
            : constraints.maxWidth < 900
                ? 3
                : 4;

        if (_selectedType == "Tous") {
          final allEquipments = [
            ...sortedCabinets.map((e) => _EquipmentItem(e, 'cabinet',
                networkLabel: _getEquipmentNetworkLabel(e))),
            ...sortedMeters.map((e) => _EquipmentItem(e, 'meter',
                networkLabel: _getEquipmentNetworkLabel(e))),
            ...sortedStreetLights.map((e) => _EquipmentItem(e, 'streetLight',
                networkLabel: _getEquipmentNetworkLabel(e))),
          ]..sort((a, b) =>
              b.item.createdAt?.compareTo(a.item.createdAt ?? DateTime(0)) ??
              0);

          return GridView.builder(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(constraints.maxWidth < 600 ? 8.0 : 16.0),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.7,
            ),
            itemCount: allEquipments.length,
            itemBuilder: (context, index) {
              final item = allEquipments[index];
              return _buildEquipmentCard(
                title: '${item.item.name ?? item.type.capitalize()}',
                location: item.item.street?.name ?? 'Localisation inconnue',
                // imageUrl: item.type == 'cabinet'
                //     ? Assets.armoire
                //     : item.type == 'meter'
                //         ? Assets.compteur
                //         : Assets.lampadaire,
                imageUrl: item.item.photo??'',
                isAsset: false,
                createdAt: item.item.createdAt,
                networkLabel: item.networkLabel,
                onTap: () => context.router.push(EquipmentDetailsRoute(
                  cabinet: item.type == 'cabinet' ? item.item : null,
                  meter: item.type == 'meter' ? item.item : null,
                  streetLight: item.type == 'streetLight' ? item.item : null,
                  mission: widget.mission,
                )),
              );
            },
          );
        }

        return GridView(
          physics: const BouncingScrollPhysics(),
          padding: EdgeInsets.all(constraints.maxWidth < 600 ? 8.0 : 16.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.7,
          ),
          children: [
            // if (showCabinets && sortedCabinets.isNotEmpty)
            //   ...sortedCabinets.map(
            //     (cabinet) => FutureBuilder<File?>(
            //       future: getLocalCabinetImageFile(cabinet.name!),
            //       builder: (context, snapshot) {
            //         final localFile = snapshot.data;
            //         final imagePath =
            //             (localFile != null && localFile.existsSync())
            //                 ? localFile.path
            //                 : Assets.armoire;

            //         final isAsset =
            //             localFile == null || !localFile.existsSync();

            //         return _buildEquipmentCard(
            //           imageUrl: imagePath,
            //           isAsset: isAsset,
            //           title: '${cabinet.name ?? 'Armoire'}',
            //           location: cabinet.street?.name ?? 'Localisation inconnue',
            //           createdAt: cabinet.createdAt,
            //           networkLabel: _getEquipmentNetworkLabel(cabinet),
            //           onTap: () => context.router.push(
            //             EquipmentDetailsRoute(
            //               cabinet: cabinet,
            //               mission: widget.mission,
            //               networkLabel: _getEquipmentNetworkLabel(cabinet),
            //             ),
            //           ),
            //         );
            //       },
            //     ),
            //   ),
            if (showCabinets && sortedCabinets.isNotEmpty)
              ...sortedCabinets.map(
                (cabinet) => _buildEquipmentCard(
                  imageUrl: cabinet.photo ?? '', // Utilisez directement cabinet.photo
                  title: '${cabinet.name ?? 'Armoire'}',
                  location: cabinet.street?.name ?? 'Localisation inconnue',
                  isAsset: false,
                  createdAt: cabinet.createdAt,
                  networkLabel: _getEquipmentNetworkLabel(cabinet),
                  onTap: () => context.router.push(
                    EquipmentDetailsRoute(
                      cabinet: cabinet,
                      mission: widget.mission,
                      networkLabel: _getEquipmentNetworkLabel(cabinet),
                    ),
                  ),
                ),
              ),
            if (showMeters && sortedMeters.isNotEmpty)
              ...sortedMeters.map(
                (meter) => _buildEquipmentCard(
                  // imageUrl: Assets.compteur,
                  imageUrl: meter.photo ?? '',
                  isAsset: false,
                  title: '${meter.name ?? 'Compteur'}',
                  location: meter.street?.name ?? 'Localisation inconnue',
                  createdAt: meter.createdAt,
                  networkLabel: _getEquipmentNetworkLabel(meter),
                  onTap: () => context.router.push(EquipmentDetailsRoute(
                    meter: meter,
                    mission: widget.mission,
                    networkLabel: _getEquipmentNetworkLabel(meter),
                  )),
                ),
              ),
            if (showStreetLights && sortedStreetLights.isNotEmpty)
              ...sortedStreetLights.map(
                (streetLight) => _buildEquipmentCard(
                  // imageUrl: Assets.lampadaire,
                  imageUrl: streetLight.photo ??'',
                  isAsset: false,
                  title: '${streetLight.name ?? 'Lampadaire'}',
                  location: streetLight.street?.name ?? 'Localisation inconnue',
                  createdAt: streetLight.createdAt,
                  networkLabel: _getEquipmentNetworkLabel(streetLight),
                  onTap: () => context.router.push(EquipmentDetailsRoute(
                    streetLight: streetLight,
                    mission: widget.mission,
                    networkLabel: _getEquipmentNetworkLabel(streetLight),
                  )),
                ),
              ),
          ],
        );
      },
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
        _showNetworkView ? "Réseaux" : "Équipements",
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
          icon: Icon(_showNetworkView ? Icons.list : Icons.graphic_eq),
          onPressed: _toggleView,
          tooltip:
              _showNetworkView ? "Voir les équipements" : "Voir les réseaux",
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton(
      onPressed: _showFilterModal,
      backgroundColor: context.colorScheme.primary,
      child: Stack(
        children: [
          const Icon(Icons.filter_list, color: Colors.white),
          if (_locationFilters.hasActiveFilters)
            Positioned(
              right: 0,
              top: 0,
              child: Container(
                width: 12,
                height: 12,
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: const Center(
                  child: Text(
                    '!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    ),
    body: BlocConsumer<MissionCubit, MissionState>(
      listener: (context, state) {
        state.whenOrNull(
          loading: () {
            // ✅ CORRECTION: Ne pas montrer le dialog de loading pour les réseaux
            if (!_showNetworkView) {
              LoadingDialog.show(context: context);
            }
          },
          successEquipment: (_) {
             setState(() {
          _isLoadingEquipment = false;
        });
            LoadingDialog.hide(context: context);
            // ✅ CORRECTION: Déclencher le calcul des réseaux de manière asynchrone
            if (_showNetworkView && !_isLoadingNetworks) {
              _calculateNetworksAsync();
            }
          },
          failure: (error) {
            LoadingDialog.hide(context: context);
            setState(() {
              _isLoadingEquipment = false;
              _isLoadingNetworks = false;
            });
            ApiErrorDialog.show(context: context, error: error);
          },
        );
      },
      builder: (context, state) {
            // Afficher le loader pour les équipements
    if (!_showNetworkView && _isLoadingEquipment) {
      return _buildLoadingIndicator();
    }
        // ✅ CORRECTION: Vérifier l'état de loading des réseaux EN PREMIER
        if (_showNetworkView && _isLoadingNetworks) {
          return _buildLoadingIndicator();
        }

        final meterList = state.whenOrNull(
                successEquipment: (response) => response.data?.meters) ??
            [];
        final cabinetList = state.whenOrNull(
                successEquipment: (response) => response.data?.cabinets) ??
            [];
        final streetLightList = state.whenOrNull(
                successEquipment: (response) =>
                    response.data?.streetlights) ??
            [];

        final filteredCabinets =
            cabinetList.where(_locationFilters.matchesEquipment).toList();
        final filteredMeters =
            meterList.where(_locationFilters.matchesEquipment).toList();
        final filteredStreetLights =
            streetLightList.where(_locationFilters.matchesEquipment).toList();

        final totalCount = filteredCabinets.length +
            filteredMeters.length +
            filteredStreetLights.length;

        final sortedCabinets = [...filteredCabinets]..sort((a, b) =>
            b.createdAt?.compareTo(a.createdAt ?? DateTime(0)) ?? 0);
        final sortedMeters = [...filteredMeters]..sort((a, b) =>
            b.createdAt?.compareTo(a.createdAt ?? DateTime(0)) ?? 0);
        final sortedStreetLights = [...filteredStreetLights]..sort((a, b) =>
            b.createdAt?.compareTo(a.createdAt ?? DateTime(0)) ?? 0);

        if (_showNetworkView) {
          final networksToShow = _getFilteredNetworks(networks);

          if (networksToShow.isEmpty && _locationFilters.hasActiveFilters) {
            return _buildNoResultsWidget();
          }

          return _buildNetworkView(
            networksToShow,
            cabinets: sortedCabinets,
            meters: sortedMeters,
            streetLights: sortedStreetLights,
          );
        } else {
          final showCabinets =
              _selectedType == "Armoires" || _selectedType == "Tous";
          final showMeters =
              _selectedType == "Compteurs" || _selectedType == "Tous";
          final showStreetLights =
              _selectedType == "Lampadaires" || _selectedType == "Tous";

          final hasNoResults = (showCabinets && filteredCabinets.isEmpty) &&
              (showMeters && filteredMeters.isEmpty) &&
              (showStreetLights && filteredStreetLights.isEmpty);

          if (hasNoResults && _locationFilters.hasActiveFilters) {
            return _buildNoResultsWidget();
          }

          return _buildEquipmentView(
            showCabinets: showCabinets,
            showMeters: showMeters,
            showStreetLights: showStreetLights,
            sortedCabinets: sortedCabinets,
            sortedMeters: sortedMeters,
            sortedStreetLights: sortedStreetLights,
          );
        }
      },
    ),
  );
}
}
class _FilterModal extends StatefulWidget {
  final bool isNetworkView;
  final Map<String, Set<String>> filterOptions;
  final LocationFilters currentFilters;
  final List<CabinetResponse> allCabinets;
  final List<MeterResponse> allMeters;
  final List<StoreStreetLightResponse> allStreetLights;
  final Function(String)? onTypeSelected;

  const _FilterModal({
    required this.isNetworkView,
    required this.filterOptions,
    required this.currentFilters,
    required this.allCabinets,
    required this.allMeters,
    required this.allStreetLights,
    this.onTypeSelected,
  });

  @override
  State<_FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<_FilterModal> {
  late LocationFilters _tempFilters;
  DateTimeRange? _selectedDateRange;
  String _selectedEquipmentType = "Tous";
  String _selectedNetworkType = "Tous Réseaux";

  @override
  void initState() {
    super.initState();
    _tempFilters = LocationFilters(
      selectedRues: Set.from(widget.currentFilters.selectedRues),
      selectedQuartiers: Set.from(widget.currentFilters.selectedQuartiers),
      selectedCommunes: Set.from(widget.currentFilters.selectedCommunes),
      dateRange: widget.currentFilters.dateRange,
    );
    _selectedDateRange = widget.currentFilters.dateRange;
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      initialDateRange: _selectedDateRange,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _selectedDateRange = picked;
        _tempFilters = _tempFilters.copyWith(dateRange: picked);
      });
    }
  }

  Widget _buildFilterSection(
    String title,
    Set<String> options,
    Set<String> selected,
    Function(Set<String>) onChanged,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: options.map((option) {
            final isSelected = selected.contains(option);
            return FilterChip(
              label: Text(
                option,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black,
                ),
              ),
              selected: isSelected,
              onSelected: (bool value) {
                final newSelected = Set<String>.from(selected);
                if (value) {
                  newSelected.add(option);
                } else {
                  newSelected.remove(option);
                }
                onChanged(newSelected);
              },
              selectedColor: Theme.of(context).primaryColor,
              checkmarkColor: Colors.white,
              backgroundColor: Colors.white,
              shape: StadiumBorder(
                side: BorderSide(
                  color: Theme.of(context).primaryColor,
                  width: 1,
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNetworkTypeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Type de réseau',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            _buildFilterChip(
              label: "Tous Réseaux",
              selected: _selectedNetworkType == "Tous Réseaux",
              onSelected: (selected) {
                setState(() {
                  _selectedNetworkType =
                      selected ? "Tous Réseaux" : _selectedNetworkType;
                });
                widget.onTypeSelected?.call("Tous Réseaux");
              },
            ),
            _buildFilterChip(
              label: "complets",
              selected: _selectedNetworkType == "complets",
              onSelected: (selected) {
                setState(() {
                  _selectedNetworkType =
                      selected ? "complets" : _selectedNetworkType;
                });
                widget.onTypeSelected?.call("complets");
              },
            ),
            _buildFilterChip(
              label: "sans compteur",
              selected: _selectedNetworkType == "sans compteur",
              onSelected: (selected) {
                setState(() {
                  _selectedNetworkType =
                      selected ? "sans compteur" : _selectedNetworkType;
                });
                widget.onTypeSelected?.call("sans compteur");
              },
            ),
            _buildFilterChip(
              label: "sans armoire",
              selected: _selectedNetworkType == "sans armoire",
              onSelected: (selected) {
                setState(() {
                  _selectedNetworkType =
                      selected ? "sans armoire" : _selectedNetworkType;
                });
                widget.onTypeSelected?.call("sans armoire");
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEquipmentTypeFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Type d\'équipement',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: [
            _buildFilterChip(
              label: "Tous",
              selected: _selectedEquipmentType == "Tous",
              onSelected: (selected) {
                setState(() {
                  _selectedEquipmentType =
                      selected ? "Tous" : _selectedEquipmentType;
                });
                widget.onTypeSelected?.call("Tous");
              },
            ),
            _buildFilterChip(
              label: "Armoires",
              selected: _selectedEquipmentType == "Armoires",
              onSelected: (selected) {
                setState(() {
                  _selectedEquipmentType =
                      selected ? "Armoires" : _selectedEquipmentType;
                });
                widget.onTypeSelected?.call("Armoires");
              },
            ),
            _buildFilterChip(
              label: "Compteurs",
              selected: _selectedEquipmentType == "Compteurs",
              onSelected: (selected) {
                setState(() {
                  _selectedEquipmentType =
                      selected ? "Compteurs" : _selectedEquipmentType;
                });
                widget.onTypeSelected?.call("Compteurs");
              },
            ),
            _buildFilterChip(
              label: "Lampadaires",
              selected: _selectedEquipmentType == "Lampadaires",
              onSelected: (selected) {
                setState(() {
                  _selectedEquipmentType =
                      selected ? "Lampadaires" : _selectedEquipmentType;
                });
                widget.onTypeSelected?.call("Lampadaires");
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String label,
    required bool selected,
    required Function(bool) onSelected,
  }) {
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: selected ? Colors.white : Colors.black,
        ),
      ),
      selected: selected,
      onSelected: onSelected,
      selectedColor: Theme.of(context).primaryColor,
      checkmarkColor: Colors.white,
      backgroundColor: Colors.white,
      shape: StadiumBorder(
        side: BorderSide(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
    );
  }

  Widget _buildDateFilter() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Période',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        OutlinedButton(
          onPressed: () => _selectDateRange(context),
          style: OutlinedButton.styleFrom(
            foregroundColor: _selectedDateRange != null
                ? Colors.white
                : Theme.of(context).primaryColor,
            backgroundColor: _selectedDateRange != null
                ? Theme.of(context).primaryColor
                : Colors.white,
            side: BorderSide(
              color: Theme.of(context).primaryColor,
            ),
          ),
          child: Text(
            _selectedDateRange != null
                ? '${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.start)} - ${DateFormat('dd/MM/yyyy').format(_selectedDateRange!.end)}'
                : 'Sélectionner une période',
          ),
        ),
        if (_selectedDateRange != null)
          TextButton(
            onPressed: () {
              setState(() {
                _selectedDateRange = null;
                _tempFilters = _tempFilters.copyWith(dateRange: null);
              });
            },
            child: Text(
              'Effacer la sélection',
              style: TextStyle(
                color: Colors.grey.shade600,
              ),
            ),
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filtres',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _tempFilters = LocationFilters();
                      _selectedDateRange = null;
                      _selectedEquipmentType = "Tous";
                      _selectedNetworkType = "Tous Réseaux";
                    });
                  },
                  child: Text(
                    'Tout effacer',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Divider(color: Colors.grey.shade300),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (widget.isNetworkView) ...[
                    _buildNetworkTypeFilter(),
                    const SizedBox(height: 20),
                  ] else ...[
                    _buildEquipmentTypeFilter(),
                    const SizedBox(height: 20),
                  ],
                  _buildDateFilter(),
                  const SizedBox(height: 20),
                  if (!widget.isNetworkView) ...[
                    if (widget.filterOptions['rues']!.isNotEmpty) ...[
                      _buildFilterSection(
                        'Localisation',
                        widget.filterOptions['rues']!,
                        _tempFilters.selectedRues,
                        (selected) {
                          setState(() {
                            _tempFilters =
                                _tempFilters.copyWith(selectedRues: selected);
                          });
                        },
                      ),
                      const SizedBox(height: 20),
                    ],
                  ],
                  if (widget.filterOptions['quartiers']!.isNotEmpty) ...[
                    _buildFilterSection(
                      'Quartiers',
                      widget.filterOptions['quartiers']!,
                      _tempFilters.selectedQuartiers,
                      (selected) {
                        setState(() {
                          _tempFilters = _tempFilters.copyWith(
                              selectedQuartiers: selected);
                        });
                      },
                    ),
                    const SizedBox(height: 20),
                  ],
                  if (widget.filterOptions['communes']!.isNotEmpty) ...[
                    _buildFilterSection(
                      'Communes',
                      widget.filterOptions['communes']!,
                      _tempFilters.selectedCommunes,
                      (selected) {
                        setState(() {
                          _tempFilters =
                              _tempFilters.copyWith(selectedCommunes: selected);
                        });
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Theme.of(context).primaryColor,
                      side: BorderSide(
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                    child: const Text('Annuler'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      final result = _tempFilters.copyWith(
                        selectedType: widget.isNetworkView
                            ? _selectedNetworkType
                            : _selectedEquipmentType,
                      );
                      Navigator.pop(context, result);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                    ),
                    child: const Text('Appliquer'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
