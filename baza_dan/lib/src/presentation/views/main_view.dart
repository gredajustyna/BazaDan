import 'package:baza_dan/src/config/themes/colors.dart';
import 'package:baza_dan/src/domain/entities/food.dart';
import 'package:baza_dan/src/domain/entities/user.dart';
import 'package:baza_dan/src/presentation/views/drawer_tabs/edit_user_tab.dart';
import 'package:baza_dan/src/presentation/views/drawer_tabs/reservation_drawer_tab.dart';
import 'package:baza_dan/src/presentation/views/shopping_cart_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawer_tabs/orders_tab.dart';
import 'login_view.dart';
import 'main_screen_tabs/main_view_tab.dart';
import 'main_screen_tabs/menu_tab.dart';
import 'main_screen_tabs/reservation_tab.dart';

class MainView extends StatefulWidget {
  final User user;
  const MainView({Key? key, required this.user}) : super(key: key);

  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  List<Food> cart =[];
  List<int> cartAmounts=[];
  int _currentIndex = 0;
  late List _children;
  late User user;

  @override
  void initState() {
    user = widget.user;
    _children = [
      MainViewTab(user: user,),
      MenuTab(cart: cart, cartAmounts: cartAmounts,),
      ReservationTab(user: user,)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: buildDrawer(),
      appBar: buildAppbar(),
      body: _children[_currentIndex], // new
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        selectedItemColor: mainOrange,
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Strona główna',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              label:'Rezerwacja',
          )
        ],
      ),
    );
  }

  PreferredSizeWidget buildAppbar(){
    return AppBar(
      actions: [
        IconButton(
          onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ShoppingCartView(user: user,)));
          },
          icon: const Icon(Icons.shopping_basket,
            color: mainWhite,
            size: 24,
          )
        ),
      ],
      elevation: 0,
      centerTitle: true,
      backgroundColor: mainOrange,
      title: const Text(
        'Baza dań',
        style: TextStyle(
          color: mainWhite,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget buildDrawer(){
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: mainOrange,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Icon(Icons.account_circle,
                    size: 80,
                    color: mainWhite,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(user.name,
                          style: TextStyle(
                            color: mainWhite,
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text('Moje rezerwacje',
            ),
            leading: Icon(Icons.calendar_today),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => ReservationDrawerTab(user: user,)));
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Historia zamówień'),
            leading: const Icon(Icons.restaurant),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => OrdersTab(user: user,)));
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Edytuj dane'),
            leading: const Icon(Icons.account_circle),
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context) => EditUserTab(user: user,)));
              // Update the state of the app.
              // ...
            },
          ),
          ListTile(
            title: const Text('Wyloguj',
              style: TextStyle(
                color: mainOrange
              ),
            ),
            leading: const Icon(Icons.logout,
              color: mainOrange,
            ),
            onTap: () {
              Navigator.pushReplacementNamed( context, '/login');
            },
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Widget buildLogoutButton(){
    return RawMaterialButton(
      onPressed: (){
        //TODO:ZMIENIĆ NA SPRAWDZANIE LOGOWANIA I BLOC, NA RAZIE PRÓBA UI
        Navigator.pushReplacementNamed( context, '/login');
      },
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)),
      child: const Text('Wyloguj'),
      textStyle: const TextStyle(
        color: mainOrange,
        fontFamily: 'Montserrat',
        fontSize: 17,
      ),
      elevation: 0,
      fillColor: mainWhite,
    );
  }

}
