

import 'dart:developer';
import 'package:auto_route/auto_route.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sopaki_app/src/core/routing/app_router.dart';
import 'package:sopaki_app/src/core/theme/dimens.dart';
import 'package:sopaki_app/src/features/armoire/logic/model/cabinet.model.dart';
import 'package:sopaki_app/src/features/compteur/logic/model/meter.model.dart';
import 'package:sopaki_app/src/features/lampadaire/components/number_input.dart';
import 'package:sopaki_app/src/features/lampadaire/components/primary_button_style.dart';
import 'package:sopaki_app/src/features/lampadaire/components/select_input.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/controller/bloc/intervention_bloc/intervention_cubit.dart';
import 'package:sopaki_app/src/features/lampadaire/logic/model/street_light.model.dart';
import 'package:sopaki_app/src/features/mission/logic/model/mission.model.dart';
import 'package:sopaki_app/src/shared/components/buttons/button.dart';
import 'package:sopaki_app/src/shared/components/custom_appbar.dart';
import 'package:sopaki_app/src/shared/components/dialogs/api_error_dialog.dart';
import 'package:sopaki_app/src/shared/components/dialogs/dialog_builder.dart';
import 'package:sopaki_app/src/shared/components/toast.dart';
import 'package:sopaki_app/src/shared/extensions/context_extensions.dart';
import 'package:sopaki_app/src/shared/model/default.model.dart';
import 'package:sopaki_app/src/shared/model/response/response.model.dart';
import 'package:sopaki_app/src/shared/responsive/screen.dart';
import 'package:sopaki_app/src/shared/services/location_service.dart';
import 'package:sopaki_app/src/shared/services/source_provider.dart';
import 'package:sopaki_app/src/shared/utils/helpers.dart';

@RoutePage<void>()
class LampadaireScreen extends StatefulWidget implements AutoRouteWrapper {
  final MissionResponse? missionResponse;
  final CabinetResponse? cabinet;
  final MeterResponse? meter;
  final String? qrCode;
  final String? source;
  final XFile? photo;
  final StoreStreetLightResponse? streetLight;
  final bool? isEditMode;

  const LampadaireScreen({
    super.key,
    this.missionResponse,
    this.qrCode,
    this.photo,
    this.source,
    this.cabinet,
    this.meter,
    this.isEditMode,
    this.streetLight,
  });

  @override
  State<LampadaireScreen> createState() => _LampadaireScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => InterventionCubit(),
        ),
      ],
      child: this,
    );
  }
}

