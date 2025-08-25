import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/core/theme/dimens.dart';
import 'package:sopaki_app/src/features/armoire/logic/controller/bloc/armoire_intervention_bloc/armoire_intervention_cubit.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/lampadaire/components/number_input.dart';
import 'package:sopaki_app/src/features/lampadaire/components/primary_button_style.dart';
import 'package:sopaki_app/src/features/lampadaire/components/select_input.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/shared/components/app_appbar.dart';
import 'package:sopaki_app/src/shared/components/buttons/button.dart';
import 'package:sopaki_app/src/shared/components/dialogs/api_error_dialog.dart';
import 'package:sopaki_app/src/shared/components/dialogs/dialog_builder.dart';
import 'package:sopaki_app/src/shared/components/toast.dart';
import 'package:sopaki_app/src/shared/model/default.model.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/responsive/screen.dart';
import 'package:sopaki_app/src/shared/services/location_service.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

@RoutePage<void>()
class ArmoireDeploiementFormScreen extends StatefulWidget
    implements AutoRouteWrapper {
  final MissionResponse missionResponse;
  final MeterResponse? meter;
  final String? qrCode;
  final XFile? photo;
  final String? source;

  const ArmoireDeploiementFormScreen({
    super.key,
    required this.missionResponse,
    this.qrCode,
    this.photo,
    this.source,
    this.meter,
  });

  @override
  State<ArmoireDeploiementFormScreen> createState() =>
      _ArmoireDeploiementFormScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => ArmoireInterventionCubit(),
      ),
    ], child: this);
  }
}

