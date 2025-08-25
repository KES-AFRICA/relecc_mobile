import 'dart:io';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/modal/equipment_type_modal.dart';
import 'package:sopaki_app/src/shared/components/custom_appbar.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/responsive/screen.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

@RoutePage<void>()
class PhotoScreen extends StatefulWidget {
  final MissionResponse? mission;
  //final EquipmentType? equipmentType;
  final String? qrCode;
  final String? source;
  final String? intention;
  const PhotoScreen({
    super.key,
    this.mission,
    this.qrCode,
    this.source,
    this.intention,
    //this.equipmentType
  });

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _photo;
  String? imagePath;

  Future<void> _takePhoto() async {
    try {
      final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

      if (photo != null) {
        setState(() {
          imagePath = photo.path;
          _photo = photo;
        });
        print("📸 Photo prise: ${photo.path}");
      } else {
        print("❌ Aucune photo prise.");
      }
    } catch (e) {
      print("❌ Erreur lors de la prise de photo: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "Photo",
        leadingIcon: Icons.arrow_back_ios,
        onLeadingTap: () => Navigator.pop(context),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: largeur(context, 16)),
        child: Column(
          children: [
            const SizedBox(height: 25),
            GestureDetector(
              onTap: _takePhoto,
              child: Container(
                height: MediaQuery.of(context).size.height / 1.5,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey, width: 1),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: imagePath == null
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 40, color: Colors.grey[600]),
                          const SizedBox(height: 16),
                          Text(
                            "Appuyez pour prendre une photo",
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(imagePath!),
                              fit: BoxFit.cover,
                              width: double.infinity,
                              height: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => setState(() => imagePath = null),
                              child: Container(
                                padding: const EdgeInsets.all(4),
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.close, color: Colors.white, size: 16),
                              ),
                            ),
                          ),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: imagePath != null
                    ? () {
                        if (widget.source == SourceProvider.ArmoireProvider) {
                          Navigator.pop(context, _photo);
                        } else if (widget.source == SourceProvider.LampadaireProvider) {
                          Navigator.pop(context, _photo);
                        } else {
                          showModalBottomSheet(
                            context: context,
                            barrierColor: Colors.black26,
                            backgroundColor: Colors.white,
                            elevation: 10,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            builder: (BuildContext context) {
                              return EquipmentTypeModal(
                                mission: widget.mission ?? MissionResponse(),
                                qrCode: widget.qrCode ?? "",
                                photo: _photo!,
                                source: SourceProvider.CameraProvider,
                              );
                            },
                          );
                        }

                        /*context.router.push(
                    const LampadaireDeploiementFormRoute(), // ✅ navigation vers le formulaire
                  );*/
                      }
                    : null, // 🔒 bouton désactivé si pas de photo
                //onPressed: imagePath != null ? () => _navigateToForm() : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: context.colorScheme.primary,
                  disabledBackgroundColor: Colors.grey,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text(
                  "Suivant",
                  style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
  //  void _navigateToForm() {
  //     if (_photo == null) {
  //   ScaffoldMessenger.of(context).showSnackBar(
  //     SnackBar(content: Text("Aucune photo sélectionnée")),
  //   );
  //   return;
  // }
  //   switch (widget.equipmentType) {
  //     case EquipmentType.compteur:
  //       context.router.push(CompteurDeploiementFormRoute(
  //         missionResponse: widget.mission!,
  //         qrCode: widget.qrCode!,
  //         photo: _photo!,
  //         source: SourceProvider.CameraProvider,
  //       ));
  //       break;
  //     case EquipmentType.armoire:
  //       context.router.push(ArmoireDeploiementFormRoute(
  //         missionResponse: widget.mission!,
  //         qrCode: widget.qrCode!,
  //         photo: _photo!,
  //         source: SourceProvider.CameraProvider,
  //       ));
  //       break;
  //     case EquipmentType.lampadaire:
  //       context.router.push(LampadaireRoute(
  //         missionResponse: widget.mission!,
  //         qrCode: widget.qrCode!,
  //         photo: _photo!,
  //         source: SourceProvider.CameraProvider,
  //       ));
  //       break;
  //     default:
  //       // Gestion d'erreur
  //       break;
  //   }
  // }
}
