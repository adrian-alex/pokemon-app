import 'package:data_repository/src/storage/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

///
/// Local Storage implementation
///
class StorageServiceImpl implements StorageService {
  Future<void> putString(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  Future<void> putInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(key, value);
  }

  @override
  Future<String?> getString(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  @override
  Future<int?> getInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  @override
  Future<void> clearStorage() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }

  @override
  refresh() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.reload();
  }
}
