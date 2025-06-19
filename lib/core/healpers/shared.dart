import 'package:shared_preferences/shared_preferences.dart';

class CashNetwork {
  static late SharedPreferences shardprf;

  static Future<SharedPreferences> intialise() async {
    return shardprf = await SharedPreferences.getInstance();
  }

  static Future<bool> set({required String key, required String value}) async {
    return await shardprf.setString(key, value);
  }

  static String? get({required String key}) {
    return shardprf.getString(key) ?? "";
  }

  static Future<bool> delet({required String key}) async {
    return await shardprf.remove(key);
  }

  static Future<bool> deletAll({required String key}) async {
    return await shardprf.clear();
  }
}
