import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/equipement/ui/component/cabinet_component.dart';
import 'package:sopaki_app/src/features/equipement/ui/component/meter_component.dart';
import 'package:sopaki_app/src/features/equipement/ui/component/street_light_component.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';

@RoutePage<void>()
class EquipmentDetailsScreen extends StatefulWidget {
  final CabinetResponse? cabinet;
  final MeterResponse? meter;
  final MissionResponse? mission;
  final StoreStreetLightResponse? streetLight;
  final String? source;
  final String? networkLabel;

  const EquipmentDetailsScreen({
    super.key,
    this.cabinet,
    this.meter,
    this.streetLight,
    this.source,
    this.mission,
    this.networkLabel,
  });

  @override
  State<EquipmentDetailsScreen> createState() => _EquipmentDetailsScreenState();
}

class _EquipmentDetailsScreenState extends State<EquipmentDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.cabinet != null
          ? CabinetWidget(
        mission: widget.mission!,
        source: widget.source,
        cabinet: widget.cabinet,
        networkLabel: widget.networkLabel,
      )
          : widget.meter != null
          ? MeterComponent(
        meter: widget.meter,
        source: widget.source,
        mission: widget.mission!,
        networkLabel: widget.networkLabel,
      )
          : StreetLightComponent(
        streetLight: widget.streetLight,
        source: widget.source ??"",
        networkLabel: widget.networkLabel,
      ),
    );
  }
}
