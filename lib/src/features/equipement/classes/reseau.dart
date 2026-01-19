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
  final String name;
  final String type;
  final String municipality;
  final int streetlightCount;
  final double distance;
  final double totalPower;
  final DateTime? createdAt;
  final int? cabinetId;  // Optionnel
  final int? meterId;    // Optionnel
  final String? location; // Optionnel
  final List<int>? streetLightIds; // Optionnel

  IndividualNetwork({
    required this.id,
    required this.name,
    required this.type,
    required this.municipality,
    required this.streetlightCount,
    required this.distance,
    required this.totalPower,
    this.createdAt,
    this.cabinetId,
    this.meterId,
    this.location,
    this.streetLightIds,
  });

  factory IndividualNetwork.fromJson(Map<String, dynamic> json) {
    return IndividualNetwork(
      id: json['id']?.toString() ?? '',
      name: json['name'] ?? json['type_label'] ?? 'Réseau',
      type: json['type'] ?? 'unknown',
      municipality: json['municipality'] ?? 'Inconnue',
      streetlightCount: json['streetlight_count'] ?? 0,
      distance: (json['distance_km'] ?? 0).toDouble(),
      totalPower: (json['total_power_w'] ?? 0).toDouble(),
      createdAt: json['created_at_iso'] != null 
        ? DateTime.tryParse(json['created_at_iso']) 
        : null,
      cabinetId: json['cabinet_id'],
      meterId: json['meter_id'],
      location: json['location'],
      streetLightIds: (json['streetlight_ids'] as List<dynamic>?)
          ?.map((e) => e is int ? e : int.tryParse(e.toString()) ?? 0)
          .where((id) => id > 0)
          .toList(),
    );
  }
}