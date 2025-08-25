import 'package:sopaki_app/src/shared/model/common_model/common.model.dart';

class YesOrNo {
  final int id;
  final String label;

  YesOrNo({required this.id, required this.label});
}


List<Common> yesOrNoData =[
  Common(id: 1, name: 'Oui'),
  Common(id: 0, name: 'Non'),
];