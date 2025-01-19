import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/colors.dart';
import '../../const/sizes.dart';
import '../screens/login/three_dots_slides.dart';

Widget getFloatButton(onTap,h){
  return  Padding(
    padding:  EdgeInsets.only(bottom: (8/baseHeight)*h),
    child: FloatingActionButton.small(
      onPressed: onTap,
      backgroundColor: ColorsPlatte().primary.redIcons, // Background color of the FAB
      child: Icon(Icons.arrow_forward_ios_outlined,color: Colors.white,), // Icon inside the FAB
      shape: CircleBorder(),


    ),
  );
}