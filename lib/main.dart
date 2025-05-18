import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:lifesphere_essentials/core/constants/hive_constants.dart';
import 'package:lifesphere_essentials/injection/injection.dart';
import 'package:lifesphere_essentials/lifesphere_app.dart';
import 'package:lifesphere_essentials/service/firebase_remote_config_service/firebase_remote_config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  configureDependencies();

  await Hive.initFlutter();
  await Hive.openBox(HiveConstants.userBox);

  final remoteConfig = getIt<RemoteConfigService>();
  await remoteConfig.initialize();

  runApp(const MyApp());
}
