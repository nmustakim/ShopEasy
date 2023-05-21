import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopeasy/screens/edit_profile/edit_profile.dart';
import 'package:shopeasy/screens/favorite/favorite_screen.dart';

import '../../firebase_helpers/firebaseAuth_helper.dart';
import '../../global_widgets/bottom_button.dart';
import '../../shop_provider/shop_provider.dart';
import '../change_password/change_password.dart';
import '../order_screen/order_screen.dart';


class AccountDetails extends StatefulWidget {
  const AccountDetails({super.key});

  @override
  State<AccountDetails> createState() => _AccountDetailsState();
}

class _AccountDetailsState extends State<AccountDetails> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    ShopProvider shopProvider = Provider.of<ShopProvider>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: const Text(
          "Account",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          shopProvider.getUserInformation.image == null
             ? const Icon(
           Icons.person_outline,
           size: 120,
              )
             : CircleAvatar(
           backgroundImage:
           NetworkImage(shopProvider.getUserInformation.image!),
           radius: 60,
              ),
              Text(
           shopProvider.getUserInformation.name,
           style: const TextStyle(
             fontSize: 18,
             fontWeight: FontWeight.bold,
           ),
              ),
              Text(
           shopProvider.getUserInformation.email,
              ),
              const SizedBox(
           height: 8.0,
              ),
              SizedBox(
           height: 20,
           child: BottomButton(
             onPressed: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>const EditProfile()));
             }, buttonName: 'Edit Profile',
           ),
              ),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const OrderScreen()));

                  },
                  leading: const Icon(Icons.shopping_bag_outlined),
                  title: const Text("Your Orders"),
                ),
                ListTile(
                  onTap: () {
Navigator.push(context, MaterialPageRoute(builder: (context)=>const FavoriteScreen()));
                  },
                  leading: const Icon(Icons.favorite_outline),
                  title: const Text("Favourite"),
                ),
                ListTile(
                  onTap: () {

                  },
                  leading: const Icon(Icons.info_outline),
                  title: const Text("About us"),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const ChangePassword()));
                  },
                  leading: const Icon(Icons.change_circle_outlined),
                  title: const Text("Change Password"),
                ),
                ListTile(
                  onTap: () {
                    FirebaseAuthHelper.firebaseAuthHelper.signOut();

                    setState(() {});
                  },
                  leading: const Icon(Icons.exit_to_app),
                  title: const Text("Log out"),
                ),
                const SizedBox(
                  height: 12.0,
                ),
                const Text("Version 1.0.0")
              ],
            ),
          ),
        ],
      ),
    );
  }
}
