import 'package:hive/hive.dart';

part 'sync_log.g.dart';

@HiveType(typeId: 3)
class SyncLog extends HiveObject {

  @HiveField(1)
  final String itemName;

  @HiveField(4)
  final DateTime timestamp;

  SyncLog({
    required this.itemName,
    required this.timestamp,
  });
}