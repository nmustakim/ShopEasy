import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:shopeasy/screens/favorite/favorite_screen.dart';
import 'package:shopeasy/screens/account_details/account_details.dart';
import '../screens/cart/cart.dart';
import '../screens/home/home.dart';
import '../screens/order_screen/order_screen.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({
    final Key? key,
  }) : super(key: key);

  @override
  BottomBarState createState() => BottomBarState();
}

class BottomBarState extends State<BottomBar> {
  final PersistentTabController _controller = PersistentTabController();
  final bool _hideNavBar = false;

  List<Widget> _buildScreens() => [
        const Home(),
        const Cart(),
        const OrderScreen(),
        const AccountDetails(),
      ];

  List<PersistentBottomNavBarItem> _navBarsItems() => [
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.home),
          inactiveIcon: const Icon(Icons.home_outlined),
          title: "Home",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.shopping_cart),
          inactiveIcon: const Icon(Icons.shopping_cart_outlined),
          title: "Cart",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon:  Image.asset("assets/images/shopping_bag.png"),
          inactiveIcon:Image.asset("assets/images/shopping_bag.png"),
          title: "Orders",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
        PersistentBottomNavBarItem(
          icon: const Icon(Icons.person),
          inactiveIcon: const Icon(Icons.person_outline),
          title: "Profile",
          activeColorPrimary: Colors.black,
          inactiveColorPrimary: Colors.black,
        ),
      ];

  @override
  Widget build(final BuildContext context) => Scaffold(
        body: PersistentTabView(
          context,
          controller: _controller,
          screens: _buildScreens(),
          items: _navBarsItems(),
          resizeToAvoidBottomInset: true,
          navBarHeight: MediaQuery.of(context).viewInsets.bottom > 0
              ? 0.0
              : kBottomNavigationBarHeight,
          bottomScreenMargin: 0,

          backgroundColor: Theme.of(context).primaryColor,
          hideNavigationBar: _hideNavBar,
          decoration: const NavBarDecoration(colorBehindNavBar: Colors.indigo),
          itemAnimationProperties: const ItemAnimationProperties(
            duration: Duration(milliseconds: 400),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: const ScreenTransitionAnimation(
            animateTabTransition: true,
          ),
          navBarStyle:
              NavBarStyle.style1, // Choose the nav bar style with this property
        ),
      );
}
