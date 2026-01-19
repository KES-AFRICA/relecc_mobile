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
  final String? source;
  final String? intention;
  final StoreStreetLightResponse? existingStreetLight;

  const QrcodeScreen({
    super.key, 
    this.mission, 
    this.source, 
    this.intention, 
    this.existingStreetLight,
  });

  @override
  State<QrcodeScreen> createState() => _QrcodeScreenState();
}

class _QrcodeScreenState extends State<QrcodeScreen> {
  String? scannedCode;
  bool isScanned = false;
  Timer? _timer;
  final TextEditingController _manualCodeController = TextEditingController();
  bool _showManualInput = false;

  void _handleCodeDetected(String code) {
    if (code.isNotEmpty && !isScanned) {
      setState(() {
        scannedCode = code;
        isScanned = true;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Code détecté"),
          backgroundColor: Colors.green,
        ),
      );

      if (widget.intention == "update") {
        context.router.replace(
          LampadaireRoute(
            qrCode: scannedCode,
            streetLight: widget.existingStreetLight,
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
          ));
        }
      });
    }
  }

  void _onDetect(BarcodeCapture capture) {
    final String? code = capture.barcodes.first.rawValue;
    if (code != null) {
      _handleCodeDetected(code);
    }
  }

  void _submitManualCode() {
    final code = _manualCodeController.text.trim();
    if (code.isNotEmpty) {
      _handleCodeDetected(code);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Veuillez saisir un code"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _manualCodeController.dispose();
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
        actions: [
          IconButton(
            icon: Icon(
              _showManualInput ? Icons.qr_code_scanner : Icons.keyboard,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _showManualInput = !_showManualInput;
              });
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height / 10),

            if (_showManualInput) ...[
              // Interface de saisie manuelle
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  "Saisie manuelle du code",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),

              SizedBox(height: hauteur(context, 20)),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: TextField(
                  controller: _manualCodeController,
                  decoration: InputDecoration(
                    labelText: 'Code QR',
                    hintText: 'Entrez le code QR manuellement',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    prefixIcon: const Icon(Icons.qr_code),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => _manualCodeController.clear(),
                    ),
                  ),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _submitManualCode(),
                ),
              ),

              SizedBox(height: hauteur(context, 30)),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton(
                  onPressed: _submitManualCode,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text(
                    'Valider',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ] else ...[
              // Interface de scan QR code
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
                      formats: [BarcodeFormat.qrCode],
                    ),
                    onDetect: _onDetect,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

             
            ],

            const Spacer(),

            if (scannedCode != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 24.0),
                child: Text(
                  "Redirection en cours...",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: context.colorScheme.primary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

            SizedBox(height: hauteur(context, 20)),
          ],
        ),
      ),
    );
  }
}