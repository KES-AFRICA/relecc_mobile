import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:auto_route/auto_route.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

import '../../../core/routing/app_router.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/responsive/screen.dart';

@RoutePage<void>()
class QrcodeScreen extends StatefulWidget {
  final MissionResponse? mission;
  //final EquipmentType? equipmentType; 
  final String? source;
  final String? intention;
  final StoreStreetLightResponse? existingStreetLight;

  const QrcodeScreen({
    super.key, 
    this.mission, 
    this.source, 
    this.intention, 
    this.existingStreetLight,
    // this.equipmentType,
    });

  @override
  State<QrcodeScreen> createState() => _QrcodeScreenState();
}

class _QrcodeScreenState extends State<QrcodeScreen> {
  String? scannedCode;
  bool isScanned = false;
  Timer? _timer;

  void _onDetect(BarcodeCapture capture) {
    final String? code = capture.barcodes.first.rawValue;


    if (code != null && !isScanned) {
      setState(() {
        scannedCode = code;
        isScanned = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Code QR détecté"),
          backgroundColor: Colors.green,
        ),
      );


    if (widget.intention == "update") {
    context.router.replace(
     LampadaireRoute(
          qrCode: scannedCode,
          streetLight: widget.existingStreetLight, // Données existantes
          isEditMode: true,
          source: SourceProvider.MaintenanceProvider,
        ),
    );
  }

      _timer = Timer(const Duration(seconds: 0), () {
        if (!mounted) return;

        if (widget.source == SourceProvider.ArmoireProvider) {
          Navigator.pop(context, scannedCode);
        } else if (widget.source == SourceProvider.LampadaireProvider) {
          Navigator.pop(context, scannedCode);
        } else {
          context.router.replace(PhotoRoute(
            mission: widget.mission!, 
            qrCode: scannedCode!, 
            // equipmentType: widget.equipmentType!
            ));
        }
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.colorScheme.primary,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Scan du Qr Code",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10),

            // Texte d'instructions ou message de succès
            const Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                "Veuillez scanner le code QR",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: hauteur(context, 20)),

            // Zone de scan de QR code
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: MobileScanner(
                  controller: MobileScannerController(
                    facing: CameraFacing.back,
                    detectionSpeed: DetectionSpeed.normal,
                    formats: [BarcodeFormat.qrCode], // Limite aux QR codes
                  ),
                  onDetect: _onDetect, // Appelé lorsqu'un QR est détecté
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const Spacer(),

            if (scannedCode != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  "Redirection en cour...",
                  style: TextStyle(color: context.colorScheme.primary),
                ),
              ),

            SizedBox(height: hauteur(context, 20)),
          ],
        ),
      ),
    );
  }
}
