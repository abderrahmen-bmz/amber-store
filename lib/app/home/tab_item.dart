import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum TabItem {
  prodcuts,
  favourites,
  account,
}

class TabItemData {
  const TabItemData({@required this.title, @required this.icon});

  final String title;
  final IconData icon;

   static const Map<TabItem, TabItemData> allTabs = {
    TabItem.prodcuts: TabItemData(title: 'Prodcuts', icon: Icons.shopping_cart),
    TabItem.favourites: TabItemData(title: 'Favourites', icon: Icons.favorite),
    TabItem.account: TabItemData(title: 'Account', icon: Icons.person),
  };
}
