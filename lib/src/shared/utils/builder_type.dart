enum MissionType {
  depannage('Dépannage'),
  deployement('Déploiement'),
  identification('Identification'),
  installation('Installation'),
  inventaire('Inventaire'),
  maintenance('Maintenance'),
  visite('Visite'),
  rapport('Rapport');

  final String value;
  const MissionType(this.value);

  static MissionType fromString(String value) {
    return MissionType.values.firstWhere(
      (context) => context.value == value,
      orElse: () => MissionType.rapport,
    );
  }

  @override
  String toString() => value;
}
