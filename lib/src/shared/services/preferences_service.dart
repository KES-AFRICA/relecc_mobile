import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  late final SharedPreferences preferences;

  Future<void> init() async {
    preferences = await SharedPreferences.getInstance();
  }

  ///Preference remove
  void removeCompanyTenant() {
    preferences.remove(companyIdKey);
  }

  void removeAll() {
    preferences.clear();
  }

  ///Preference Set
  Future<void> setCompanyId(String companyId) async {
    await preferences.setString(companyIdKey, companyId);
  }

  Future<void> setCompanyApiKey(String apiKey) async {
    await preferences.setString(companyApiKey, apiKey);
  }

  Future<void> setLoginAccessToken(String accessToken) async {
    await preferences.setString(loginAccessTokenKey, accessToken);
  }

  Future<void> setUserName(String userName) async {
    await preferences.setString(loginUserNameKey, userName);
  }

  Future<void> setLoginUserId(int userId) async {
    await preferences.setInt(loginUserIdKey, userId);
  }

  Future<void> setLoginRefreshKey(String refreshToken) async {
    await preferences.setString(loginRefreshTokenKey, refreshToken);
  }

    Future<void> setUserRole(String role) async {
    await preferences.setString(roleKey, role); // 👈 Ajout set rôle
  }

  Future<void> setUserCompany(String company) async {
    await preferences.setString(companyKey, company); // 👈 Ajout set company
  }
   Future<void> setUserEmail(String email) async {
    await preferences.setString(emailKey, email); // 👈 Ajout set email
  }

   Future<void> setUserTelephone(String telephone) async {
    await preferences.setString(telephoneKey, telephone); // 👈 Ajout set telephone
  }


  ///Preference Get
  String? getCompanyTenantId() {
    return preferences.getString(companyIdKey);
  }

  String? getCompanyApiKey() {
    return preferences.getString(companyApiKey);
  }

  String? getLoginAccessToken() {
    return preferences.getString(loginAccessTokenKey);
  }

  String? getLoginRefreshKey() {
    return preferences.getString(loginRefreshTokenKey);
  }

  String? getUserNameKey() {
    return preferences.getString(loginUserNameKey);
  }

  int? getUserIdKey() {
    return preferences.getInt(loginUserIdKey);
  }

  String? getUserRoleKey() {
    return preferences.getString(roleKey); // 👈 Ajout get rôle
  }

  String? getUserCompanyKey() {
    return preferences.getString(companyKey); // 👈 Ajout get company
  }

    String? getUserEmailKey() {
    return preferences.getString(emailKey); // 👈 Ajout get email
  }

   String? getUserTelephoneKey() {
    return preferences.getString(telephoneKey); // 👈 Ajout get telephone
  }

  ////////////////////////////////////////////////////////////////////////////
  // Dans PreferencesService
Future<void> setMissionsCache(String missionsJson) async {
  await preferences.setString('missions_cache', missionsJson);
}

Future<String?> getMissionsCache() async {
  return preferences.getString('missions_cache');
}

Future<void> setMissionsCacheTime(String isoTime) async {
  await preferences.setString('missions_cache_time', isoTime);
}

Future<String?> getMissionsCacheTime() async {
  return preferences.getString('missions_cache_time');
}

Future<void> setEquipmentCacheForMission(String missionId, String equipmentJson) async {
  await preferences.setString('equipment_cache_$missionId', equipmentJson);
}

Future<String?> getEquipmentCacheForMission(String missionId) async {
  return preferences.getString('equipment_cache_$missionId');
}

Future<void> setEquipmentCacheTime(String missionId, String isoTime) async {
  await preferences.setString('equipment_cache_time_$missionId', isoTime);
}

Future<String?> getEquipmentCacheTime(String missionId) async {
  return preferences.getString('equipment_cache_time_$missionId');
}

Future<void> clearMissionsCache() async {
  await preferences.remove('missions_cache');
  await preferences.remove('missions_cache_time');
}

Future<void> clearEquipmentCache() async {
  final keys = preferences.getKeys().where((key) => key.startsWith('equipment_cache'));
  for (var key in keys) {
    await preferences.remove(key);
  }
}

Future<void> clearEquipmentCacheForMission(String missionId) async {
  await preferences.remove('equipment_cache_$missionId');
  await preferences.remove('equipment_cache_time_$missionId');
}

Future<void> setCabinetsCache(String cabinetsJson) async {
  await preferences.setString('cabinets_cache', cabinetsJson);
}

Future<String?> getCabinetsCache() async {
  return preferences.getString('cabinets_cache');
}

Future<void> setCabinetsCacheTime(String isoTime) async {
  await preferences.setString('cabinets_cache_time', isoTime);
}

Future<String?> getCabinetsCacheTime() async {
  return preferences.getString('cabinets_cache_time');
}

Future<void> clearCabinetsCache() async {
  await preferences.remove('cabinets_cache');
  await preferences.remove('cabinets_cache_time');
}
  /////////////////////////////////////////////////////////////////////////////


  static const companyIdKey = 'tenant.id';
  static const companyApiKey = 'apiKey';
  static const loginAccessTokenKey = 'access_token';
  static const loginRefreshTokenKey = 'refresh_token';
  static const loginUserIdKey = 'user_id';
  static const loginUserNameKey = 'user_name';
  static const roleKey = 'user_role'; // 👈 Ajout de la clé du rôle
  static const companyKey = 'user_company'; // 👈 Ajout de la clé de la company
  static const emailKey = 'user_email'; // 👈 Ajout de la clé de la email
  static const telephoneKey = 'user_telephone'; // 👈 Ajout de la clé de la telephone
}
