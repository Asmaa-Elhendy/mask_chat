import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/const/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../const/sizes.dart';
import '../../controller/masks_controller.dart';
import '../screens/home/contacts_list.dart';
import '../screens/home/home.dart';


Widget skipButton(w,h,localizations){
  return Padding(
  padding:  EdgeInsets.only(top: (20/baseHeight)*h,right:(20/baseWidth)*w, ),

    child: Column(
      children: [
        InkWell(
          onTap: (){
            Get.find<ClassController>().fetchContacts();
            Get.to(const ContactsList());
          },
          child: Text(localizations.skip,
          style: TextStyle(
            color: ColorsPlatte().secondary.lightText3,
            fontSize: 18,
            fontFamily: "Roboto-Regular",
            fontWeight: FontWeight.w400

          ),
          ),
        ),
      ],
    ),
  );
  
}