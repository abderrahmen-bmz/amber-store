import 'package:amber_store/app/home/cupertino_home_scaffold.dart';
import 'package:amber_store/app/home/tab_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TabItem _currentTap = TabItem.prodcuts;

  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.prodcuts: GlobalKey<NavigatorState>(),
    TabItem.favourites: GlobalKey<NavigatorState>(),
    TabItem.account: GlobalKey<NavigatorState>(),
  };

  void _select(TabItem tabItem) {
    if (tabItem == _currentTap) {
      // pop to first route
      navigatorKeys[tabItem].currentState.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTap = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      // to Control bacl button on Android
      onWillPop: () async => !await navigatorKeys[_currentTap]
          .currentState
          .maybePop(), // call when prese back button
      child: CupertinoHomeScaffold(
        navigatorKeys: navigatorKeys,
        currentTab: _currentTap,
        onSelectTab: _select,
      ),
    );
  }
}
