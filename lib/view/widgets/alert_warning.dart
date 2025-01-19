import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/colors.dart';
import '../../const/sizes.dart';


dialogWarning(title,w,h,localizations){

  Get.defaultDialog(
    title:title,
    middleText: "",
    titlePadding: EdgeInsets.only(top: h*.06),
    // textConfirm: "Yes",
    // textCancel: "Ignore",
    titleStyle: TextStyle(
        color: ColorsPlatte().secondary.blackBoldText,
        fontSize: (18/baseWidth)*w,
        fontFamily: "Roboto-Medium"
    ),
    actions: [

      SizedBox(
        width: w*.27,
        child: ElevatedButton(
          onPressed: () {
             Get.back();

          },
          style: ElevatedButton.styleFrom(
            backgroundColor: ColorsPlatte().primary.redIcons,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
          child: Text(localizations.ok,
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