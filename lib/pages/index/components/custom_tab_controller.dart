import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:state_mgmnt_ex1/pages/index/indexpage.dart';
import 'package:provider/provider.dart';

class MyPersistentTabController extends PersistentTabController {
  void Function() popToTabIndexPage;

  MyPersistentTabController({int initialIndex = 0, this.popToTabIndexPage})
      : assert(initialIndex != null),
        assert(initialIndex >= 0),
        super(initialIndex: initialIndex);

  jumpToTabWithContext(BuildContext context, int value) {
    assert(value != null);
    assert(value >= 0);
    if (super.index == value) {
      return;
    }
    super.jumpToTab(value);

    Provider.of<TabIndexChangeNotifier>(context, listen: false)
        .changeIndex(index);

    popToTabIndexPage();
  }

  @override
  void dispose() {
    super.dispose();
  }
}