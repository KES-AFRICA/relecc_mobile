class EquipmentItem {
  final dynamic item; // Peut être CabinetResponse, MeterResponse ou StoreStreetLightResponse
  final String type; // 'cabinet', 'meter' ou 'streetLight'

  EquipmentItem(this.item, this.type);
}