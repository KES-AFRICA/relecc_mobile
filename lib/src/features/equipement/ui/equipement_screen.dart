import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/equipement/classes/reseau.dart'; // AJOUTÉ
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/features/mission/logic/controller/bloc/mission_cubit.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/network/logic/model/network_analysis_response.dart';
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
  final String? selectedType;

  LocationFilters({
    Set<String>? selectedRues,
    Set<String>? selectedQuartiers,
    Set<String>? selectedCommunes,
    this.dateRange,
    this.selectedType,
  })  : selectedRues = selectedRues ?? {},
        selectedQuartiers = selectedQuartiers ?? {},
        selectedCommunes = selectedCommunes ?? {};

  LocationFilters copyWith({
    Set<String>? selectedRues,
    Set<String>? selectedQuartiers,
    Set<String>? selectedCommunes,
    DateTimeRange? dateRange,
    String? selectedType,
  }) {
    return LocationFilters(
      selectedRues: selectedRues ?? this.selectedRues,
      selectedQuartiers: selectedQuartiers ?? this.selectedQuartiers,
      selectedCommunes: selectedCommunes ?? this.selectedCommunes,
      dateRange: dateRange ?? this.dateRange,
      selectedType: selectedType ?? this.selectedType,
    );
  }

  bool get hasActiveFilters =>
      selectedRues.isNotEmpty ||
      selectedQuartiers.isNotEmpty ||
      selectedCommunes.isNotEmpty ||
      dateRange != null;
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
  LocationFilters _locationFilters = LocationFilters();
  bool _isLoadingEquipment = false;
  bool _isLoadingNetworks = false;
  
  // Variables pour la pagination
  int _equipmentCurrentPage = 1;
  int _equipmentTotalPages = 1;
  int _networkCurrentPage = 1;
  int _networkTotalPages = 1;
  
  // Variables pour stocker les données
  List<StoreStreetLightResponse> _streetLights = [];
  List<CabinetResponse> _cabinets = [];
  List<MeterResponse> _meters = [];
  List<dynamic> _allEquipments = [];
  NetworkAnalysisResponse? _networkAnalysisResponse;

  @override
  void initState() {
    super.initState();
    _loadEquipmentPage(1);
    
    // Initialiser avec une structure vide
    _networkAnalysisResponse = NetworkAnalysisResponse(
      success: true,
      error: false,
      message: '',
      data: NetworkAnalysisData(
        networks: [],
        statistics: NetworkStatistics(
          totalNetworks: 0, 
          totalStreetlights: 0, 
          totalPowerW: 0, 
          totalDistanceKm: 0, 
          totalOnDay: 0, 
          totalOnNight: 0, 
          byType: {}, 
          byMunicipality: [], 
          creationStats: CreationStats(
            newestNetworkDaysAgo: 0, 
            oldestNetworkDaysAgo: 0, 
            averageNetworkAgeDays: 0
          )
        ),
        meta: NetworkMeta(
          currentPage: 1,
          lastPage: 1,
          perPage: 10,
          total: 0,
          totalNetworks: 0,
        ),
      ),
    );
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

  void _loadEquipmentPage(int page) {
    setState(() {
      _isLoadingEquipment = true;
      _equipmentCurrentPage = page;
    });
    
    if (widget.mission.id != null) {
      context.read<MissionCubit>().getAllEquipmentsMission(
        widget.mission.id!,
        page: page,
        perPage: 10,
        equipmentType: _selectedType == "Armoires" ? "cabinets" : 
                      _selectedType == "Compteurs" ? "meters" : 
                      _selectedType == "Lampadaires" ? "streetlights" : null,
      );
    } else {
      ApiErrorDialog.show(context: context, error: 'Mission ID is null');
    }
  }

  void _loadNetworkPage(int page) {
    setState(() {
      _isLoadingNetworks = true;
      _networkCurrentPage = page;
    });
    
    String? networkType;
    switch (_selectedNetworkType) {
      case "Tous Réseaux":
        networkType = null;
        break;
      case "complets":
        networkType = 'with_cabinet_meter';
        break;
      case "sans compteur":
        networkType = 'with_cabinet_only';
        break;
      case "sans armoire":
        networkType = 'with_meter_only';
        break;
    }
    
    context.read<MissionCubit>().analyzeNetworks(
      page: page,
      perPage: 10,
      type: networkType,
      municipality: _locationFilters.selectedCommunes.isNotEmpty 
        ? _locationFilters.selectedCommunes.first 
        : null,
    );
  }

  void _toggleView() {
    setState(() {
      _showNetworkView = !_showNetworkView;
      if (_showNetworkView) {
        _loadNetworkPage(1);
      }
    });
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
    final filterOptions = _extractFilterOptions(_cabinets, _meters, _streetLights);

    final newFilters = await showModalBottomSheet<LocationFilters>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _FilterModal(
        isNetworkView: _showNetworkView,
        filterOptions: filterOptions,
        currentFilters: _locationFilters,
        allCabinets: _cabinets,
        allMeters: _meters,
        allStreetLights: _streetLights,
        onTypeSelected: _showNetworkView ? _setSelectedNetworkType : _setSelectedType,
      ),
    );

    if (newFilters != null) {
      setState(() {
        _locationFilters = newFilters;
      });
      
      if (_showNetworkView) {
        _loadNetworkPage(1);
      } else {
        _loadEquipmentPage(1);
      }
    }
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
          if (street['municipality'] != null) communes.add(street['municipality']);
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
              if (_showNetworkView) {
                _loadNetworkPage(1);
              } else {
                _loadEquipmentPage(1);
              }
            },
            child: const Text('Réinitialiser les filtres'),
          ),
        ],
      ),
    );
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

  Widget _buildNetworkCard(NetworkAnalysis network) {
    // Utiliser des valeurs par défaut pour éviter les null
    final typeLabel = network.typeLabel ?? network.displayType ?? 'Type inconnu';
    final municipality = network.municipality ?? 'Commune inconnue';
    final streetlightCount = network.streetlightCount ?? 0;
    final distance = network.distance ?? 0.0;
    final totalPower = network.totalPower ?? 0.0;
    final onDayPercentage = network.onDayPercentage ?? 0.0;
    final onNightPercentage = network.onNightPercentage ?? 0.0;
    final createdAtFormatted = network.createdAtFormatted ?? 'Date inconnue';
    final ageDays = network.ageDays ?? 0;
    final cabinetName = network.cabinetName ?? '';
    final meterName = network.meterName ?? '';
    
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: context.colorScheme.primary,
          width: 2,
        ),
      ),
      child: InkWell(
        onTap: () {
          context.read<MissionCubit>().getNetworkDetails(
            type: network.type ?? 'unknown',
            id: network.id ?? '0',
          );
        },
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
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: context.colorScheme.primary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            typeLabel,
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          municipality,
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
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: context.colorScheme.primary.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '$streetlightCount lamp.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: context.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              if (cabinetName.isNotEmpty || meterName.isNotEmpty)
                Wrap(
                  spacing: 8,
                  runSpacing: 4,
                  children: [
                    if (cabinetName.isNotEmpty)
                      _buildNetworkChip(
                        icon: Image.asset(Assets.armoire, width: 20, height: 20),
                        label: 'Armoire $cabinetName',
                        context: context,
                      ),
                    if (meterName.isNotEmpty)
                      _buildNetworkChip(
                        icon: Image.asset(Assets.compteur, width: 20, height: 20),
                        label: 'Compteur $meterName',
                        context: context,
                      ),
                  ],
                ),
              const SizedBox(height: 8),
              Text(
                'Distance: ${distance.toStringAsFixed(2)} km | Puissance: ${(totalPower / 1000).toStringAsFixed(2)} kW',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Allumé jour: ${onDayPercentage.toStringAsFixed(1)}% | Nuit: ${onNightPercentage.toStringAsFixed(1)}%',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Créé: $createdAtFormatted ($ageDays jours)',
                style: TextStyle(
                  fontSize: 11,
                  color: Colors.grey.shade500,
                ),
              ),
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

  Widget _buildEquipmentView() {
    final filteredEquipments = _allEquipments.where((item) {
      if (!_locationFilters.hasActiveFilters) return true;
      
      final equipment = item.item;
      final street = equipment.street;
      if (street == null) return false;

      bool matchesRue = _locationFilters.selectedRues.isEmpty ||
          (street.name != null && _locationFilters.selectedRues.contains(street.name));

      bool matchesQuartier = _locationFilters.selectedQuartiers.isEmpty;
      try {
        matchesQuartier = matchesQuartier || 
            (street.district != null && _locationFilters.selectedQuartiers.contains(street.district)) ||
            (street.quartier != null && _locationFilters.selectedQuartiers.contains(street.quartier));
      } catch (e) {}

      bool matchesCommune = _locationFilters.selectedCommunes.isEmpty ||
          (street.municipality != null && _locationFilters.selectedCommunes.contains(street.municipality));

      bool matchesDate = true;
      if (_locationFilters.dateRange != null && equipment.createdAt != null) {
        matchesDate = equipment.createdAt!.isAfter(_locationFilters.dateRange!.start) &&
            equipment.createdAt!.isBefore(_locationFilters.dateRange!.end);
      }

      return matchesRue && matchesQuartier && matchesCommune && matchesDate;
    }).toList();

    if (filteredEquipments.isEmpty && _locationFilters.hasActiveFilters) {
      return _buildNoResultsWidget();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        int crossAxisCount = constraints.maxWidth < 600
            ? 2
            : constraints.maxWidth < 900
                ? 3
                : 4;

        return Column(
          children: [
            Expanded(
              child: GridView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.all(constraints.maxWidth < 600 ? 8.0 : 16.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.7,
                ),
                itemCount: filteredEquipments.length,
                itemBuilder: (context, index) {
                  final item = filteredEquipments[index];
                  final equipment = item.item;
                  return _buildEquipmentCard(
                    title: '${equipment.name ?? item.type.capitalize()}',
                    location: equipment.street?.name ?? 'Localisation inconnue',
                    imageUrl: equipment.photo ?? '',
                    isAsset: false,
                    createdAt: equipment.createdAt,
                    onTap: () => context.router.push(EquipmentDetailsRoute(
                      cabinet: item.type == 'cabinet' ? equipment : null,
                      meter: item.type == 'meter' ? equipment : null,
                      streetLight: item.type == 'streetLight' ? equipment : null,
                      mission: widget.mission,
                    )),
                  );
                },
              ),
            ),
            _buildPaginationControls(
              currentPage: _equipmentCurrentPage,
              totalPages: _equipmentTotalPages,
              isLoading: _isLoadingEquipment,
              onPrevious: () => _loadEquipmentPage(_equipmentCurrentPage - 1),
              onNext: () => _loadEquipmentPage(_equipmentCurrentPage + 1),
            ),
          ],
        );
      },
    );
  }

  Widget _buildNetworkView() {
    if (_isLoadingNetworks) {
      return _buildLoadingIndicator();
    }
    
    // CORRECTION : Maintenant c'est _networkAnalysisResponse?.data?.networks
    final networks = _networkAnalysisResponse?.data?.networks ?? [];
    
    print("=== AFFICHAGE RÉSEAUX ===");
    print("Nombre de réseaux: ${networks.length}");
    
    if (networks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.wifi_off, size: 60, color: Colors.grey.shade400),
            const SizedBox(height: 16),
            Text(
              _locationFilters.hasActiveFilters || _selectedNetworkType != "Tous Réseaux"
                  ? 'Aucun réseau ne correspond à vos filtres'
                  : 'Aucun réseau disponible',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            if (_locationFilters.hasActiveFilters || _selectedNetworkType != "Tous Réseaux")
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _locationFilters = LocationFilters();
                    _selectedNetworkType = "Tous Réseaux";
                  });
                  _loadNetworkPage(1);
                },
                child: const Text('Réinitialiser les filtres'),
              ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: networks.length,
            itemBuilder: (context, index) {
              final network = networks[index];
              return _buildNetworkCard(network);
            },
          ),
        ),
        _buildPaginationControls(
          currentPage: _networkCurrentPage,
          totalPages: _networkTotalPages,
          isLoading: _isLoadingNetworks,
          onPrevious: () => _loadNetworkPage(_networkCurrentPage - 1),
          onNext: () => _loadNetworkPage(_networkCurrentPage + 1),
        ),
      ],
    );
  }

  Widget _buildPaginationControls({
    required int currentPage,
    required int totalPages,
    required bool isLoading,
    required VoidCallback onPrevious,
    required VoidCallback onNext,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade300)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: currentPage > 1 && !isLoading ? onPrevious : null,
            color: currentPage > 1 && !isLoading 
              ? Theme.of(context).primaryColor 
              : Colors.grey,
          ),
          Text(
            'Page $currentPage sur $totalPages',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: currentPage < totalPages && !isLoading ? onNext : null,
            color: currentPage < totalPages && !isLoading
              ? Theme.of(context).primaryColor
              : Colors.grey,
          ),
        ],
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
            tooltip: _showNetworkView ? "Voir les équipements" : "Voir les réseaux",
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
            // AJOUTÉ: Cas pour les détails du réseau
