import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/const/colors.dart';
import 'package:Whatsback/const/sizes.dart';

dialog(title,onConfirm,w,h,localizations){
  Get.defaultDialog(
    title:title,
    middleText: "",
    titlePadding: EdgeInsets.only(top: h*.04),
    // textConfirm: "Yes",
    // textCancel: "Ignore",
    titleStyle: TextStyle(
      color: ColorsPlatte().secondary.blackBoldText,
      fontSize: (16/baseWidth)*w,
      fontFamily: "Roboto-Medium"
    ),
    actions: [
      SizedBox(
        width: w*.27,
        child: OutlinedButton(
          onPressed: () {
            Get.back();

          },
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: ColorsPlatte().primary.redIcons), // Red border
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(
            localizations.ignore,
            style: TextStyle(
              fontFamily: "Roboto-Regular",
              fontSize: (16/baseWidth)*w,
              color: ColorsPlatte().primary.redIcons,

            ), // Red text
          ),

        ),
      ),
      SizedBox(width: (12/baseWidth)*w), // Space between buttons

      SizedBox(
        width: w*.27,
        child: ElevatedButton(
          onPressed: () {
            Get.back();
           onConfirm;
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsPlatte().primary.redIcons,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(localizations.yes,
          style: TextStyle(
            color: Colors.white,
            fontFamily: "Roboto-Regular",
            fontSize: (16/baseWidth)*w
          ),
          ),
        ),
      ),

    ],

  );
}