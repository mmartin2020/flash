
import 'package:flutter/material.dart';
import 'package:log/Data/textdata.dart';

import 'explore.dart';
import 'offer.dart';
import 'profil.dart';
import 'shop.dart';
import 'shopping_cart.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeViewState();
}

class _HomeViewState extends State<Home> {
  int _currentIndex = 0;
  _indexCallBack(int i) {
    setState(() {
      _currentIndex = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          Explore(),
          Shop(),
          ShoppingCart(),
          Offer(),
          Profil(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Theme.of(context).primaryColor,
        selectedIconTheme: IconThemeData(size: 20.0),
        currentIndex: _currentIndex,
        onTap: _indexCallBack,
        type: BottomNavigationBarType.fixed,
        unselectedIconTheme:
            IconThemeData(color: Colors.blueGrey.withOpacity(0.5)),
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: TextData.TEXT_LABEL_INICIO,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: TextData.TEXT_LABEL_SHOP,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
            ),
            label: TextData.TEXT_LABEL_CARRITO,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_offer_outlined),
            label: TextData.TEXT_LABEL_OFFER,
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: TextData.TEXT_LABEL_PROFIL)
        ],
      ),
    );
  }
}
