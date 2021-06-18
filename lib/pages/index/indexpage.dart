import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:state_mgmnt_ex1/UIUtils.dart';
import 'package:state_mgmnt_ex1/demo_constants.dart';
import 'package:state_mgmnt_ex1/cubit/error_cubit/error_cubit.dart';
import 'package:state_mgmnt_ex1/cubit/topics_cubit/topicspage_cubit.dart';
import 'package:state_mgmnt_ex1/main.dart';
import 'package:state_mgmnt_ex1/pages/index/components/custom_persistent_tab_view.dart';
import 'package:state_mgmnt_ex1/pages/index/components/custom_tab_controller.dart';
import 'package:state_mgmnt_ex1/pages/topics_overview/topicspage.dart';
import 'package:provider/provider.dart';
import 'components/custom_persistent_tab_view.dart';
import 'components/custom_tab_controller.dart';

class IndexPage extends StatefulWidget {
  static const routeName = '/indexPage';

  @override
  IndexPageState createState() => IndexPageState();
}

class IndexPageState extends State<IndexPage> {
  MyPersistentTabController _controller;
  int _index;
  TabIndexChangeNotifier _tabIndexChangeNotifier;
  BuildContext _tabContext;
  String _indexPageName = "/9f580fc5-c252-45d0-af25-9429992db112";

  final _tabViewKey = GlobalKey<MyPersistentTabViewState>();

  @override
  void initState() {
    super.initState();
    _index = 0;
    _tabIndexChangeNotifier = TabIndexChangeNotifier(_index);
    _controller = MyPersistentTabController(
        initialIndex: _index, popToTabIndexPage: popToTabIndexPage);
    BlocProvider.of<TopicspageCubit>(context).getTopics();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return //ErrorObserver(
    //  child:
    ChangeNotifierProvider.value(
        value: _tabIndexChangeNotifier,
          child: MyPersistentTabView(
            context,
            key: _tabViewKey,
            hideNavigationBar:
            Provider.of<BottomBarVisibility>(context).isHidden,
            navBarHeight: Provider.of<BottomBarVisibility>(context).height,
            screens: _buildScreens(),
            controller: _controller,
            confineInSafeArea: true,
            items: _navBarItems(),
            backgroundColor: Colors.white,
            handleAndroidBackButtonPress: true,
            resizeToAvoidBottomInset:
            true, // This needs to be true if you want to move up the screen when keyboard appears.
            stateManagement: true,
            hideNavigationBarWhenKeyboardShows: true,
            itemAnimationProperties: ItemAnimationProperties(
              // Navigation Bar's items animation properties.
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
            ),
            screenTransitionAnimation: ScreenTransitionAnimation(
              // Screen transition animation on change of selected tab.
              animateTabTransition: true,
              curve: Curves.ease,
              duration: Duration(milliseconds: 200),
            ),
            navBarStyle: NavBarStyle.style2,
            decoration: NavBarDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 4,
                offset: Offset(0, 3),
              )
            ]),
            onItemSelected: itemSelcted,
            selectedTabScreenContext: (context) {
              _tabContext = context;
            },
          ),
       // ),
     // ),
    );
  }

  Future<void> setStatusBarColor(
      BuildContext context, Color color, bool textColorWhite) async {
    await FlutterStatusbarcolor.setStatusBarColor(color);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(textColorWhite);
  }

  List<Widget> _buildScreens() {
    return [
      TopicsPage(),
      Container(),
      Container(),
      Container()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: Icon(Icons.home),
          activeColor: DemoConstants.demoAccentBlue,
          inactiveColor: DemoConstants.demoUnselectedTab),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.list),
          activeColor: DemoConstants.demoAccentBlue,
          inactiveColor: DemoConstants.demoUnselectedTab),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.person),
          activeColor: DemoConstants.demoAccentBlue,
          inactiveColor: DemoConstants.demoUnselectedTab),
      PersistentBottomNavBarItem(
          icon: Icon(Icons.bookmark_rounded),
          activeColor: DemoConstants.demoAccentBlue,
          inactiveColor: DemoConstants.demoUnselectedTab),
    ];
  }

  void itemSelcted(int index) {
    BlocProvider.of<ErrorCubit>(context).resetError();

    if (_tabContext == null) {
      _tabContext = _tabViewKey.currentState.getContextForIndex(i: _index);
    }

    if (_tabContext != null) {
      Provider.of<TabIndexChangeNotifier>(_tabContext, listen: false)
          .changeIndex(index);
    }


    if (index == 0) {

      UiUtils.setStatusBarColor(Colors.transparent, true);

      if (_tabContext != null) {
        Navigator.of(_tabContext)
            .popUntil((route) => route.settings.name == _indexPageName);
      }


    } else if (index == 1) {

      if (_tabContext != null) {
        Navigator.of(_tabContext)
            .popUntil((route) => route.settings.name == _indexPageName);
      }

      BlocProvider.of<TopicspageCubit>(context).getTopics();

      UiUtils.setStatusBarColor(Colors.transparent, true);


    } else if (index == 2) {

      if (_tabContext != null) {
        Navigator.of(_tabContext)
            .popUntil((route) => route.settings.name == _indexPageName);
      }

      UiUtils.setStatusBarColor(Colors.transparent, true);


    } else {

      if (_tabContext != null) {
        Navigator.of(_tabContext)
            .popUntil((route) => route.settings.name == _indexPageName);
      }

      UiUtils.setStatusBarColor(Colors.transparent, true);

    }
    _index = index;
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  void popToTabIndexPage() {
    if (_tabContext == null) {
      _tabContext = _tabViewKey.currentState.getContextForIndex(i: _index);
    }

    if (_tabContext != null) {
      Navigator.of(_tabContext)
          .popUntil((route) => route.settings.name == _indexPageName);
    }
  }
}

class TabIndexChangeNotifier extends ChangeNotifier {
  int index;

  TabIndexChangeNotifier(this.index);

  void changeIndex(int index) {
    this.index = index;

    notifyListeners();
  }
}
