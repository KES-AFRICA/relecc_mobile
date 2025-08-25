import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/modal/equipment_type_modal.dart';
import 'package:sopaki_app/src/shared/components/custom_list_title.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

class MeterComponent extends StatelessWidget {
  final MeterResponse? meter;
  final String? source;
  final MissionResponse mission;
  final String? networkLabel;
  
  const MeterComponent({
    super.key, 
    this.meter, 
    this.source, 
    this.networkLabel,
    required this.mission
  });

  @override
  Widget build(BuildContext context) {
    final defaultTextStyle = TextStyle(
      fontSize: 14,
      color: Colors.grey.shade700,
    );
    
    final highlightedTextStyle = TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w600,
      color: Colors.black,
    );

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: MediaQuery.of(context).size.height * 0.6,
            floating: false,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                source == SourceProvider.LampFormProvider
                    ? context.router.replaceAll([MissionRoute()])
                    : Navigator.pop(context);
              },
            ),
            backgroundColor: context.colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title:const Text(
                "Détails du compteur",
                style:  TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
              imageUrl: meter!.photo??'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
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
                  Icons.electric_meter,
                  color: Colors.grey.shade400,
                  size: 60,
                ),
              ),
            ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.3),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
               //if (source == SourceProvider.MaintenanceProvider)
                Row(
  children: [
    // Bouton d'édition
    Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        iconSize: 24,
        padding: EdgeInsets.zero,
        onPressed: () {
          // Action d'édition ici
        },
        icon: const Icon(Icons.edit, color: Colors.white),
      ),
    ),
    
    const SizedBox(width: 8), // Espacement entre les boutons
    
    // Bouton d'ajout
    Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: IconButton(
        iconSize: 24,
        padding: EdgeInsets.zero,
        onPressed: () {
          if (meter != null) {
            showModalBottomSheet(
              context: context,
              barrierColor: Colors.black26,
              backgroundColor: Colors.white,
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (BuildContext context) {
                return EquipmentTypeModal(
                  mission: mission,
                  meter: meter,
                  isMeterVisible: false,
                  source: SourceProvider.EquipmentDetailProvider,
                );
              },
            );
          }
        },
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    ),
    const SizedBox(width: 4), 
  ],
)
],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Section Compteur
                  _buildEquipmentSection(
                    context,
                    title: "Compteur électrique",
                    defaultTextStyle: defaultTextStyle,
                    highlightedTextStyle: highlightedTextStyle,
                  ),
                  const SizedBox(height: 40,)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEquipmentSection(
    BuildContext context, {
    required String title,
    required TextStyle defaultTextStyle,
    required TextStyle highlightedTextStyle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: context.colorScheme.primary,
          ),
        ),
        const SizedBox(height: 12),
        _buildInfoCard(
          context,
          children: [
            CustomListTitle(
              title: "Référence :", 
              value: meter?.name ?? 'Non renseigné',
              valueStyle: highlightedTextStyle,
            ),
            const Divider(height: 8, thickness: 0.5),
            CustomListTitle(
              title: "Numéro de série :", 
              value: meter?.number ?? 'Non renseigné',
              valueStyle: defaultTextStyle,
            ),
            const Divider(height: 8, thickness: 0.5),
            CustomListTitle(
              title: "Marque :", 
              value: meter?.brand ?? 'Non renseigné',
              valueStyle: defaultTextStyle,
            ),
            const Divider(height: 8, thickness: 0.5),
            CustomListTitle(
              title: "Modèle :", 
              value: meter?.model ?? 'Non renseigné',
              valueStyle: defaultTextStyle,
            ),
            const Divider(height: 8, thickness: 0.5),
            CustomListTitle(
              title: "Localisation :", 
              value: meter?.street?.name ?? 'Non renseigné',
              valueStyle: defaultTextStyle,
            ),
            const Divider(height: 8, thickness: 0.5),
            CustomListTitle(
              title: "Commune :", 
              value: meter?.municipality?.name ?? 'Non renseigné',
              valueStyle: defaultTextStyle,
            ),
          ],
        ),
        const SizedBox(height: 8),
        _buildMapButton(
          context,
          onPressed: () {
            context.router.push(
              MapRoute(
                meter: meter, 
                source: SourceProvider.EquipmentDetailProvider
              ),
            );
          },
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  Widget _buildInfoCard(BuildContext context, {required List<Widget> children}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildMapButton(BuildContext context, {required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(Icons.map_outlined, size: 20),
      label: const Text("Voir sur la carte"),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: context.colorScheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    );
  }
}