import 'package:flutter/material.dart';

import '../../constants.dart';

class TermsAndPrivacy extends StatelessWidget {
  const TermsAndPrivacy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        centerTitle: true,backgroundColor: Colors.white,foregroundColor: Colors.black,

      title:   Text("Terms & Privacy Policies",style:   titleTextStyle1,),),

      body: SingleChildScrollView(
        child: Column(
          children: const [


            Text("An Intellectual Property clause will inform users that the contents, logo and other visual media you created is your property and is protected by copyright laws. \n\n Termination clause will inform users that any accounts on your website and mobile app, or users' access to your website and app, can be terminated in case of abuses or at your sole discretion.\n\nA Governing Law clause will inform users which laws govern the agreement. These laws should come from the country in which your company is headquartered or the country from which you operate your website and mobile app.\n\n A Links to Other Websites clause will inform users that you are not responsible for any third party websites that you link to.\n This kind of clause will generally inform users that they are responsible for reading and agreeing (or disagreeing) with the Terms and Conditions or Privacy Policies of these third parties.\n\nIf your website or mobile app allows users to create content and make that content public to other users, a Content clause will inform users that they own the rights to the content they have created.\n\n This clause usually mentions that users must give you (the website or mobile app developer/owner) a license so that you can share this content on your website/mobile app and to make it available to other users.\n\nBecause the content created by users is public to other users, a DMCA notice clause (or Copyright Infringement ) section is helpful to inform users and copyright authors that, if any content is found to be a copyright infringement, you will respond to any DMCA takedown notices received and you will take down the content.\n\nA Limit What Users Can Do clause can inform users that by agreeing to use your service, they're also agreeing to not do certain things.\nThis can be part of a very long and thorough list in your Terms and Conditions agreement so as to encompass the most amount of negative uses.",style: TextStyle(fontSize: 20),)
         
          ],
        ),
      ),
    );
  }
}
