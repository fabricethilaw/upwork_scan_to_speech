import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class AIProvider {
  final textDetector = GoogleMlKit.vision.textDetector();

  Future<String> doTextRecognition(InputImage inputImage) async {
    final RecognisedText recognisedText =
        await textDetector.processImage(inputImage);
    // get the whole identified text
    String text = recognisedText.text;
    // extract each block of the text and guess the language
    Map<String, String> blocksAndLanguages = new Map<String, String>();
    for (TextBlock block in recognisedText.blocks) {
      final Rect rect = block.rect;
      final List<Offset> cornerPoints = block.cornerPoints;
      final String text = block.text;
      final List<String> languages = block.recognizedLanguages;
      blocksAndLanguages[text] = languages.first;

      /*for (TextLine line in block.lines) {
        // Same getters as TextBlock
        for (TextElement element in line.elements) {
          // Same getters as TextBlock
        }
      }*/
    }
    print(blocksAndLanguages);
    return text;
  }
}

//final String response = await languageIdentifier.identifyLanguage(text);
//final List<IdentifiedLanguage> response = await languageIdentifier.identifyPossibleLanguages(text);