class _LampadaireScreenState extends State<LampadaireScreen>
    with TickerProviderStateMixin {
  late String _lampType = "";
  late String qrCode = "";
  XFile? imagePath;
  int? _lampStreetTypeId;
  int? _reseauTypeId;
  int? _municipalityId;
  int? _wayTypeId;
  int? _lampOrientationId;
  int? _lampCommandId;
  int? _supportTypeId;
  int? _conditionSupportId;
  int lampArmNumber = 0;
  int lampCount = 0;
  late AnimationController _refreshController;
  late Animation<double> _refreshAnimation;
  bool _isRefreshing = false;

  final LocationService _locationService = LocationService();
  String _locationString = '';
  String? _streetName;

  final TextEditingController _puissanceController = TextEditingController();
  final TextEditingController _lampCountController = TextEditingController();
  int? _lampPresentId;
  int? _lampLightTypeId;
  int? _lampColorTypeId;
  int? _onDayId;
  int? _onNightId;
  int? _lampWithBalastId;

  List<Map<String, dynamic>> lampForms = [];
  List<bool> expandedStates = [];

  ResponseModel<StreetLightInformation>? streetLightData;
  List<StoreStreetLampInformation> storeStreetLamp = [];
  bool isLoading = true;
  bool isFormSubmitSuccess = false;

  late TextEditingController _reportController = TextEditingController();
  bool _isReportEmpty = true; // Pour suivre si le champ rapport est vide

  @override
  void initState() {
    super.initState();
    _fetchLocation();
    qrCode = widget.qrCode ?? "";
    imagePath = widget.photo;
    context.read<InterventionCubit>().getAllStreetLightInformation();

    // Initialisation des données existantes en mode édition
    if (widget.isEditMode == true && widget.streetLight != null) {
      _initializeFormWithExistingData(widget.streetLight!);
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

  void _initializeFormWithExistingData(StoreStreetLightResponse streetLight) {
    setState(() {
      _lampStreetTypeId = streetLight.streetLightTypeId;
      _lampType = streetLight.streetLightType?.name ?? "";
      _reseauTypeId = streetLight.networkId;
      _municipalityId = streetLight.municipalityId;
      _wayTypeId = streetLight.trackId;
      _lampOrientationId = streetLight.orientationId;
      _lampCommandId = streetLight.commandTypeId;
      _supportTypeId = streetLight.supportTypeId;
      _conditionSupportId = streetLight.supportConditionId;
      _locationString = streetLight.location ?? "";
      _streetName = streetLight.street?.name;

      // Initialisation des lampes
      if (_lampType.contains("Mât d'éclairage")) {
        _lampCountController.text = streetLight.lampCount?.toString() ?? "1";
        lampCount = streetLight.lampCount ?? 1;
        _puissanceController.text = streetLight.power?.toString() ?? "";
        _lampPresentId = 1; // Supposé présent puisqu'il existe
        _lampLightTypeId = streetLight.streetLightTypeId;
      } else {
        lampArmNumber = Helpers().extractNumberFromString(_lampType) ?? 1;
        _initializeLampForms(lampArmNumber);
      }

      if (widget.isEditMode == true) {
        _reportController =
            TextEditingController(text: streetLight.report ?? "");
        _isReportEmpty = _reportController.text.isEmpty;
      }
    });
  }

  @override
  void dispose() {
    _reportController.dispose();
    _refreshController.dispose();
    _puissanceController.dispose();
    _lampCountController.dispose();
    for (var form in lampForms) {
      form['puissanceController']?.dispose();
    }
    super.dispose();
  }

  Future<void> _fetchLocation() async {
    setState(() {
      _isRefreshing = true;
    });
    _refreshController.repeat();

    final locationData = await _locationService.getCurrentLocation();
    _refreshController.stop();
    _refreshController.reset();

    if (locationData != null) {
      setState(() {
        _locationString = locationData['coordinates'] ?? '';
        _streetName = locationData['streetName'];
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Erreur lors de la récupération de la localisation'),
        ),
      );
    }

    setState(() {
      _isRefreshing = false;
    });
  }

  void _initializeLampForms(int count) {
    setState(() {
      lampForms = List.generate(
        count,
        (index) => {
          'puissanceController': TextEditingController(),
          'lampPresentId': null,
          'lampLightTypeId': null,
          'lampColorTypeId': null,
          'onDayId': null,
          'onNightId': null,
          'lampWithBalastId': null,
        },
      );
      expandedStates = List.filled(count, false);
    });
  }

  bool _validateForm({int? index}) {
    if (_lampType.contains("Mât d'éclairage")) {
      if (_lampLightTypeId == null ||
          _puissanceController.text.isEmpty ||
          _lampColorTypeId == null ||
          _lampPresentId == null ||
          lampCount <= 0 ||
          _lampCountController.text.isEmpty) {
        _showToast("Veuillez remplir tous les champs requis pour la lampe",
            ToastType.warning);
        return false;
      }
    } else {
      if (index == null || index >= lampForms.length) return false;
      final form = lampForms[index];
      if (form['lampLightTypeId'] == null ||
          form['puissanceController'].text.isEmpty ||
          form['lampColorTypeId'] == null ||
          form['lampPresentId'] == null) {
        _showToast(
            "Veuillez remplir tous les champs requis pour la lampe ${index + 1}",
            ToastType.warning);
        return false;
      }
    }
    return true;
  }

  Future<void> _submitLampData() async {
    storeStreetLamp.clear();

    if (_lampType.contains("Mât d'éclairage")) {
      if (!_validateForm()) return;
      final lampInfo = StoreStreetLampInformation(
        lampTypeId: _lampLightTypeId,
        power: int.parse(_puissanceController.text),
        colorId: _lampColorTypeId,
        hasLamp: _lampPresentId,
        withbalast: _lampWithBalastId,
        isOnNight: _onNightId,
        isOnDay: _onDayId,
      );
      storeStreetLamp = List.generate(lampCount, (_) => lampInfo);
    } else {
      for (int i = 0; i < lampForms.length; i++) {
        if (!_validateForm(index: i)) return;
        final form = lampForms[i];
        storeStreetLamp.add(StoreStreetLampInformation(
          lampTypeId: form['lampLightTypeId'],
          power: int.parse(form['puissanceController'].text),
          colorId: form['lampColorTypeId'],
          hasLamp: form['lampPresentId'],
          withbalast: form['lampWithBalastId'],
          isOnNight: form['onNightId'],
          isOnDay: form['onDayId'],
        ));
      }
    }

    final data = {
      'streetlight_type_id': _lampStreetTypeId!,
      'network_id': _reseauTypeId!,
      'orientation_id': _lampOrientationId!,
      'track_id': _wayTypeId!,
      'command_type_id': _lampCommandId!,
      'support_type_id': _supportTypeId!,
      'support_condition_id': _conditionSupportId!,
      'location': _locationString,
      'meter_id': widget.meter?.id,
      'lamp_count': storeStreetLamp.length,
      'cabinet_id': widget.cabinet?.id,
      'municipality_id': _municipalityId!,
      'lamps': storeStreetLamp.map((lamp) => lamp.toJson()).toList(),
      'street': _streetName ?? "",
      if (imagePath != null)
        'photo': await MultipartFile.fromFile(imagePath!.path),
      if (widget.isEditMode == true) 'report': _reportController.text,
    };

    try {
       if (widget.isEditMode == true && widget.streetLight?.id != null) {
        // Mode édition - utilise la nouvelle signature
        final updateData = <String, dynamic>{
          'streetlight_type_id': _lampStreetTypeId!,
          'network_id': _reseauTypeId!,
          'orientation_id': _lampOrientationId!,
          'track_id': _wayTypeId!,
          'command_type_id': _lampCommandId!,
          'support_type_id': _supportTypeId!,
          'support_condition_id': _conditionSupportId!,
          'location': _locationString,
          'lamp_count': storeStreetLamp.length,
          'municipality_id': _municipalityId!,
          'lamps': storeStreetLamp.map((lamp) => lamp.toJson()).toList(),
          'street': _streetName ?? "",
          // Ajout des champs optionnels seulement s'ils sont non null
          if (widget.meter?.id != null) 'meter_id': widget.meter!.id,
          if (widget.cabinet?.id != null) 'cabinet_id': widget.cabinet!.id,
          // Ajout du rapport s'il n'est pas vide
          if (_reportController.text.isNotEmpty) 'report': _reportController.text,
        };

        // Appel avec la nouvelle signature utilisant l'ID du streetlight
        context.read<InterventionCubit>().updateStreetLight(
              streetLightId: widget.streetLight!.id!,
              updateData: updateData,
              newPhoto: imagePath, // Nouvelle photo si sélectionnée
            );
      }  else {
        context.read<InterventionCubit>().storeStreetLightInformation(
              photo: widget.photo ?? imagePath!,
              storeStreetLight: StoreStreetLightInformation(
                qrcode: widget.qrCode ?? qrCode,
                streetlighttypeId: _lampStreetTypeId!,
                networkId: _reseauTypeId!,
                orientationId: _lampOrientationId!,
                trackId: _wayTypeId!,
                commandTypeId: _lampCommandId!,
                supportTypeId: _supportTypeId!,
                supportConditionId: _conditionSupportId!,
                location: _locationString,
                meterId: widget.meter?.id,
                lampCount: storeStreetLamp.length,
                cabinetId: widget.cabinet?.id,
                municipalityId: _municipalityId!,
                lamps: storeStreetLamp,
                street: _streetName ?? "",
              ),
            );
      }
    } catch (e) {
      debugPrint("Erreur soumission: $e");
    }
  }

  void _resetForm() {
    setState(() {
      lampForms.clear();
      expandedStates.clear();
      storeStreetLamp.clear();
      _puissanceController.clear();
      _lampCountController.clear();
      _lampPresentId = null;
      _lampLightTypeId = null;
      _lampColorTypeId = null;
      _onDayId = null;
      _onNightId = null;
      _lampWithBalastId = null;
      isFormSubmitSuccess = true;
    });
  }

  void _showToast(String message, ToastType type) {
    Toast.show(
      context: context,
      message: message,
      type: type,
      duration: const Duration(seconds: 3),
    );
  }

  Widget _buildLampForm(int index) {
    final form = lampForms[index];

    return StatefulBuilder(
      builder: (context, setState) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                color: Colors.brown,
                borderRadius: BorderRadius.circular(5),
              ),
              alignment: Alignment.center,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Information sur la lampe ${index + 1}",
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        expandedStates[index] = !expandedStates[index];
                      });
                    },
                    icon: Icon(
                      expandedStates[index]
                          ? Icons.arrow_circle_up
                          : Icons.arrow_circle_down_sharp,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            Visibility(
              visible: expandedStates[index],
              child: Column(
                children: [
                  SelectInput(
                    items: yesOrNoData,
                    hint: 'Lampe présente.?',
                    onValueChanged: (value) {
                      setState(() {
                        form['lampPresentId'] = value!.id;
                      });
                    },
                  ),
                  NumberInput(
                    hint: "Puissance de la lampe (Watt)",
                    controller: form['puissanceController'],
                    focus: false,
                  ),
                  SelectInput(
                    items: streetLightData?.data?.typeDeLampe ?? [],
                    hint: 'Type de lampe',
                    onValueChanged: (value) {
                      setState(() {
                        form['lampLightTypeId'] = value!.id;
                      });
                    },
                  ),
                  SelectInput(
                    hint: "Couleur de la lampe",
                    items: streetLightData?.data?.couleurs ?? [],
                    onValueChanged: (value) {
                      setState(() {
                        form['lampColorTypeId'] = value!.id;
                      });
                    },
                  ),
                  SelectInput(
                    hint: "Allumé jour.?",
                    items: yesOrNoData,
                    onValueChanged: (value) {
                      setState(() {
                        form['onDayId'] = value!.id;
                      });
                    },
                  ),
                  SelectInput(
                    hint: "Allumé nuit.?",
                    items: yesOrNoData,
                    onValueChanged: (value) {
                      setState(() {
                        form['onNightId'] = value!.id;
                      });
                    },
                  ),
                  SelectInput(
                    items: yesOrNoData,
                    hint: "Lampadaire équipé d'un balast.?",
                    onValueChanged: (value) {
                      setState(() {
                        form['lampWithBalastId'] = value!.id;
                      });
                    },
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildSingleLampForm() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: const Text(
            "Information sur la lampe",
            style: TextStyle(color: Colors.white, fontSize: 20),
            textAlign: TextAlign.center,
          ),
        ),
        SelectInput(
          items: yesOrNoData,
          hint: 'Lampe présente.?',
          onValueChanged: (value) {
            setState(() {
              _lampPresentId = value!.id;
            });
          },
        ),
        NumberInput(
          hint: "Puissance de la lampe (Watt)",
          controller: _puissanceController,
          focus: false,
        ),
        SelectInput(
          items: streetLightData?.data?.typeDeLampe ?? [],
          hint: 'Type de lampe',
          onValueChanged: (value) {
            setState(() {
              _lampLightTypeId = value!.id;
            });
          },
        ),
        SelectInput(
          hint: "Couleur de la lampe",
          items: streetLightData?.data?.couleurs ?? [],
          onValueChanged: (value) {
            setState(() {
              _lampColorTypeId = value!.id;
            });
          },
        ),
        SelectInput(
          hint: "Allumé jour.?",
          items: yesOrNoData,
          onValueChanged: (value) {
            setState(() {
              _onDayId = value!.id;
            });
          },
        ),
        SelectInput(
          hint: "Allumé nuit.?",
          items: yesOrNoData,
          onValueChanged: (value) {
            setState(() {
              _onNightId = value!.id;
            });
          },
        ),
        SelectInput(
          items: yesOrNoData,
          hint: "Lampadaire équipé d'un balast.?",
          onValueChanged: (value) {
            setState(() {
              _lampWithBalastId = value!.id;
            });
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<InterventionCubit, InterventionState>(
          listener: (context, state) {
            state.whenOrNull(
              loading: () => LoadingDialog.show(context: context),
              success: (response) {
                LoadingDialog.hide(context: context);
                setState(() {
                  streetLightData = response;
                  isLoading = false;
                });
              },
              storeSuccess: (response) {
                LoadingDialog.hide(context: context);
                setState(() {
                  if (response.success == true) {
                    isFormSubmitSuccess = true;
                    _showToast(
                        "${storeStreetLamp.length} lampe(s) enregistrée(s) avec succès",
                        ToastType.succes);
                    Alert(
                      context: context,
                      type: AlertType.success,
                      title: "Creation lampadaire",
                      desc: "Voulez-vous ajouter un autre lampadaire ?",
                      buttons: [
                        DialogButton(
                          color: context.colorScheme.onPrimary,
                          child: const Text(
                            "Oui",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          onPressed: () => Navigator.pop(context),
                        ),
                        DialogButton(
                          color: context.colorScheme.primary,
                          child: const Text(
                            "Non",
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                          onPressed: () {
                            context.router.push(EquipementRoute(
                                mission: widget.missionResponse!,
                                source: SourceProvider.LampFormProvider));
                          },
                        )
                      ],
                    ).show();
                  } else {
                    ApiErrorDialog.show(
                        context: context, error: response.message!);
                  }
                });
              },
              updateSuccess: (response) {
                LoadingDialog.hide(context: context);
                _showToast(
                    "Lampadaire mis à jour avec succès", ToastType.succes);
                context.router.pop(); // Retour à l'écran précédent
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
          child: CustomAppBar(
            title: widget.isEditMode == true
                ? "Modification Lampadaire"
                : "Création Lampadaire",
          ),
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: largeur(context, 10)),
                child: Form(
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
                                  if (qrCode.isNotEmpty) ...[
                                    const SizedBox(width: 8),
                                    const Icon(Icons.check_circle,
                                        color: Colors.green),
                                  ],
                                ],
                              ),
                              onPressed: () {
                                context.router
                                    .push(QrcodeRoute(
                                        source:
                                            SourceProvider.LampadaireProvider))
                                    .then((value) {
                                  log("qrcode pris:$value");
                                  setState(() {
                                    qrCode = value.toString();
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
                                  if (imagePath != null) ...[
                                    const SizedBox(width: 8),
                                    const Icon(Icons.check_circle,
                                        color: Colors.green),
                                  ],
                                ],
                              ),
                              onPressed: () {
                                context.router
                                    .push(PhotoRoute(
                                        source:
                                            SourceProvider.LampadaireProvider))
                                    .then((value) {
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
                      const SizedBox(height: 20),
                      SelectInput(
                        items: streetLightData?.data?.typeLampadaires ?? [],
                        hint: 'Type de Lampadaire',
                        onValueChanged: (value) {
                          setState(() {
                            _lampType = value!.name;
                            _lampStreetTypeId = value.id;
                            if (!_lampType.contains("Mât d'éclairage")) {
                              lampArmNumber = Helpers()
                                      .extractNumberFromString(value.name) ??
                                  1;
                              _initializeLampForms(lampArmNumber);
                            } else {
                              lampArmNumber = 0;
                              lampForms.clear();
                              expandedStates.clear();
                              _lampCountController.clear();
                            }
                          });
                        },
                        initialValue: widget.isEditMode == true
                            ? streetLightData?.data?.typeLampadaires
                                ?.firstWhere((e) => e.id == _lampStreetTypeId)
                            : null,
                      ),
                      Visibility(
                        visible: _lampType.contains("Mât d'éclairage"),
                        child: NumberInput(
                          hint: "Nombre de lampes",
                          controller: _lampCountController,
                          focus: false,
                          onChanged: (value) {
                            setState(() {
                              lampCount = int.tryParse(value) ?? 0;
                              lampForms = lampCount > 0 ? [{}] : [];
                              expandedStates =
                                  List.filled(lampForms.length, false);
                            });
                          },
                        ),
                      ),
                      SelectInput(
                        items: streetLightData?.data?.reseaux ?? [],
                        hint: 'Type de réseau',
                        onValueChanged: (value) => _reseauTypeId = value!.id,
                        initialValue: widget.isEditMode == true
                            ? streetLightData?.data?.reseaux
                                ?.firstWhere((e) => e.id == _reseauTypeId)
                            : null,
                      ),
                      SelectInput(
                        items: streetLightData?.data?.municipalites ?? [],
                        hint: 'Commune',
                        onValueChanged: (value) => _municipalityId = value!.id,
                        initialValue: widget.isEditMode == true
                            ? streetLightData?.data?.municipalites
                                ?.firstWhere((e) => e.id == _municipalityId)
                            : null,
                      ),
                      SelectInput(
                        hint: "Type de voie",
                        items: streetLightData?.data?.voies ?? [],
                        onValueChanged: (value) => _wayTypeId = value!.id,
                        initialValue: widget.isEditMode == true
                            ? streetLightData?.data?.voies
                                ?.firstWhere((e) => e.id == _wayTypeId)
                            : null,
                      ),
                      SelectInput(
                        hint: "Orientation du lampaire",
                        items: streetLightData?.data?.orientations ?? [],
                        onValueChanged: (value) =>
                            _lampOrientationId = value!.id,
                        initialValue: widget.isEditMode == true
                            ? streetLightData?.data?.orientations
                                ?.firstWhere((e) => e.id == _lampOrientationId)
                            : null,
                      ),
                      SelectInput(
                        items: streetLightData?.data?.commandes ?? [],
                        hint: "Type de commmande",
                        onValueChanged: (value) => _lampCommandId = value!.id,
                        initialValue: widget.isEditMode == true
                            ? streetLightData?.data?.commandes
                                ?.firstWhere((e) => e.id == _lampCommandId)
                            : null,
                      ),
                      SelectInput(
                        items: streetLightData?.data?.typesDeSupport ?? [],
                        hint: "Nature du support",
                        onValueChanged: (value) => _supportTypeId = value!.id,
                        initialValue: widget.isEditMode == true
                            ? streetLightData?.data?.typesDeSupport
                                ?.firstWhere((e) => e.id == _supportTypeId)
                            : null,
                      ),
                      SelectInput(
                        items: streetLightData?.data?.conditionsDeSupport ?? [],
                        hint: "Etat du support",
                        onValueChanged: (value) =>
                            _conditionSupportId = value!.id,
                        initialValue: widget.isEditMode == true
                            ? streetLightData?.data?.conditionsDeSupport
                                ?.firstWhere((e) => e.id == _conditionSupportId)
                            : null,
                      ),
                      const Divider(color: Colors.black87, thickness: 0.4),
                      if (_lampType.contains("Mât d'éclairage") &&
                          lampForms.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: _buildSingleLampForm(),
                        )
                      else
                        ...lampForms.asMap().entries.map((entry) => Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: _buildLampForm(entry.key),
                            )),
                      const SizedBox(height: Dimens.spacing),
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
                      if (widget.isEditMode == true)
                        Column(
                          children: [
                            const SizedBox(height: Dimens.spacing),
                            const Text(
                              'Rapport',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: Dimens.spacing),
                            
                            TextFormField(
                              controller: _reportController,
                              decoration: InputDecoration(
                                labelText: 'Rapport',
                                hintText: 'Rapport de maintenance', // Couleur noire pour le hintText
                                border: const OutlineInputBorder(),
                              ),
                              maxLines: 3,
                              onChanged: (value) {
                                setState(() {
                                  _isReportEmpty = value.isEmpty;
                                });
                              },
                            ),
                            const SizedBox(height: Dimens.spacing),
                          ],
                        ),
                      SizedBox(height: hauteur(context, 20)),
                      ElevatedButton(
                        onPressed: _submitLampData,
                        style: primaryButtonStyle().copyWith(
                          backgroundColor:
                              MaterialStateProperty.resolveWith<Color>(
                            (Set<MaterialState> states) {
                              if (states.contains(MaterialState.disabled)) {
                                return Colors.grey; // Couleur quand désactivé
                              }
                              return Theme.of(context)
                                  .primaryColor; // Couleur normale
                            },
                          ),
                        ),
                        child: Text(
                          widget.isEditMode == true
                              ? "Mettre à jour"
                              : "Enregistrer",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(height: hauteur(context, 10)),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
