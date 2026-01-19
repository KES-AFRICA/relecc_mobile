import 'dart:io';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/modal/equipment_type_modal.dart';
import 'package:sopaki_app/src/shared/components/custom_appbar.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/responsive/screen.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

@RoutePage<void>()
class PhotoScreen extends StatefulWidget {
  final MissionResponse? mission;
  final String? qrCode;
  final String? source;
  final String? intention;
  const PhotoScreen({
    super.key,
    this.mission,
    this.qrCode,
    this.source,
    this.intention,
  });

  @override
  State<PhotoScreen> createState() => _PhotoScreenState();
}

class _PhotoScreenState extends State<PhotoScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _photo;
  String? imagePath;
  Uint8List? _imageBytes; // Pour stocker l'image en mémoire (web)
  String? _networkImageUrl; // Pour stocker l'URL d'une image web

  Future<void> _takePhoto() async {
    try {
      if (kIsWeb) {
        // Version web : utiliser pickImage pour choisir depuis les fichiers
        final XFile? photo = await _picker.pickImage(
          source: ImageSource.gallery,
        );
        
        if (photo != null) {
          final bytes = await photo.readAsBytes();
          setState(() {
            _photo = photo;
            _imageBytes = bytes;
            _networkImageUrl = null; // Réinitialiser l'URL si on prend une nouvelle photo
          });
          print("📸 Photo sélectionnée sur le web: ${photo.name}");
        }
      } else {
        // Version mobile : utiliser la caméra
        final XFile? photo = await _picker.pickImage(
          source: ImageSource.camera,
        );

        if (photo != null) {
          setState(() {
            imagePath = photo.path;
            _photo = photo;
          });
          print("📸 Photo prise: ${photo.path}");
        } else {
          print("❌ Aucune photo prise.");
        }
      }
    } catch (e) {
      print("❌ Erreur lors de la prise/selection de photo: $e");
    }
  }

  Future<void> _pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickImage(
        source: ImageSource.gallery,
      );
      
      if (image != null) {
        if (kIsWeb) {
          final bytes = await image.readAsBytes();
          setState(() {
            _photo = image;
            _imageBytes = bytes;
            imagePath = null;
            _networkImageUrl = null;
          });
        } else {
          setState(() {
            imagePath = image.path;
            _photo = image;
            _imageBytes = null;
            _networkImageUrl = null;
          });
        }
        print("🖼️ Image sélectionnée depuis la galerie");
      }
    } catch (e) {
      print("❌ Erreur lors de la sélection d'image: $e");
    }
  }

  // Méthode pour afficher l'image selon la plateforme
  Widget _buildImagePreview() {
    if (_networkImageUrl != null && _networkImageUrl!.isNotEmpty) {
      // Cas 1: Image depuis une URL web
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(
          _networkImageUrl!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 40),
                  SizedBox(height: 8),
                  Text(
                    "Erreur de chargement",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            );
          },
        ),
      );
    } else if (kIsWeb && _imageBytes != null) {
      // Cas 2: Image en mémoire sur le web
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.memory(
          _imageBytes!,
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else if (imagePath != null && imagePath!.isNotEmpty) {
      // Cas 3: Image fichier sur mobile
      return ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.file(
          File(imagePath!),
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
        ),
      );
    } else {
      // Cas 4: Aucune image
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.add_a_photo, size: 40, color: Colors.grey[600]),
          const SizedBox(height: 16),
          Text(
            "Appuyez pour prendre une photo",
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
        ],
      );
    }
  }

  bool get _hasImage {
    return _networkImageUrl != null || 
           _imageBytes != null || 
           (imagePath != null && imagePath!.isNotEmpty);
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
                child: _hasImage
                    ? Stack(
                        children: [
                          _buildImagePreview(),
                          Positioned(
                            top: 8,
                            right: 8,
                            child: GestureDetector(
                              onTap: () => setState(() {
                                imagePath = null;
                                _imageBytes = null;
                                _networkImageUrl = null;
                                _photo = null;
                              }),
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
                          // Bouton galerie en bas à droite
                          if (!kIsWeb) // Sur mobile, ajouter bouton galerie
                            Positioned(
                              bottom: 8,
                              right: 8,
                              child: GestureDetector(
                                onTap: _pickImageFromGallery,
                                child: Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: const BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: const Icon(Icons.photo_library, color: Colors.blue),
                                ),
                              ),
                            ),
                        ],
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.add_a_photo, size: 40, color: Colors.grey[600]),
                          const SizedBox(height: 16),
                          Text(
                            kIsWeb 
                              ? "Cliquez pour sélectionner une image"
                              : "Appuyez pour prendre une photo",
                            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                          ),
                          if (!kIsWeb) // Option galerie sur mobile
                            TextButton(
                              onPressed: _pickImageFromGallery,
                              child: Text(
                                "Ou choisir depuis la galerie",
                                style: TextStyle(color: Colors.blue),
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
                onPressed: _hasImage
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
                      }
                    : null,
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
}