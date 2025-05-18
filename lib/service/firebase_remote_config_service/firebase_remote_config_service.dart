abstract class RemoteConfigService {
  Future<void> initialize();
  Future<List<dynamic>> getJsonData(String key);
}
