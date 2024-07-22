import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:naturesync/config.dart';

import 'package:naturesync/data/models/themes_model.dart';
import 'package:naturesync/data/providers/theme_provider.dart';
import 'package:naturesync/logic/settings_logic/settings_handler.dart';
import 'package:naturesync/logic/localization/localization_handler.dart';
import 'package:naturesync/logic/localization/providers/language_provider.dart';
import 'package:naturesync/presentation/themes/dark_theme.dart';
import 'package:naturesync/presentation/themes/light_theme.dart';
import 'package:naturesync/presentation/widgets/buttons/appbar_leading_button.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Themes theme = ref.watch(themesProvider);
    String locale = ref.watch(languageProvider);
    SettingsHandler settingsHandler = SettingsHandler();
    LocalizationHandler localizationHandler = LocalizationHandler();

    TextEditingController openAIKeyController =
        TextEditingController(text: settingsHandler.getValue('openai_key'));

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.backgroundColor,
        leading: LeadingButton(
          iconColor: theme.textColor,
          backgroundColor: theme.primaryColor,
        ),
        title: Text(
          localizationHandler.getMessage(ref, "settings").toUpperCase(),
          style: GoogleFonts.rubik(
            color: theme.textColor,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 16),

              // Theme
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        localizationHandler.getMessage(
                            ref, "settings_choose_theme"),
                        style: GoogleFonts.openSans(
                          color: theme.textColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: theme.id == 0
                                ? theme.primaryColor
                                : theme.secondaryColor,
                            borderRadius: const BorderRadius.horizontal(
                                left: Radius.circular(16)),
                          ),
                          child: IconButton(
                            onPressed: () {
                              ref.read(themesProvider.notifier).state =
                                  DarkTheme();

                              settingsHandler.setValue('app_theme', 'dark');
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            color: theme.textColor,
                            icon: const Icon(
                              Icons.nightlight,
                              size: 20,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: theme.id == 1
                                ? theme.primaryColor
                                : theme.secondaryColor,
                            borderRadius: const BorderRadius.horizontal(
                                right: Radius.circular(16)),
                          ),
                          child: IconButton(
                            onPressed: () {
                              ref.read(themesProvider.notifier).state =
                                  LightTheme();
                              settingsHandler.setValue('app_theme', 'light');
                            },
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            color: theme.textColor,
                            icon: const Icon(
                              Icons.sunny,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Language
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child: Text(
                        localizationHandler.getMessage(
                            ref, "settings_choose_language"),
                        style: GoogleFonts.openSans(
                          color: theme.textColor,
                          fontSize: 15,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Container(
                      decoration: BoxDecoration(
                        color: theme.secondaryColor,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          value: locale,
                          dropdownColor: theme.secondaryColor,
                          iconEnabledColor: theme.primaryColor,
                          onChanged: (String? newLocale) {
                            if (newLocale != null) {
                              ref.read(languageProvider.notifier).state =
                                  newLocale;
                              settingsHandler.setValue(
                                  'app_language', newLocale);
                            }
                          },
                          items: [
                            DropdownMenuItem(
                              value: "de",
                              child: Text(
                                "🇩🇪 Deutsch",
                                style: TextStyle(color: theme.textColor),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "en",
                              child: Text(
                                "🇬🇧 English",
                                style: TextStyle(color: theme.textColor),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "es",
                              child: Text(
                                "🇪🇸 Española",
                                style: TextStyle(color: theme.textColor),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "fr",
                              child: Text(
                                "🇫🇷 Français",
                                style: TextStyle(color: theme.textColor),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "it",
                              child: Text(
                                "🇮🇹 Italiana",
                                style: TextStyle(color: theme.textColor),
                              ),
                            ),
                            DropdownMenuItem(
                              value: "ro",
                              child: Text(
                                "🇷🇴 Română",
                                style: TextStyle(color: theme.textColor),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 4),

              // OpenAI Key
              Divider(color: theme.secondaryColor),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      localizationHandler.getMessage(
                          ref, "settings_provide_key"),
                      style: GoogleFonts.openSans(
                        color: theme.textColor,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      width: MediaQuery.of(context).size.width - 32,
                      decoration: BoxDecoration(
                        color: theme.secondaryColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: openAIKeyController,
                        maxLines: 1,
                        maxLength: 128,
                        obscureText: true,
                        style: TextStyle(color: theme.textColor),
                        decoration: InputDecoration(
                          hintText: "OpenAI Key",
                          hintStyle: TextStyle(color: theme.textColor),
                          contentPadding: const EdgeInsets.all(8.0),
                          border: InputBorder.none,
                          counterText: "",
                        ),
                        cursorColor: theme.primaryColor,
                        textAlignVertical: TextAlignVertical.top,
                        onChanged: (key) =>
                            settingsHandler.setValue('openai_key', key),
                      ),
                    ),
                  ],
                ),
              ),

              Divider(color: theme.secondaryColor),

              // Application Version
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  localizationHandler
                      .getMessage(ref, "settings_current_version")
                      .replaceAll("%version%", applicationVersion)
                      .replaceAll("%platform%", Platform.operatingSystem),
                  style: GoogleFonts.openSans(
                    color: theme.textColor,
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
