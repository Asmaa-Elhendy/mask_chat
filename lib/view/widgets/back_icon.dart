import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/const/colors.dart';

import '../../const/sizes.dart';

Widget backIcon(w,back, {bool white = true,}){
  return   InkWell(
    onTap: back,
    child: Icon(
      Icons.arrow_back_ios_new,
      color: white?Colors.white:ColorsPlatte().secondary.blackBoldText,
      size: (20 / baseWidth) * w,
    ),
  );
}