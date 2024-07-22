import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:naturesync/logic/settings_logic/settings_handler.dart';
import 'package:naturesync/presentation/screens/dashboard/models/viewtype_model.dart';

final viewTypeProvider = StateProvider<ViewType>((ref) {
  SettingsHandler settingsHandler = SettingsHandler();
  return settingsHandler.getValue('plants_viewtype') ?? ViewType.list;
});
