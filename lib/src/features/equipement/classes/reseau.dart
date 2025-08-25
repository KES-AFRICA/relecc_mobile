class NetworkSummary {
  final String type;
  final int count; // Nombre total de réseaux de ce type
  final int cabinetCount;
  final int meterCount;
  final int streetLightCount;
  final List<IndividualNetwork> networks; // Liste des réseaux individuels

  NetworkSummary({
    required this.type,
    required this.count,
    required this.cabinetCount,
    required this.meterCount,
    required this.streetLightCount,
    required this.networks,
  });
}

class IndividualNetwork {
  final String id;
  final String type;
  final int? cabinetId; // Changé de String? à int?
  final int? meterId;   // Changé de String? à int?
  final int streetLightCount;
  final String? location;
  final List<int> streetLightIds; // Nouvelle propriété pour stocker les IDs

  IndividualNetwork({
    required this.id,
    required this.type,
    this.cabinetId,
    this.meterId,
    required this.streetLightCount,
    this.location,
    required this.streetLightIds, // Ajouté
  });
}