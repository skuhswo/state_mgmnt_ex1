import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:state_mgmnt_ex1/cubit/error_cubit/error_cubit.dart';
import 'package:state_mgmnt_ex1/cubit/topics_cubit/topicspage_cubit.dart';
import 'package:state_mgmnt_ex1/demo_constants.dart';
import 'package:state_mgmnt_ex1/client.dart';
import 'package:state_mgmnt_ex1/pages/index/indexpage.dart';


void main() async {

  var errorCubit = ErrorCubit();

  runApp(MyApp(
    errorCubit: errorCubit,
  ));
}


class BottomBarVisibility with ChangeNotifier {
  bool _isHidden = false;
  bool get isHidden => _isHidden;

  double _height = kBottomNavigationBarHeight;
  double get height => _height;

  void setHidden() {
    _isHidden = true;
    _height = 0.0;
    notifyListeners();
  }

  void setVisible() {
    _isHidden = false;
    _height = kBottomNavigationBarHeight;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  final ErrorCubit errorCubit;

  const MyApp({Key key, @required this.errorCubit}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    var client = Client();

    return BlocProvider.value(
      value: errorCubit,
      child: MultiBlocProvider(
        providers: [
          BlocProvider<TopicspageCubit>(
            create: (context) => TopicspageCubit(client, errorCubit),
          ),
        ],
        child: ChangeNotifierProvider(
          create: (_) => BottomBarVisibility(),
          child: MaterialApp(
            builder: (BuildContext context, Widget child) {
              return MediaQuery(
                data: MediaQuery.of(context).copyWith(
                  textScaleFactor: 1.0,
                ), //set desired text scale factor here
                child: child,
              );
            },
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch:
              DemoConstants.createMaterialColor(DemoConstants.demoPrimaryGrey),
              accentColor: DemoConstants.demoAccentBlue,
              fontFamily: 'Roboto',
              scaffoldBackgroundColor: Colors.white,
              cardColor: DemoConstants.demoLightGrey,
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
             // AppLocalizations.delegate,
            ],
            supportedLocales: [
              const Locale('de', ''),
            ],
            home: IndexPage(),
          ),
        ),
      ),
    );
  }
}
