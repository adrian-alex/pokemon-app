///
/// Local Storage
///
abstract class StorageService {
  Future<void> putString(String key, String value) async {}
  Future<void> putInt(String key, int value) async {}
  Future<String?> getString(String key);
  Future<int?> getInt(String key);
  Future<void> clearStorage() async {}
  refresh() async {}
}
