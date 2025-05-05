import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:lifesphere_essentials/injection/injection.dart';
import 'package:lifesphere_essentials/lifesphere_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  configureDependencies();

  runApp(const MyApp());
}
