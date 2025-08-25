
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/core/theme/dimens.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';

class EquipmentTypeModal extends StatelessWidget {
  final MissionResponse mission;
  final MeterResponse? meter;
  final CabinetResponse? cabinet;
  final String? qrCode;
  final String source;
  final XFile? photo;
  final bool? isMeterVisible;
  final bool? isCabinetVisible;
  final bool? isLampVisible;
  const EquipmentTypeModal({
    super.key,
    required this.mission,
    this.qrCode,
    this.photo,
    this.meter,
    this.cabinet,
    this.isCabinetVisible = true,
    this.isLampVisible = true,
    this.isMeterVisible = true,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(
          height: Dimens.spacing,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            "Choisir un équipement",
            style: TextStyle(
              fontSize: 16,
              color: context.colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Visibility(
          visible: isMeterVisible ?? true,
          child: Column(
            children: [
              const SizedBox(
                height: Dimens.spacing,
              ),
              ListTile(
                onTap: () {
                  context.router.popAndPush(CompteurDeploiementFormRoute(
                      missionResponse: mission, qrCode: qrCode, photo: photo, source: source));
                },
                //onTap: () => _launchFlow(context, EquipmentType.compteur),
                leading: Icon(
                  Icons.electric_meter,
                  color: context.colorScheme.primary,
                ),
                title: Text("Compteur", style: Theme.of(context).textTheme.headlineMedium),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isCabinetVisible ?? true,
          child: Column(
            children: [
              const Divider(
                thickness: 0.5,
              ),
              const SizedBox(
                height: Dimens.spacing,
              ),
              ListTile(
                leading: Icon(Icons.cabin, color: context.colorScheme.primary),
                onTap: () {
                  context.router.popAndPush(ArmoireDeploiementFormRoute(
                      meter: meter, missionResponse: mission, qrCode: qrCode, photo: photo, source: source));
                },
                 //onTap: () => _launchFlow(context, EquipmentType.armoire),
                title: Text(
                  "Armoire",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: isLampVisible ?? true,
          child: Column(
            children: [
              const Divider(
                thickness: 0.5,
              ),
              const SizedBox(
                height: Dimens.spacing,
              ),
              ListTile(
                leading: Icon(Icons.light, color: context.colorScheme.primary),
                onTap: () {
                  context.router.popAndPush(LampadaireRoute(
                      missionResponse: mission,
                      qrCode: qrCode,
                      photo: photo,
                      source: source,
                      cabinet: cabinet,
                      meter: meter));
                },
                //onTap: () => _launchFlow(context, EquipmentType.lampadaire),
                title: Text(
                  "Lampadaire",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                trailing: Icon(
                  Icons.arrow_forward_ios,
                  color: context.colorScheme.primary,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  // void _launchFlow(BuildContext context, EquipmentType type) {
  //   context.router.pop(); // Ferme le modal
  //   context.router.push(QrcodeRoute(
  //     mission: mission,
  //     equipmentType: type, // Nouveau paramètre
  //   ));
  // }
}
//enum EquipmentType { compteur, armoire, lampadaire }