import 'dart:math';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:state_mgmnt_ex1/demo_constants.dart';
import 'package:ios_utsname_ext/extension.dart';
import 'package:state_mgmnt_ex1/cubit/error_cubit/error_cubit.dart';

class UiUtils {
  static double _bottomNavBarHeight;

  static Widget setAppBar(Color color, {bool needsBackButton = false}) {
    var appBar = AppBar(
      elevation: 0.0,
      backgroundColor: color,
      title: Padding(
        padding: const EdgeInsets.only(bottom: 16.0, top: 16),
        child: Form(
          child: TextFormField(
            decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: 'Suche nach Themen, Kursen und Lektionen',
                suffixIcon: Icon(Icons.search),
                fillColor: DemoConstants.demoLightGrey,
                filled: true,
                contentPadding: const EdgeInsets.all(12.0),
                isDense: true),
          ),
        ),
      ),
      //automaticallyImplyLeading: false,
      leading: needsBackButton
          ? BackButton(
        color: Colors.black,
      )
          : null,
    );

    return appBar;
  }

  static Widget appBarWithLogo(BuildContext context,
      {bool needsBackButton = false}) {
    var width = MediaQuery.of(context).size.width ;
    var appBar = PreferredSize(
        preferredSize: Size(width, kToolbarHeight  + MediaQuery.of(context).padding.top),
        child: Container(
          width: width,
          height: kToolbarHeight +  MediaQuery.of(context).padding.top,
          child: Stack(
            children: [
              Container(
                width: width,
                height: kToolbarHeight + MediaQuery.of(context).padding.top,
              ),
              Positioned(
                right: -30,
                bottom: -kToolbarHeight * 2,
                child: Transform.rotate(
                  angle: -5 * pi / 180,
                  child: Container(
                    height: kToolbarHeight * 2,
                    width: width * 1.5,
                    color: DemoConstants.demoAccentBlueOpacityReduced,
                  ),
                ),
              ),
              Positioned(
                right: -20,
                bottom: -25,
                child: Transform.rotate(
                  angle: 7 * pi / 180,
                  child: Container(
                    height: kToolbarHeight * 0.7,
                    width: width * 1.5,
                    color: DemoConstants.demoAccentBlue,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 32.0, top: 16),
                  child: Image.asset(
                    DemoConstants.imageDemoLogoOrange,
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ));

    return appBar;
  }

  static Widget appBarTrianglesFromTop(BuildContext context,
      {bool needsBackButton = false, Color backgroundColor}) {
    var height = kToolbarHeight  + MediaQuery.of(context).padding.top / 2;
    print(height );
    var width = MediaQuery.of(context).size.width ;
    var appBar = PreferredSize(
        preferredSize: Size(width, height),
        child: Container(
          width: width,
          height: height,
          color:  backgroundColor ?? Colors.white,
          child: Stack(
            children: [
              Container(
                width: width,
                height: height,
              ),
              Positioned(
                left: -30,
                top: -kToolbarHeight * 0.4,
                child: Transform.rotate(
                  angle: -4 * pi / 180,
                  child: Container(
                    height: height,
                    width: width * 1.5,
                    color: DemoConstants.demoAccentBlueOpacityReduced,
                  ),
                ),
              ),
              Positioned(
                right: -30,
                top: -(kToolbarHeight * 0.4),
                child: Transform.rotate(
                  angle: 4 * pi / 180,
                  child: Container(
                    height: height ,
                    width: width * 1.5,
                    color: DemoConstants.demoAccentBlue,
                  ),
                ),
              ),
            ],
          ),
        ));

    return appBar;
  }

  static Future<void> setStatusBarColor(
      Color color, bool shouldTextBeWhite) async {
    await FlutterStatusbarcolor.setStatusBarColor(color);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(shouldTextBeWhite);
  }

  static Widget bookmarkIcon(BuildContext context, bool isBookmarked,
      Function() tappedBookmarkCallback,
      {bool isSettingBookmark = false, Color backgroundColor = Colors.white}) {
    return TextButton(
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: CircleBorder(),
      ),
      child: isSettingBookmark
          ? SizedBox(height: 18, width: 18, child: CircularProgressIndicator())
          : Icon(
        isBookmarked ? Icons.bookmark : Icons.bookmark_outline,
        color: Theme.of(context).accentColor,
      ),
      onPressed: () {
        tappedBookmarkCallback();
      },
    );
  }

  static Future<void> setBottomNavigationBarHeight(BuildContext context) async {
    if (_bottomNavBarHeight == null) {
      if (Theme.of(context).platform == TargetPlatform.iOS) {
        _bottomNavBarHeight = kBottomNavigationBarHeight;

        DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        print('Running on ${iosInfo.utsname.machine.iOSProductName}');

        String iPhoneModel = iosInfo.utsname.machine.iOSProductName;

        if (iPhoneModel.contains("iPhone X") ||
            iPhoneModel.contains("iPhone 11") ||
            iPhoneModel.contains("iPhone 12")) {
          _bottomNavBarHeight +=
          34; // additional padding in bottomNavigationBar
        }
      } else {
        _bottomNavBarHeight = kBottomNavigationBarHeight;
      }
    }
  }

  static double getBottomNavigationBarHeight() {
    if (_bottomNavBarHeight != null) {
      return _bottomNavBarHeight;
    } else {
      return kBottomNavigationBarHeight;
    }
  }

  static Widget alertError(BuildContext context, String message) {
    var alert = AlertDialog(
      title: Text(
        "Fehler",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
      ),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: 16,
        ),
      ),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () async {
            BlocProvider.of<ErrorCubit>(context).resetError();
            Navigator.of(context, rootNavigator: true).pop();
          },
        ),
      ],
    );

    return alert;
  }
}
