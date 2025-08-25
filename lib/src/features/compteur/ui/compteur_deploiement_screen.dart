import 'dart:developer';

import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/core/theme/dimens.dart';
import 'package:sopaki_app/src/features/compteur/logic/controller/bloc/compteur_intervention_bloc/compteur_intervention_cubit.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/lampadaire/components/number_input.dart';
import 'package:sopaki_app/src/features/lampadaire/components/primary_button_style.dart';
import 'package:sopaki_app/src/features/lampadaire/components/select_input.dart';
import 'package:sopaki_app/src/features/lampadaire/components/text_input.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/features/modal/equipment_type_modal.dart';
import 'package:sopaki_app/src/shared/components/app_appbar.dart';
import 'package:sopaki_app/src/shared/components/buttons/button.dart';
import 'package:sopaki_app/src/shared/components/dialogs/api_error_dialog.dart';
import 'package:sopaki_app/src/shared/components/dialogs/dialog_builder.dart';
import 'package:sopaki_app/src/shared/components/toast.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/responsive/screen.dart';
import 'package:sopaki_app/src/shared/services/location_service.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';

@RoutePage<void>()
class CompteurDeploiementFormScreen extends StatefulWidget implements AutoRouteWrapper {
  final MissionResponse missionResponse;
  final String? qrCode;
  final XFile? photo;
  final String? source;

  const CompteurDeploiementFormScreen({
    super.key,
    required this.missionResponse,
    this.qrCode,
    this.photo,
    this.source,
  });

  @override
  State<CompteurDeploiementFormScreen> createState() => _CompteurDeploiementFormScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(providers: [
      BlocProvider(
        create: (_) => CompteurInterventionCubit(),
      ),
    ], child: this);
  }
}

class _CompteurDeploiementFormScreenState extends State<CompteurDeploiementFormScreen> with TickerProviderStateMixin {
  String qrResult = "";

  late String qrCode = "";
  XFile? imagePath;

  bool isLoading = true;
  // TextEditingController
  final meterNumberController = TextEditingController();

  late AnimationController _refreshController;
  late Animation<double> _refreshAnimation;
  bool _isRefreshing = false;


  ResponseModel<Meter>? meterData;
  final marqueController = TextEditingController();
  final modeleController = TextEditingController();
  String _locationString = "0,0";
  String? _streetName;
  int? municipalityId;
  int? meterTypeId;
  final LocationService _locationService = LocationService();

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
        const SnackBar(content: Text('Erreur lors de la récupération de la localisation')),
      );
    }
    setState(() {
  _isRefreshing = false;
});

  }

  @override
  void initState() {
    super.initState();
    _fetchLocation();
    context.read<CompteurInterventionCubit>().getAllMeterInformation();
        _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync:this,
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
        BlocListener<CompteurInterventionCubit, CompteurInterventionState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () => LoadingDialog.show(context: context),
              success: (response) {
                LoadingDialog.hide(context: context);
                setState(() {
                  meterData = response;
                  isLoading = false;
                });
              },
              storeSuccess: (response) {
                LoadingDialog.hide(context: context);
                Toast.show(
                  context: context,
                  message: "Compteur créer avec succès",
                  type: ToastType.succes,
                  duration: const Duration(seconds: 3),
                );
                setState(() {
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
                        mission: widget.missionResponse,
                        meter: response.data?.meter,
                        source: SourceProvider.CompteurProvider,
                        isMeterVisible: false,
                      );
                    },
                  );
                  //context.router.push( LampadaireRoute(missionResponse: widget.missionResponse));
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
          child: const AppAppBar(title: "Compteur"),
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
                          const SizedBox(
                            height: Dimens.spacing,
                          ),
                          Button.primary(
                            title: "Scanner un qr code",
                            iconSvgOrPng: const Icon(
                              Icons.qr_code_scanner,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              context.router.push(QrcodeRoute(source: SourceProvider.LampadaireProvider)).then((value) {
                                log("qrcode pris:$value");
                                setState(() {
                                  qrCode = value.toString();
                                });
                              });
                            },
                          ),
                          const SizedBox(
                            height: Dimens.spacing,
                          ),
                          Button.primary(
                            title: "Prendre une photo",
                            iconSvgOrPng: const Icon(
                              Icons.camera_alt,
                              color: Colors.white,
                            ),
                            onPressed: () {
                              context.router.push(PhotoRoute(source: SourceProvider.LampadaireProvider)).then((value) {
                                log("photo pris:$value");
                                setState(() {
                                  imagePath = value as XFile?;
                                });
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: Dimens.spacing),
                    NumberInput(hint: "Numero du compteur", controller: meterNumberController, focus: false),
                    TextInput(
                      hint: "Marque",
                      controller: marqueController,
                      focus: false,
                      hide: false,
                    ),
                    TextInput(
                      hint: "Modele",
                      controller: modeleController,
                      focus: false,
                      hide: false,
                    ),
                    SelectInput(
                      items: meterData?.data?.municipalities ?? [],
                      hint: 'Commune',
                      onValueChanged: (value) {
                        municipalityId = value!.id;
                        setState(() {});
                      },
                    ),
                    SelectInput(
                      items: meterData?.data?.meterTypes ?? [],
                      hint: 'Type de compteur',
                      onValueChanged: (value) {
                        meterTypeId = value!.id;
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
                                        child:  Icon(Icons.refresh))
                                    : const Icon(Icons.refresh),
                                label: Text(_isRefreshing ? 'Actualisation...' : 'Actualiser la position'),
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
                          StoreMeterInformation storeMeter = StoreMeterInformation(
                              street: _streetName,
                              qrcode: widget.qrCode,
                              brand: marqueController.text,
                              model: modeleController.text,
                              location: _locationString,
                              municipalityId: municipalityId,
                              number: int.parse(meterNumberController.text));

                          context
                              .read<CompteurInterventionCubit>()
                              .storeMeterInformation(photo: widget.photo!, storeMeter: storeMeter);
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
