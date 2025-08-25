import 'package:hive/hive.dart';
import 'package:sopaki_app/src/shared/model/sync_log/sync_log.dart';

class OfflineStorage {
  static const String dataBoxName = 'offline_relec_data';
  static const String historyBoxName = 'sync_history';

  Future<void> saveOfflineData(dynamic data) async {
    final box = await Hive.openBox(dataBoxName);
    await box.add(data);
  }

  Future<List<MapEntry<dynamic, dynamic>>> getOfflineData() async {
    final box = await Hive.openBox(dataBoxName);
    return box.toMap().entries.toList();
  }

  Future<void> deleteOfflineData(dynamic key) async {
    final box = await Hive.openBox(dataBoxName);
    await box.delete(key);
  }

  Future<void> saveSyncLog(SyncLog log) async {
    final box = await Hive.openBox(historyBoxName);
    await box.add(log);
  }

  Future<List<SyncLog>> getSyncHistory() async {
    final box = await Hive.openBox(historyBoxName);
    return box.values.cast<SyncLog>().toList();
  }
}