
import 'package:amber_store/app/home/cart/cart_page.dart';
import 'package:amber_store/app/home/products/all_products_page.dart';
import 'package:amber_store/app/home/products/products_page.dart';
import 'package:amber_store/app/home/tab_item.dart';
import 'package:amber_store/app/sign_in/sign_in_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CupertinoHomeScaffold extends StatelessWidget {
  const CupertinoHomeScaffold({
    Key key,
    @required this.currentTab,
    @required this.onSelectTab,
    @required this.navigatorKeys,
  }) : super(key: key);

  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  final Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys;

  Map<TabItem, WidgetBuilder> get widgetBuilders {
    return {
      TabItem.prodcuts: (_) => SignInPage(),
      TabItem.favourites: (_) => AllProdcuts(),
      TabItem.account: (_) => CartPage(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        items: [
          _buildBottomNavigationBarItem(TabItem.prodcuts),
          _buildBottomNavigationBarItem(TabItem.favourites),
          _buildBottomNavigationBarItem(TabItem.account),
        ],
        onTap: (index) => onSelectTab(
          TabItem.values[index],
        ),
      ),
      tabBuilder: (context, index) {
        final item = TabItem.values[index];
        return CupertinoTabView(
            navigatorKey: navigatorKeys[item],
            //    builder: (context) => Container(),
            builder: (context) => widgetBuilders[item](context));
      },
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem(TabItem tabItem) {
    final itemData = TabItemData.allTabs[tabItem];
    final color = currentTab == tabItem ? Colors.indigo : Colors.grey;
    return BottomNavigationBarItem(
      icon: Icon(
        itemData.icon,
        color: color,
      ),
      title: Text(
        itemData.title,
        style: TextStyle(color: color),
      ),
    );
  }
}
