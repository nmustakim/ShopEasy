import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../global_widgets/bottom_button.dart';
import '../../models/user.dart';
import '../../shop_provider/shop_provider.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? image;
  void addImage() async {
    XFile? value = await ImagePicker()
        .pickImage(source: ImageSource.gallery, );
    if (value != null) {
      setState(() {
        image = File(value.path);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    ShopProvider shopProvider = Provider.of<ShopProvider>(
      context,
    );

    TextEditingController nameController = TextEditingController(text: shopProvider.getUserInformation.name);
    TextEditingController phoneController = TextEditingController(text: shopProvider.getUserInformation.phone);
    TextEditingController ageController = TextEditingController(text: shopProvider.getUserInformation.age);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        foregroundColor:Colors.red,
        backgroundColor: Colors.white,
        title: const Text(
          "Profile",

        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        children: [
          image == null
              ? CupertinoButton(
            onPressed: () {
              addImage();
            },
            child: const CircleAvatar(
                radius: 55, child: Icon(Icons.camera_alt)),
          )
              : CupertinoButton(
            onPressed: () {
              addImage();
            },
            child: CircleAvatar(
              backgroundImage: FileImage(image!),
              radius: 55,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text('Name',style: TextStyle(color: Colors.red),),
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              hintText: shopProvider.getUserInformation.name,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text('Phone',style: TextStyle(color: Colors.red),),
          TextFormField(
            controller: phoneController,
            decoration: InputDecoration(
              hintText: shopProvider.getUserInformation.phone,
            ),
          ),
          const SizedBox(
            height: 12.0,
          ),
          const Text('Age',style: TextStyle(color: Colors.red),),
          TextFormField(
            controller: ageController,
            decoration: InputDecoration(
              hintText: shopProvider.getUserInformation.age,
            ),
          ),
          const SizedBox(
            height: 24.0,
          ),
          BottomButton(
           buttonName: "Update",
            onPressed: () {
              UserModel userModel = shopProvider.getUserInformation
                  .copyWith(name: nameController.text,phone:phoneController.text,age:ageController.text,);
              shopProvider.updateUserInfoFirebase(context, userModel, image);

            },
          ),
        ],
      ),
    );
  }
}