
import 'package:flutter/material.dart';

class DemoConstants {

  static Color demoPrimaryGrey = Color.fromRGBO(112, 119, 122, 1.0);

  static Color demoAccentBlue = Color.fromRGBO(54, 204, 241, 1.0);

  static Color demoAccentBlueOpacityReduced = Color.fromRGBO(
      54, 241, 238, 0.4980392156862745);

  static Color demoLightGrey = Color.fromRGBO(248, 248, 248, 1.0);

  static Color demoUnselectedTab = Color.fromRGBO(223, 222, 222, 1.0);

  static Color demoMediumGrey = Color.fromRGBO(239, 239, 239, 1.0);

  static const Color demoSilver =  Color.fromRGBO(197, 201, 201, 1.0);

  static const Color demoTestEvaluationGreenBorder = Color.fromRGBO(83, 221, 108, 1.0);

  static const Color demoTestEvaluationGreen = Color.fromRGBO(83, 221, 108, 0.2);

  static const Color demoTestEvaluationRedBorder = Color.fromRGBO(207, 41, 4, 1.0);

  static const Color demoTestEvaluationRed = Color.fromRGBO(207, 41, 4, 0.2);

  static MaterialColor createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }


  static const String storageKey = "hswo.de";

  static const String currentUserState = "state";

  static const String keyCollectionEnabled = "hswo.de.collectionEnabled";



  // paths to image assets

  static const String fallbackImage = "https://t3.ftcdn.net/jpg/01/76/34/06/240_F_176340603_7KhvT2FkMD30TRRniRzeOX6FwjioMkSJ.jpg";

  static const String imageDemoLogoWhite = "assets/images/demo.png";

  static const String imageDemoLogoOrange = "assets/images/demo_orange.png";

  static const String imageBackgroundHomepageHeader = "assets/images/AdobeStock_166544349_Preview.jpeg";

}

enum AnalyticsContentType { Lesson, Course, Topic }

String enumToString(Object o) => o.toString().split('.').last;
