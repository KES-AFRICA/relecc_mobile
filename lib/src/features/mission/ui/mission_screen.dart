import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/features/mission/components/card.dart';
import 'package:sopaki_app/src/features/mission/logic/controller/bloc/mission_cubit.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/mission/modal/mission_action_bottom_sheet.dart';
import 'package:sopaki_app/src/shared/components/app_drawer.dart';
import 'package:sopaki_app/src/shared/components/custom_appbar.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';

enum MissionFilter { tous, deploiement, maintenance }

@RoutePage<void>()
class MissionScreen extends StatefulWidget implements AutoRouteWrapper {
  final String? source;
  const MissionScreen({super.key, this.source});

  @override
  State<MissionScreen> createState() => _MissionScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [BlocProvider(create: (_) => MissionCubit())],
      child: this,
    );
  }
}

class _MissionScreenState extends State<MissionScreen> {
  MissionFilter _selectedFilter = MissionFilter.tous;

  @override
  void initState() {
    super.initState();
    context.read<MissionCubit>().getAllMission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Mes Missions"),
      drawer: const AppDrawer(selected: 1),
      body: Column(
        children: [
          _buildFilterSection(),
         Expanded(
          child: BlocBuilder<MissionCubit, MissionState>(
            builder: (context, state) {
              return state.when(
                initial: () => _buildLoading(),
                loading: () => _buildLoading(),
                success: (response) => _buildMissionList(response),
                successEquipment: (_) => _buildLoading(),
                successEquipmentMaintenance: (_) => _buildLoading(),
                successNetworkAnalysis: (_) => _buildLoading(),
                successNetworkFilterOptions: (_) => _buildLoading(),
                successNetworkDetails: (_) => _buildLoading(),
                successNetworkQuickStats: (_) => _buildLoading(),
                successNetworkExport: (_) => _buildLoading(),
                failure: (error) => _buildError(error),
              );
            },
          ),
        ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildFilterSection() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  label: "Toutes",
                  filter: MissionFilter.tous,
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: "Déploiement",
                  filter: MissionFilter.deploiement,
                ),
                const SizedBox(width: 8),
                _buildFilterChip(
                  label: "Maintenance",
                  filter: MissionFilter.maintenance,
                ),
              ],
            ),
          ),
         
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required MissionFilter filter,
  }) {
    final isSelected = _selectedFilter == filter;
    final primaryColor = context.colorScheme.primary;
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: FilterChip(
        selected: isSelected,
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(width: 6),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
        selectedColor: primaryColor,
        backgroundColor: Colors.grey[100],
        checkmarkColor: Colors.white,
        elevation: isSelected ? 2 : 0,
        pressElevation: 4,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: VisualDensity.compact,
        onSelected: (bool selected) {
          if (selected) {
            setState(() {
              _selectedFilter = filter;
            });
          }
        },
      ),
    );
  }

