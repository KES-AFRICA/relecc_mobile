import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/modal/equipment_type_modal.dart';
import 'package:sopaki_app/src/shared/components/custom_list_title.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

class CabinetWidget extends StatelessWidget {
  final CabinetResponse? cabinet;
  final MissionResponse mission;
  final String? source;
   final String? networkLabel;

  const CabinetWidget({
    super.key,
    this.cabinet,
    required this.source,
    required this.mission,
    this.networkLabel,
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
                if (source == SourceProvider.LampFormProvider) {
                  context.router.replaceAll([MissionRoute()]);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            backgroundColor: context.colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Détails de l'équipement",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  CachedNetworkImage(
              imageUrl: cabinet!.photo??'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
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
             // if (source == SourceProvider.MaintenanceProvider)
                Row(
  children: [
    // Bouton Edit
    Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.edit, color: Colors.white),
      ),
    ),
    const SizedBox(width: 8), // Espacement entre les boutons
    
    // Bouton Add
    Container(
      decoration: BoxDecoration(
        color: context.colorScheme.primary,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          if (cabinet != null) {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              barrierColor: Colors.black26,
              backgroundColor: Colors.white,
              elevation: 10,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (BuildContext context) {
                final screenHeight = MediaQuery.of(context).size.height;
                return SizedBox(
                  height: screenHeight * 0.25,
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: EquipmentTypeModal(
                      mission: mission,
                      cabinet: cabinet,
                      isMeterVisible: false,
                      isCabinetVisible: false,
                      source: SourceProvider.EquipmentDetailProvider,
                    ),
                  ),
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
                  // Section Armoire
                  _buildEquipmentSection(
                    context,
                    title: "Armoire électrique",
                    defaultTextStyle: defaultTextStyle,
                    highlightedTextStyle: highlightedTextStyle,
                    children: [
                      const SizedBox(height: 12),
                      _buildInfoCard(
                        context,
                        children: [
                          CustomListTitle(
                            title: "Nom de l'armoire :",
                            value: cabinet?.name ?? 'Non renseigné',
                            valueStyle: highlightedTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "Nombre de lampadaires :",
                            value: cabinet?.lampCount?.toString() ?? '0',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "Localisation :",
                            value: cabinet?.street?.name ?? 'Non renseigné',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "Commune :",
                            value:
                                cabinet?.municipality?.name ?? 'Non renseigné',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text(
                              "État de fonctionnement :",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                            trailing: Switch(
                              value: cabinet?.isFunctional == 1,
                              activeColor:
                                  _getStatusColor(cabinet?.isFunctional),
                              inactiveThumbColor: _getStatusColor(
                                  cabinet?.isFunctional,
                                  active: false),
                              inactiveTrackColor: _getStatusColor(
                                      cabinet?.isFunctional,
                                      active: false)
                                  ?.withOpacity(0.2),
                              onChanged: null,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: _buildMapButton(
                          context,
                          onPressed: () {
                            context.router.push(
                              MapRoute(
                                  cabinet: cabinet,
                                  source:
                                      SourceProvider.EquipmentDetailProvider),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),

                  if (cabinet?.meter != null) ...[
                    const SizedBox(height: 24),
                    // Section Compteur - Portrait
                    _buildEquipmentSectionPortrait(
                      context,
                      title: "Compteur associé",
                      //imageAsset: Assets.compteur,
                      defaultTextStyle: defaultTextStyle,
                      highlightedTextStyle: highlightedTextStyle,
                    ),
                  ],
                  const SizedBox(
                    height: 40,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Color? _getStatusColor(dynamic status, {bool active = true}) {
    final isFunctional = status == 1;
    return active
        ? (isFunctional ? Colors.green.shade600 : Colors.red.shade600)
        : (isFunctional ? null : Colors.red.shade600);
  }

  Widget _buildEquipmentSection(
    BuildContext context, {
    required String title,
    required TextStyle defaultTextStyle,
    required TextStyle highlightedTextStyle,
    required List<Widget> children,
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
        ...children,
      ],
    );
  }

Widget _buildEquipmentSectionPortrait(
  BuildContext context, {
  required String title,
  //required String imageAsset,
  required TextStyle defaultTextStyle,
  required TextStyle highlightedTextStyle,
}) {
  final isTablet = MediaQuery.of(context).size.width >= 600;

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

      isTablet
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image à gauche
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  // child: Image.asset(
                  //   imageAsset,
                  //   height: 200,
                  //   width: 120,
                  //   fit: BoxFit.cover,
                  // ),
                  child: CachedNetworkImage(
              imageUrl: cabinet!.meter!.photo??'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
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
                ),
                const SizedBox(width: 12),
                // Infos à droite
                Expanded(child: _buildInfoCardSection(context, defaultTextStyle, highlightedTextStyle)),
              ],
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image en haut
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                   child: CachedNetworkImage(
              imageUrl: cabinet!.meter!.photo??'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
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
                ),
                const SizedBox(height: 12),
                // Infos en bas
                _buildInfoCardSection(context, defaultTextStyle, highlightedTextStyle),
              ],
            ),

      const SizedBox(height: 16),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: _buildMapButton(
          context,
          onPressed: () {
            context.router.push(
              MapRoute(
                meter: cabinet?.meter,
                source: SourceProvider.EquipmentDetailProvider,
              ),
            );
          },
        ),
      ),
      const SizedBox(height: 40),
    ],
  );
}

Widget _buildInfoCardSection(
  BuildContext context,
  TextStyle defaultTextStyle,
  TextStyle highlightedTextStyle,
) {
  return _buildInfoCard(
    context,
    children: [
      CustomListTitle(
        title: "Référence :",
        value: cabinet?.meter?.name ?? 'Non renseigné',
        valueStyle: highlightedTextStyle,
      ),
      const Divider(height: 8, thickness: 0.5),
      CustomListTitle(
        title: "Numéro de série :",
        value: cabinet?.meter?.number ?? 'Non renseigné',
        valueStyle: defaultTextStyle,
      ),
      const Divider(height: 8, thickness: 0.5),
      CustomListTitle(
        title: "Marque :",
        value: cabinet?.meter?.brand ?? 'Non renseigné',
        valueStyle: defaultTextStyle,
      ),
      const Divider(height: 8, thickness: 0.5),
      CustomListTitle(
        title: "Modèle :",
        value: cabinet?.meter?.model ?? 'Non renseigné',
        valueStyle: defaultTextStyle,
      ),
    ],
  );
}

  Widget _buildInfoCard(BuildContext context,
      {required List<Widget> children}) {
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

  Widget _buildMapButton(BuildContext context,
      {required VoidCallback onPressed}) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: const Icon(Icons.map_outlined, size: 20),
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
