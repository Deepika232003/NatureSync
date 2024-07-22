import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:naturesync/data/models/themes_model.dart';
import 'package:naturesync/presentation/themes/dark_theme.dart';
import 'package:naturesync/presentation/themes/light_theme.dart';
import 'package:naturesync/logic/settings_logic/settings_handler.dart';

final themesProvider = StateProvider<Themes>((ref) {
  SettingsHandler settingsHandler = SettingsHandler();
  String theme = settingsHandler.getValue('app_theme') ?? "system";

  switch (theme) {
    case "light":
      return LightTheme();
    case "dark":
      return DarkTheme();
    default:
      {
        Brightness systemBrightness =
            WidgetsBinding.instance.platformDispatcher.platformBrightness;

        return systemBrightness == Brightness.light
            ? LightTheme()
            : DarkTheme();
      }
  }
});
