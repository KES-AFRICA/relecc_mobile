import 'package:auto_route/auto_route.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sopaki_app/generated/assets.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/modal/equipment_type_modal.dart';
import 'package:sopaki_app/src/shared/components/custom_list_title.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

class StreetLightComponent extends StatefulWidget {
  final StoreStreetLightResponse? streetLight;
  final MissionResponse? mission;
  final String source;
  final String? networkLabel;

  const StreetLightComponent(
      {super.key,
      this.streetLight,
      this.mission,
      required this.source,
      required this.networkLabel});

  @override
  State<StreetLightComponent> createState() => _StreetLightComponentState();
}

class _StreetLightComponentState extends State<StreetLightComponent> {
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
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: () {
                if (widget.source == SourceProvider.LampFormProvider) {
                  context.router.replaceAll([MissionRoute()]);
                } else {
                  Navigator.pop(context);
                }
              },
            ),
            backgroundColor: context.colorScheme.primary,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Détails du lampadaire",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              // Remplacer cette partie dans le FlexibleSpaceBar
background: Stack(
  fit: StackFit.expand,
  children: [
    CachedNetworkImage(
            imageUrl: widget.streetLight!.photo??'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
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
              //if (widget.source == SourceProvider.MaintenanceProvider)
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
          context.router.push(
            QrcodeRoute(
              mission: widget.mission,
              source: SourceProvider.MaintenanceProvider,
              intention: "update",
              existingStreetLight: widget.streetLight,
            ),
          );
        },
        icon: const Icon(Icons.edit, color: Colors.white),
      ),
    ),

    if (widget.mission != null) ...[
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
                return Padding(
                  padding: EdgeInsets.only(
                    bottom: MediaQuery.of(context).viewInsets.bottom,
                  ),
                  child: EquipmentTypeModal(
                    mission: widget.mission!,
                    isMeterVisible: false,
                    source: SourceProvider.EquipmentDetailProvider,
                  ),
                );
              },
            );
          },
          icon: const Icon(Icons.add, color: Colors.white),
        ),
      ),
      const SizedBox(width: 4),
    ],
  ],
)],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Section Lampadaire
                  _buildEquipmentSection(
                    context,
                    title: "Lampadaire",
                    defaultTextStyle: defaultTextStyle,
                    highlightedTextStyle: highlightedTextStyle,
                    children: [
                      const SizedBox(height: 12),
                      _buildInfoCard(
                        context,
                        children: [
                          CustomListTitle(
                            title: "Référence :",
                            value: widget.streetLight?.name ?? 'Non renseigné',
                            valueStyle: highlightedTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          // if (widget.streetLight?.network != null) ...[
                          //   const Divider(height: 8, thickness: 0.5),
                          //   CustomListTitle(
                          //     title: "Réseau :",
                          //     value:
                          //         widget.networkLabel != null ? '(${widget.networkLabel})' : '',
                          //     valueStyle: defaultTextStyle,
                          //   ),
                          // ],
                          const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "Nombre de lampes :",
                            value: widget.streetLight?.lampCount?.toString() ?? '0',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "Localisation :",
                            value: widget.streetLight?.street?.name ?? 'Non renseigné',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "Commune :",
                            value: widget.streetLight?.municipality?.name ??
                                'Non renseigné',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          // CustomListTitle(
                          //   title: "Type de commande :",
                          //   value: streetLight?.commandType?.name ??
                          //       'Non renseigné',
                          //   valueStyle: defaultTextStyle,
                          // ),
                          // const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "Type de support :",
                            value: widget.streetLight?.supportType?.name ??
                                'Non renseigné',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "État du support :",
                            value: widget.streetLight?.supportCondition?.name ??
                                'Non renseigné',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "Orientation :",
                            value: widget.streetLight?.orientation?.name ??
                                'Non renseigné',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "Type de réseau :",
                            value:
                                widget.streetLight?.network?.name ?? 'Non renseigné',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "Type de lampadaire :",
                            value: widget.streetLight?.streetLightType?.name ??
                                'Non renseigné',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          CustomListTitle(
                            title: "Puissance :",
                            value: widget.streetLight?.power?.toString() ??
                                'Non renseigné',
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          // _buildSwitchTile(
                          //   title: "Allumé le jour :",
                          //   value: streetLight?.isOnDay == 1,
                          // ),
                          CustomListTitle(
                            title: "Allumé le jour :",
                            value: widget.streetLight?.isOnDay == 1 ? "oui": "non",
                            valueStyle: defaultTextStyle,
                          ),
                          const Divider(height: 8, thickness: 0.5),
                          // _buildSwitchTile(
                          //   title: "Allumé la nuit :",
                          //   value: streetLight?.isOnNight == 1,
                          // ),
                          CustomListTitle(
                            title: "Allumé la nuit :",
                            value: widget.streetLight?.isOnNight == 1
                                ? "oui"
                                : "non",
                            valueStyle: defaultTextStyle,
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
                                  streetLight: widget.streetLight,
                                  source:
                                      SourceProvider.EquipmentDetailProvider),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),

                  if (widget.streetLight?.lamps != null &&
                      widget.streetLight!.lamps!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _buildEquipmentSection(
                      context,
                      title: "Lampes associées",
                      defaultTextStyle: defaultTextStyle,
                      highlightedTextStyle: highlightedTextStyle,
                      children:
                          widget.streetLight!.lamps!.asMap().entries.map((entry) {
                        final index = entry.key + 1;
                        final lamp = entry.value;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12.0),
                          child: _buildInfoCard(
                            context,
                            children: [
                              Text(
                                "Lampe $index",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: context.colorScheme.primary,
                                ),
                              ),
                              const Divider(height: 8, thickness: 0.5),
                              CustomListTitle(
                                  title: "Type de lampe :",
                                  value: lamp.lamp_type ?? 'Non renseigné',
                                  valueStyle: defaultTextStyle,
                                ),
                              const Divider(height: 8, thickness: 0.5),
                              CustomListTitle(
                                title: "Puissance :",
                                value:
                                    lamp.power?.toString() ?? 'Non renseigné',
                                valueStyle: defaultTextStyle,
                              ),
                              const Divider(height: 8, thickness: 0.5),
                              CustomListTitle(
                                  title: "Couleur :",
                                  value: lamp.lamp_color ?? 'Non renseigné',
                                  valueStyle: defaultTextStyle,
                                ),
                              const Divider(height: 8, thickness: 0.5),
                              CustomListTitle(
                                title: "Présente :",
                                value: lamp.hasLamp == 1 ? "Oui" : "Non",
                                valueStyle: defaultTextStyle,
                              ),
                              const Divider(height: 8, thickness: 0.5),
                              CustomListTitle(
                                title: "Avec ballast :",
                                value: lamp.withbalast == 1 ? "Oui" : "Non",
                                valueStyle: defaultTextStyle,
                              ),
                              const Divider(height: 8, thickness: 0.5),
                              CustomListTitle(
                                title: "Allumée le jour :",
                                value: lamp.isOnDay == 1 ? "Oui" : "Non",
                                valueStyle: defaultTextStyle,
                              ),
                              const Divider(height: 8, thickness: 0.5),
                              CustomListTitle(
                                title: "Allumée la nuit :",
                                value: lamp.isOnNight == 1 ? "Oui" : "Non",
                                valueStyle: defaultTextStyle,
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                  ],

                  if (widget.streetLight?.cabinet != null) ...[
                    const SizedBox(height: 24),
                    // Section Armoire - Portrait
                    _buildEquipmentSectionPortrait(
                      context,
                      title: "Armoire associée",
                      //imageAsset: Assets.armoire,
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
    // required String imageAsset,
    required TextStyle defaultTextStyle,
    required TextStyle highlightedTextStyle,
  }) {
    final isTablet = MediaQuery.of(context).size.width >= 600;

    final imageWidget = ClipRRect(
      borderRadius: BorderRadius.circular(12),
      // child: Image.asset(
      //   imageAsset,
      //   height: 200,
      //   width: isTablet ? 120 : double.infinity,
      //   fit: BoxFit.cover,
      // ),
      child: CachedNetworkImage(
            imageUrl: widget.streetLight!.cabinet!.photo ??'https://upload.wikimedia.org/wikipedia/commons/a/ac/No_image_available.svg',
            height: 200,
            width: isTablet ? 120 : double.infinity,
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
                Icons.warehouse,
                color: Colors.grey.shade400,
                size: 40,
              ),
            ),
          ),
    );

    final infoCard = _buildInfoCard(
      context,
      children: [
        CustomListTitle(
          title: "Référence :",
          value: widget.streetLight?.cabinet?.name ?? 'Non renseigné',
          valueStyle: highlightedTextStyle,
        ),
        const Divider(height: 8, thickness: 0.5),
        CustomListTitle(
          title: "Nombre de lampadaires :",
          value: widget.streetLight?.cabinet?.lampCount?.toString() ?? '0',
          valueStyle: defaultTextStyle,
        ),
        const Divider(height: 8, thickness: 0.5),
      //   CustomListTitle(
      //     title: "Localisation :",
      //     value: streetLight?.cabinet?.street?.name ?? 'Non renseigné',
      //     valueStyle: defaultTextStyle,
      //   ),
      //   const Divider(height: 8, thickness: 0.5),
      //   CustomListTitle(
      //     title: "Commune :",
      //     value: streetLight?.cabinet?.municipality?.name ?? 'Non renseigné',
      //     valueStyle: defaultTextStyle,
      //   ),
      //   const Divider(height: 8, thickness: 0.5),
      //   ListTile(
      //     contentPadding: EdgeInsets.zero,
      //     title: const Text(
      //       "État de fonctionnement :",
      //       style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      //     ),
      //     trailing: Switch(
      //       value: streetLight?.cabinet?.isFunctional == 1,
      //       activeColor: _getStatusColor(streetLight?.cabinet?.isFunctional),
      //       inactiveThumbColor: _getStatusColor(
      //           streetLight?.cabinet?.isFunctional,
      //           active: false),
      //       inactiveTrackColor: _getStatusColor(
      //               streetLight?.cabinet?.isFunctional,
      //               active: false)
      //           ?.withOpacity(0.2),
      //       onChanged: null,
      //     ),
      //   ),
      // 
      ],
    );

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
                  imageWidget,
                  const SizedBox(width: 12),
                  Expanded(child: infoCard),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  imageWidget,
                  const SizedBox(height: 12),
                  infoCard,
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
                  cabinet: widget.streetLight?.cabinet,
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

  Color? _getStatusColor(dynamic status, {bool active = true}) {
    final isFunctional = status == 1;
    return active
        ? (isFunctional ? Colors.green.shade600 : Colors.red.shade600)
        : (isFunctional ? null : Colors.red.shade600);
  }

  Widget _buildSwitchTile({required String title, required bool value}) {
    // Déduire s'il s'agit du jour ou de la nuit en analysant le titre
    final isDay = title.toLowerCase().contains('jour');

    Color activeColor;
    Color inactiveThumbColor;
    Color inactiveTrackColor;

    if (isDay) {
      if (value) {
        // Allumé le jour => anormal => rouge
        activeColor = Colors.red.shade600;
        inactiveThumbColor = Colors.red.shade600;
        inactiveTrackColor = Colors.red.shade100;
      } else {
        // Éteint le jour => normal => gris
        activeColor = Colors.grey.shade400;
        inactiveThumbColor = Colors.grey.shade400;
        inactiveTrackColor = Colors.grey.shade200;
      }
    } else {
      if (value) {
        // Allumé la nuit => normal => vert
        activeColor = Colors.green.shade600;
        inactiveThumbColor = Colors.green.shade600;
        inactiveTrackColor = Colors.green.shade100;
      } else {
        // Éteint la nuit => anormal => rouge
        activeColor = Colors.red.shade600;
        inactiveThumbColor = Colors.red.shade600;
        inactiveTrackColor = Colors.red.shade100;
      }
    }

    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: Switch(
        value: value,
        onChanged: null,
        activeColor: activeColor,
        inactiveThumbColor: inactiveThumbColor,
        inactiveTrackColor: inactiveTrackColor,
      ),
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