class _ArmoireDeploiementFormScreenState
    extends State<ArmoireDeploiementFormScreen> with TickerProviderStateMixin {
  final LocationService _locationService = LocationService();
  bool isLoading = true;

  String _locationString = "0,0";
  Location location = Location();
  String? _streetName;
  int? municipalityId;
  int? isPresent;
  int? isFunctional;

  late AnimationController _refreshController;
  late Animation<double> _refreshAnimation;
  bool _isRefreshing = false;

  // Local state for QR code and photo
  String? _qrCode;
  XFile? _photo;

  Future<void> _fetchLocation() async {
    setState(() {
      _isRefreshing = true;
    });
    _refreshController.repeat(); // Démarre l'animation de rotation
    final locationData = await _locationService.getCurrentLocation();
    _refreshController.stop(); // Arrête l'animation
    _refreshController.reset();

    if (locationData != null) {
      setState(() {
        _locationString = locationData['coordinates'] ?? '';
        _streetName = locationData['streetName'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('Erreur lors de la récupération de la localisation')),
      );
    }
    setState(() {
      _isRefreshing = false;
    });
  }

  ResponseModel<Cabinet>? cabinetData;

  // TextEditingController
  final nombreLampadaireController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fetchLocation();
    context.read<ArmoireInterventionCubit>().getAllCabinetInformation();
    // Initialize local state with widget properties
    if (widget.source == SourceProvider.CameraProvider) {
      _qrCode = widget.qrCode;
      _photo = widget.photo;
    }
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _refreshAnimation = CurvedAnimation(
      parent: _refreshController,
      curve: Curves.linear,
    );
  }

  @override
  void dispose() {
    _refreshController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<ArmoireInterventionCubit, ArmoireInterventionState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () => LoadingDialog.show(context: context),
              success: (response) {
                LoadingDialog.hide(context: context);
                setState(() {
                  cabinetData = response;
                  isLoading = false;
                });
              },
              storeSuccess: (response) {
                LoadingDialog.hide(context: context);
                Toast.show(
                  context: context,
                  message: "Armoire créer avec succès",
                  type: ToastType.succes,
                  duration: const Duration(seconds: 3),
                );
                setState(() {
                  context.router.push(LampadaireRoute(
                      missionResponse: widget.missionResponse,
                      cabinet: response.data?.cabinet,
                      meter: widget.meter));
                });
              },
              failure: (error) {
                LoadingDialog.hide(context: context);
                ApiErrorDialog.show(context: context, error: error);
                setState(() {
                  isLoading = false;
                });
              },
            );
          },
        )
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(hauteur(context, 50)),
          child: const AppAppBar(title: "Armoire"),
        ),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: largeur(context, 10)),
                child: ListView(
                  children: [
                     Visibility(
                      visible: widget.source != SourceProvider.CameraProvider,
                      child: Column(
                        children: [
                          const SizedBox(height: Dimens.spacing),
                          Button.primary(
                            title: "Scanner un qr code",
                            iconSvgOrPng: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.qr_code_scanner,
                                    color: Colors.white),
                                if (_qrCode != null && _qrCode!.isNotEmpty) ...[
                                  const SizedBox(width: 8),
                                  const Icon(Icons.check_circle,
                                      color: Colors.green),
                                ],
                              ],
                            ),
                            onPressed: () {
                              context.router
                                  .push(QrcodeRoute(
                                      source: SourceProvider.ArmoireProvider))
                                  .then((value) {
                                log("qrcode pris:$value");
                                setState(() {
                                  _qrCode = value.toString();
                                });
                              });
                            },
                          ),
                          const SizedBox(height: Dimens.spacing),
                          Button.primary(
                            title: "Prendre une photo",
                            iconSvgOrPng: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.camera_alt,
                                    color: Colors.white),
                                if (_photo != null) ...[
                                  const SizedBox(width: 8),
                                  const Icon(Icons.check_circle,
                                      color: Colors.green),
                                ],
                              ],
                            ),
                            onPressed: () {
                              context.router
                                  .push(PhotoRoute(
                                      source: SourceProvider.ArmoireProvider))
                                  .then((value) {
                                log("photo pris:$value");
                                setState(() {
                                  _photo = value as XFile?;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: Dimens.spacing,
                    ),
                    NumberInput(
                      hint: "Nombre de lampadaire",
                      controller: nombreLampadaireController,
                      focus: false,
                    ),
                    SelectInput(
                      items: cabinetData?.data?.municipalities ?? [],
                      hint: 'Commune',
                      onValueChanged: (value) {
                        municipalityId = value!.id;
                        setState(() {});
                      },
                    ),
                    SelectInput(
                      items: yesOrNoData,
                      hint: 'Fonctionnel ?',
                      onValueChanged: (value) {
                        isFunctional = value!.id;
                        setState(() {});
                      },
                    ),
                    SelectInput(
                      items: yesOrNoData,
                      hint: 'Present ?',
                      onValueChanged: (value) {
                        isPresent = value!.id;
                        setState(() {});
                      },
                    ),
                    const SizedBox(
                            height: Dimens.spacing,
                          ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Position actuelle:',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 5),
                          Text(_locationString),
                          if (_streetName != null) ...[
                            const SizedBox(height: 5),
                            Text("$_streetName"),
                          ],
                          const SizedBox(height: 10),
                          ElevatedButton.icon(
                            onPressed: _fetchLocation,
                            icon: _isRefreshing
                                ? RotationTransition(
                                    turns: _refreshAnimation,
                                    child: Icon(Icons.refresh))
                                : const Icon(Icons.refresh),
                            label: Text(_isRefreshing
                                ? 'Actualisation...'
                                : 'Actualiser la position'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: hauteur(context, 20),
                    ),
                    ElevatedButton(
                        onPressed: () {
//                           if (widget.photo == null && _photo == null) {
//   Toast.show(context: context, 
//     message: "Photo manquante", 
//     type: ToastType.error);
//   return;
// }

// final photoToUse = widget.photo ?? _photo!;
//                             if (_photo == null) {
//     Toast.show(context: context, message: "Veuillez prendre une photo", type: ToastType.warning);
//     return;
//   }

//   if (nombreLampadaireController.text.isEmpty) {
//     Toast.show(context: context, message: "Veuillez saisir le nombre de lampadaires", type: ToastType.warning);
//     return;
//   }

//   if (municipalityId == null || isFunctional == null || isPresent == null) {
//     Toast.show(context: context, message: "Veuillez remplir tous les champs", type: ToastType.warning);
//     return;
//   }

                          StoreCabinetInformation storeCabinet =
                              StoreCabinetInformation(
                                  street: _streetName,
                                  qrcode: _qrCode,
                                  isFunctional: isFunctional,
                                  isPresent: isPresent,
                                  location: _locationString,
                                  municipalityId: municipalityId,
                                  meterId: widget.meter?.id,
                                  lampCount: int.parse(
                                      nombreLampadaireController.text));

                          context
                              .read<ArmoireInterventionCubit>()
                              .storeCabinetInformation(
                                  photo: _photo!, storeCabinet: storeCabinet);
                        },
                        style: primaryButtonStyle(),
                        child: const Text(
                          "Enregistrer",
                          style: TextStyle(color: Colors.white),
                        )),
                    SizedBox(
                      height: hauteur(context, 20),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
