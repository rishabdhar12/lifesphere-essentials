import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'package:lifesphere_essentials/service/firebase_remote_config_service/firebase_remote_config_service.dart';

@Injectable(as: RemoteConfigService)
class RemoteConfigServiceImpl implements RemoteConfigService {
  final FirebaseRemoteConfig _remoteConfig;

  RemoteConfigServiceImpl(this._remoteConfig);

  @override
  Future<void> initialize() async {
    await _remoteConfig.setConfigSettings(
      RemoteConfigSettings(
        fetchTimeout: const Duration(seconds: 60),
        minimumFetchInterval: const Duration(hours: 1),
      ),
    );
    await _remoteConfig.fetchAndActivate();
  }

  @override
  Future<List<dynamic>> getJsonData(String key) async {
    try {
      final jsonString = _remoteConfig.getString(key);
      final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;
      return jsonList;
    } catch (e) {
      throw Exception('Failed to parse JSON data: $e');
    }
  }
}
