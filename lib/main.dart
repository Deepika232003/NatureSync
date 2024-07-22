import 'package:naturesync/data/models/plant_model.dart';
import 'package:naturesync/presentation/screens/dashboard/models/viewtype_model.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:naturesync/app.dart';

import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Registering adapters
  Hive.registerAdapter(ViewTypeAdapter());
  Hive.registerAdapter(PlantAdapter());

  // Opening the databases
  await Hive.openBox('plants');
  await Hive.openBox('settings');

  runApp(const ProviderScope(child: NatureSync()));
}