successNetworkDetails: (response) {
  final data = response.data;
  final networkInfo = data?['network_info'];
  
  // Créer l'objet IndividualNetwork
  final individualNetwork = IndividualNetwork(
    id: networkInfo['id'].toString(),
    name: networkInfo['type_label'] ?? 'Réseau',
    type: networkInfo['type'] ?? 'unknown',
    municipality: networkInfo['municipality'] ?? 'Inconnue',
    streetlightCount: networkInfo['streetlight_count'] ?? 0,
    distance: (networkInfo['distance_km'] ?? 0).toDouble(),
    totalPower: (networkInfo['total_power_w'] ?? 0).toDouble(),
    createdAt: networkInfo['created_at_iso'] != null 
      ? DateTime.tryParse(networkInfo['created_at_iso']) 
      : null,
    cabinetId: data?['cabinet']?['id'],
    meterId: data?['meter']?['id'],
    location: networkInfo['location'],
    streetLightIds: (data?['streetlights'] as List<dynamic>?)
        ?.map<int>((e) => e['id'] as int)
        .where((id) => id > 0)
        .toList() ?? [],
  );
  
  // Convertir les données du cabinet si présentes
  CabinetResponse? cabinet;
  if (data?['cabinet'] != null) {
    cabinet = CabinetResponse.fromJson(data?['cabinet']);
  }
  
  // Convertir les données du compteur si présentes
  MeterResponse? meter;
  if (data?['meter'] != null) {
    meter = MeterResponse.fromJson(data?['meter']);
  }
  
  // CORRECTION : Convertir les lampadaires avec les bool en int
  final streetLights = (data?['streetlights'] as List)
    .map((e) {
      // Convertir bool en int pour is_on_day et is_on_night
      final streetlightMap = Map<String, dynamic>.from(e);
      if (streetlightMap['is_on_day'] is bool) {
        streetlightMap['is_on_day'] = (streetlightMap['is_on_day'] as bool) ? 1 : 0;
      }
      if (streetlightMap['is_on_night'] is bool) {
        streetlightMap['is_on_night'] = (streetlightMap['is_on_night'] as bool) ? 1 : 0;
      }
      
      // Convertir les lamps aussi si nécessaire
      if (streetlightMap['lamps'] != null) {
        final lamps = (streetlightMap['lamps'] as List).map((lamp) {
          final lampMap = Map<String, dynamic>.from(lamp);
          if (lampMap['is_on_day'] is bool) {
            lampMap['is_on_day'] = (lampMap['is_on_day'] as bool) ? 1 : 0;
          }
          if (lampMap['is_on_night'] is bool) {
            lampMap['is_on_night'] = (lampMap['is_on_night'] as bool) ? 1 : 0;
          }
          return lampMap;
        }).toList();
        streetlightMap['lamps'] = lamps;
      }
      
      return StoreStreetLightResponse.fromJson(streetlightMap);
    })
    .toList();
  
  // Naviguer vers la page détails
  context.router.push(
    NetworkDetailsRoute(
      network: individualNetwork,
      cabinet: cabinet,
      meter: meter,
      streetLights: streetLights,
      mission: widget.mission,
      networkLabel: networkInfo['label'] ?? 
        (cabinet?.name != null && meter?.name != null 
          ? '${cabinet!.name} - ${meter!.name}'
          : cabinet?.name ?? meter?.name ?? 'Réseau'),
    ),
  );
},
            successEquipment: (response) {
              setState(() {
                _isLoadingEquipment = false;
                
                if (_selectedType == "Armoires") {
                  _cabinets = response.data?.cabinets ?? [];
                  _allEquipments = _cabinets.map((e) => _EquipmentItem(e, 'cabinet')).toList();
                } else if (_selectedType == "Compteurs") {
                  _meters = response.data?.meters ?? [];
                  _allEquipments = _meters.map((e) => _EquipmentItem(e, 'meter')).toList();
                } else if (_selectedType == "Lampadaires") {
                  _streetLights = response.data?.streetlights ?? [];
                  _allEquipments = _streetLights.map((e) => _EquipmentItem(e, 'streetLight')).toList();
                } else {
                  _cabinets = response.data?.cabinets ?? [];
                  _meters = response.data?.meters ?? [];
                  _streetLights = response.data?.streetlights ?? [];
                  _allEquipments = [
                    ..._cabinets.map((e) => _EquipmentItem(e, 'cabinet')),
                    ..._meters.map((e) => _EquipmentItem(e, 'meter')),
                    ..._streetLights.map((e) => _EquipmentItem(e, 'streetLight')),
                  ]..sort((a, b) => 
                      b.item.createdAt?.compareTo(a.item.createdAt ?? DateTime(0)) ?? 0);
                }
                
                final meta = response.data?.meta;
                if (meta != null && meta.lastPage != null) {
                  _equipmentTotalPages = meta.lastPage!;
                }
              });
            },
            successNetworkAnalysis: (response) {
              print("=== SUCCESS NETWORK ANALYSIS ===");
              print("Response reçue: ${response != null}");
              print("Response.data: ${response.data != null}");
              
              setState(() {
                _isLoadingNetworks = false;
                
                // CORRECTION: response.data est directement NetworkAnalysisResponse
                _networkAnalysisResponse = response.data;
                
                // Récupérer le nombre total de pages
                if (response.data?.data?.meta != null) {
                  _networkTotalPages = response.data!.data!.meta!.lastPage;
                  print("Méta données récupérées:");
                  print("- currentPage: ${response.data!.data!.meta!.currentPage}");
                  print("- lastPage: ${response.data!.data!.meta!.lastPage}");
                  print("- total networks: ${response.data!.data!.networks?.length ?? 0}");
                } else {
                  _networkTotalPages = 1;
                  print("Pas de métadonnées dans la réponse");
                }
              });
            },
            failure: (error) {
              setState(() {
                _isLoadingEquipment = false;
                _isLoadingNetworks = false;
              });
              ApiErrorDialog.show(context: context, error: error);
            },
          );
        },
        builder: (context, state) {
          if (!_showNetworkView && _isLoadingEquipment) {
            return _buildLoadingIndicator();
          }
          
          if (_showNetworkView && _isLoadingNetworks) {
            return _buildLoadingIndicator();
          }

          if (_showNetworkView) {
            return _buildNetworkView();
          } else {
            return _buildEquipmentView();
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
                  _selectedNetworkType = selected ? "Tous Réseaux" : _selectedNetworkType;
                });
                widget.onTypeSelected?.call("Tous Réseaux");
              },
            ),
            _buildFilterChip(
              label: "complets",
              selected: _selectedNetworkType == "complets",
              onSelected: (selected) {
                setState(() {
                  _selectedNetworkType = selected ? "complets" : _selectedNetworkType;
                });
                widget.onTypeSelected?.call("complets");
              },
            ),
            _buildFilterChip(
              label: "sans compteur",
              selected: _selectedNetworkType == "sans compteur",
              onSelected: (selected) {
                setState(() {
                  _selectedNetworkType = selected ? "sans compteur" : _selectedNetworkType;
                });
                widget.onTypeSelected?.call("sans compteur");
              },
            ),
            _buildFilterChip(
              label: "sans armoire",
              selected: _selectedNetworkType == "sans armoire",
              onSelected: (selected) {
                setState(() {
                  _selectedNetworkType = selected ? "sans armoire" : _selectedNetworkType;
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
                  _selectedEquipmentType = selected ? "Tous" : _selectedEquipmentType;
                });
                widget.onTypeSelected?.call("Tous");
              },
            ),
            _buildFilterChip(
              label: "Armoires",
              selected: _selectedEquipmentType == "Armoires",
              onSelected: (selected) {
                setState(() {
                  _selectedEquipmentType = selected ? "Armoires" : _selectedEquipmentType;
                });
                widget.onTypeSelected?.call("Armoires");
              },
            ),
            _buildFilterChip(
              label: "Compteurs",
              selected: _selectedEquipmentType == "Compteurs",
              onSelected: (selected) {
                setState(() {
                  _selectedEquipmentType = selected ? "Compteurs" : _selectedEquipmentType;
                });
                widget.onTypeSelected?.call("Compteurs");
              },
            ),
            _buildFilterChip(
              label: "Lampadaires",
              selected: _selectedEquipmentType == "Lampadaires",
              onSelected: (selected) {
                setState(() {
                  _selectedEquipmentType = selected ? "Lampadaires" : _selectedEquipmentType;
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
                            _tempFilters = _tempFilters.copyWith(selectedRues: selected);
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
                          _tempFilters = _tempFilters.copyWith(selectedQuartiers: selected);
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
                          _tempFilters = _tempFilters.copyWith(selectedCommunes: selected);
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
    if (isEmpty) return this;
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}