import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/core/theme/dimens.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/modal/equipment_type_modal.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

class MissionActionBottomSheet extends StatelessWidget {
  final MissionResponse mission;
  const MissionActionBottomSheet({super.key, required this.mission});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.35,
      child: Column(
        children: [
          const SizedBox(
            height: Dimens.spacing,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.3,
            child: const Divider(
              thickness: 2,
              color: Colors.black,
              indent: 2.0,
            ),
          ),
          const SizedBox(
            height: Dimens.spacing,
          ),
          ListTile(
            onTap: () {
              context.router.push(QrcodeRoute(mission: mission));
            },
            //onTap: () => _showEquipmentTypeModal(context),
            leading: Icon(
              Icons.add,
              color: context.colorScheme.primary,
            ),
            title: Text("Ajouter un équipement", style: Theme.of(context).textTheme.headlineMedium),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: context.colorScheme.primary,
            ),
          ),
          const Divider(
            thickness: 0.5,
          ),
          const SizedBox(
            height: Dimens.spacing,
          ),
          ListTile(
            leading: Icon(Icons.list_alt, color: context.colorScheme.primary),
            onTap: () {
              context.router.push(EquipementRoute(mission: mission));
            },
            title: Text(
              "Voir les détails",
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: context.colorScheme.primary,
            ),
          ),
        ],
      ),
    );
  }
// void _showEquipmentTypeModal(BuildContext context) {
//   showModalBottomSheet(
//     context: context,
//     backgroundColor: Colors.white, // <-- Force le fond blanc
//     barrierColor: Colors.black54, // <-- Couleur du fond derrière le modal
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.vertical(
//         top: Radius.circular(16.0), // <-- Arrondi des coins supérieurs
//       ),
//     ),
//     builder: (_) => EquipmentTypeModal(
//       mission: mission,
//       source: SourceProvider.MissionProvider,
//     ),
//   );
// }
}
