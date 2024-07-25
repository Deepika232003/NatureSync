import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:image_picker/image_picker.dart';

import 'package:naturesync/data/models/themes_model.dart';
import 'package:naturesync/data/providers/theme_provider.dart';
import 'package:naturesync/logic/image_picker/image_picker.dart';
import 'package:naturesync/presentation/widgets/elevated_notification.dart';
import 'package:naturesync/presentation/widgets/buttons/appbar_leading_button.dart';

class LeafScanner extends ConsumerStatefulWidget {
  const LeafScanner({super.key});

  @override
  _LeafScannerState createState() => _LeafScannerState();
}

class _LeafScannerState extends ConsumerState<LeafScanner> {
  Uint8List? imageBytes;

  @override
  Widget build(BuildContext context) {
    Themes theme = ref.watch(themesProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: theme.backgroundColor,
        leading: LeadingButton(
          iconColor: theme.textColor,
          backgroundColor: theme.primaryColor,
        ),
        title: Text(
          "LEAF SCANNER",
          style: GoogleFonts.rubik(
            color: theme.textColor,
            fontSize: 16,
          ),
        ),
      ),
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  // Display selected image or animation
                  if (imageBytes != null)
                    Image.memory(
                      imageBytes!,
                      width: MediaQuery.of(context).size.width / 1.5,
                      height: MediaQuery.of(context).size.width / 1.5,
                      fit: BoxFit.cover,
                    )
                  else
                    Lottie.asset("assets/animations/taking_a_picture.json",
                        width: 128, height: 128),

                  Column(
                    children: [
                      Text(
                        "Choose a picture of the leaf",
                        style: GoogleFonts.openSans(
                          color: theme.textColor,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        "Make sure the leaf is clear and well-lit",
                        style: GoogleFonts.openSans(
                          color: theme.textColor,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(color: theme.primaryColor),
                    width: MediaQuery.of(context).size.width - 50,
                    height: 4,
                  ),
                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(12.0),
                          backgroundColor: theme.secondaryColor,
                        ),
                        onPressed: () async {
                          Uint8List? selectedImage = await ImageSelector().pickImage(ImageSource.gallery);

                          if (context.mounted) {
                            if (selectedImage == null) {
                              showElevatedNotification(
                                  context,
                                  "Invalid image selected. Please try again.",
                                  theme.secondaryColor);
                              return;
                            }
                            setState(() {
                              imageBytes = selectedImage;
                            });
                          }
                        },
                        icon: Icon(
                          Icons.image,
                          color: theme.textColor,
                          size: 20,
                        ),
                        label: Text(
                          "Gallery",
                          style: GoogleFonts.openSans(
                            color: theme.textColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      if (imageBytes != null)
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.all(12.0),
                            backgroundColor: theme.secondaryColor,
                          ),
                          onPressed: () {
                            // Add your scan functionality here
                            showElevatedNotification(
                              context,
                              "Scan functionality to be implemented.",
                              theme.secondaryColor,
                            );
                          },
                          child: Text(
                            "Scan",
                            style: GoogleFonts.openSans(
                              color: theme.textColor,
                              fontSize: 14,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