List<dynamic> _filterMissions(List<dynamic> missions) {
  if (_selectedFilter == MissionFilter.tous) {
    return missions;
  }

  return missions.where((dynamic missionData) {
    try {
      final mission = missionData?.mission;
      if (mission == null) return false;

      final String type = (mission.interventionType?.name?.toLowerCase() ?? '');
      
      switch (_selectedFilter) {
        case MissionFilter.deploiement:
          // Tout ce qui n'est pas maintenance
          return !(type.contains('maintenance')) && 
                 !(type.contains('dépannage')) && 
                 !(type.contains('identification')) && 
                 !(type.contains('inventaire')) && 
                 !(type.contains('rapport')) && 
                 !(type.contains('visite'));
        case MissionFilter.maintenance:
          return type.contains('maintenance') || 
                 type.contains('dépannage') || 
                 type.contains('identification') || 
                 type.contains('inventaire') || 
                 type.contains('rapport') || 
                 type.contains('visite');
        case MissionFilter.tous:
        default:
          return true;
      }
    } catch (e) {
      return false;
    }
  }).toList();
}
  Widget _buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildError(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, size: 48, color: Colors.red),
          const SizedBox(height: 16),
          Text(
            "Erreur de chargement",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Text(
              error,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => context.read<MissionCubit>().getAllMission(),
            child: const Text("Réessayer"),
          ),
        ],
      ),
    );
  }

  Widget _buildMissionList(ResponseModelWithList<Mission> response) {
    if (response.data == null || response.data!.isEmpty) {
      return _buildEmptyState();
    }

    final filteredMissions = _filterMissions(response.data!);

    if (filteredMissions.isEmpty) {
      return _buildNoFilterResultsState();
    }

    return RefreshIndicator(
      onRefresh: () async {
        context.read<MissionCubit>().getAllMission();
      },
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        itemCount: filteredMissions.length,
        itemBuilder: (context, index) {
          final mission = filteredMissions[index]?.mission;
          if (mission == null) return const SizedBox.shrink();

          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: MissionCard(
              title: mission.title ?? "Mission sans titre",
              status: mission.status ?? "Inconnu",
              interventionType: mission.interventionType?.name ?? "Type inconnu",
              networkType: mission.networkType ?? "Réseau non spécifié",
              streets: _extractNonEmptyStrings(mission.streets?.map((s) => s.name ?? "").toList()),
              neighborhoods: _extractNonEmptyStrings(mission.streets?.map((s) => s.neighborhood?.name ?? "").toList()),
              municipality: mission.streets?.isNotEmpty == true ? mission.streets!.first.municipality?.name ?? "" : "",
              statusColor: _getStatusColor(mission.status),
              typeColor: context.colorScheme.primary,
              onTap: () => _handleMissionTap(context, mission),
            ),
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.assignment, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "Aucune mission disponible",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Vous n'avez aucune mission assignée pour le moment",
            style: TextStyle(color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildNoFilterResultsState() {
    String filterText = '';
    switch (_selectedFilter) {
      case MissionFilter.deploiement:
        filterText = 'de déploiement';
        break;
      case MissionFilter.maintenance:
        filterText = 'de maintenance';
        break;
      default:
        filterText = '';
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            "Aucune mission $filterText",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Essayez de modifier les filtres ou vérifiez plus tard",
            style: TextStyle(color: Colors.grey[600]),
          ),
          const SizedBox(height: 24),
          TextButton.icon(
            onPressed: () {
              setState(() {
                _selectedFilter = MissionFilter.tous;
              });
            },
            icon: const Icon(Icons.clear_all),
            label: const Text("Voir toutes les missions"),
          ),
        ],
      ),
    );
  }

  List<String> _extractNonEmptyStrings(List<dynamic>? items) {
    if (items == null) return [];
    return items
        .where((item) => item != null && item.toString().isNotEmpty)
        .map((item) => item.toString())
        .toList();
  }

  Color _getStatusColor(String? status) {
    switch (status?.toLowerCase()) {
      case 'en cours':
        return Colors.orange;
      case 'terminée':
        return Colors.green;
      case 'en attente':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  void _handleMissionTap(BuildContext context, MissionResponse mission) {
    final type = mission.interventionType?.name.toLowerCase() ?? '';
    
    if (type.contains('installation') || type.contains('déploiement') || type.contains('deployement')) {
      showModalBottomSheet(
        context: context,
        barrierColor: Colors.black26,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (BuildContext context) {
          return MissionActionBottomSheet(mission: mission);
        },
      );
    } 
    else if (type.contains('maintenance') || 
             type.contains('dépannage') || 
             type.contains('identification') || 
             type.contains('inventaire') || 
             type.contains('rapport') || 
             type.contains('visite')) {
      context.router.push(MaintenanceEquipmentRoute(mission: mission));
    }else {
      showModalBottomSheet(
        context: context,
        barrierColor: Colors.black26,
        backgroundColor: Colors.white,
        elevation: 10,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        builder: (BuildContext context) {
          return MissionActionBottomSheet(mission: mission);
        },
      );
    }
  }
}