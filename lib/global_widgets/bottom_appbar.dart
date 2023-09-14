import 'package:flutter/material.dart';
import 'package:shopeasy/screens/account_details/account_details.dart';
import 'package:shopeasy/screens/cart/cart.dart';
import 'package:shopeasy/screens/home/home.dart';
import 'package:shopeasy/screens/order_screen/order_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    Key? key,
  }) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;

  List<Widget> _screens = [
    const Home(),
    const AccountDetails(),
    const Cart(),
    const OrderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
              size: 35,
            ),
            activeIcon: Icon(
              Icons.home_filled,
              size: 35,
            ),
            label: "Home",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline_sharp,
              size: 35,
            ),
            activeIcon: Icon(
              Icons.person_sharp,
              size: 35,
            ),
            label: "Profile",
          ),
          const BottomNavigationBarItem(
            icon: Icon(
              Icons.shopping_cart_outlined,
              size: 35,
            ),
            activeIcon: Icon(
              Icons.shopping_cart,
              size: 35,
            ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            icon: Image.asset("assets/images/shopping_bag.png"),
            activeIcon: Image.asset("assets/images/shopping_bag.png"),
            label: "Orders",
          ),
        ],
      ),
    );
  }
}
