import 'dart:ui';

import 'package:flutter/material.dart';

const blackBoldText = Color(0xff010101);
const dropIcons = Color(0xff1e1e1e);
const  lightText = Color(0xffa0a0a0);
const  lightText2 = Color(0xff6d7278);
const lightText3 = Color(0xff2d2d2d);
const lightText4 = Color(0xff91959a);
const divider =  Color(0xffececec);
const underLine = Color(0xffcccccc);
const underLine2 = Color(0xffe3e3e3);
const redCheck = Color(0xffe02f42);
const redText = Color(0xffbc2535);
const alphabetRed = Color(0xffd92a3d);
const delete = Color(0xffe34949);
  const redIcons = Color(0xffe02f42);
const unselectedRed = Color(0xffec8590);
const blueText = Color(0xff148ce8);
const profileContainer = Color(0xffffefef);
const contactName = Color(0xff1a1a1a);
const star = Color(0xffffc107);
const pinkShade = Color(0xffffefef);
const border  = Color(0xffc3c3c3);
const shadow = Color(0xffe7efff);
const darkBlueText = Color(0xff192339);
const time = Color(0xff515151);
const emoji =Color(0xff969696);


class ColorsPlatte{
  static final ColorsPlatte _instance = ColorsPlatte._internal();
  factory ColorsPlatte() => _instance;
  ColorsPlatte._internal();

  final _Primary primary = _Primary();
  final _Secondry secondary = _Secondry();
}
class _Primary{
  final Color redCheck = Color(0xffe02f42);
  final Color redText = Color(0xffbc2535);
  final Color  alphabetRed = Color(0xffd92a3d);
  final  Color delete = Color(0xffe34949);
  final  Color redIcons = Color(0xffe02f42);
  final  Color remove = Color(0xffE04F5F);
  final Color chat = Color(0xffFFE3E6);
  final req = Color(0xffE53B4D);

  final unselectedRed = const Color(0xffec8590);
  final pinkShade = const Color(0xffFFDBDF);
}
class _Secondry{
  final blackBoldText = Color(0xff010101);
  final dropIcons = Color(0xff1e1e1e);
  final  lightText = Color(0xffa0a0a0);
  final  lightText2 = Color(0xff6d7278);
  final lightText3 = Color(0xff2d2d2d);
  final lightText4 = Color(0xff91959a);
  final lightText5 = Color(0xff979797);
  final lightText6 = Color(0xff747474);
  final lightText7 = Color(0xffF2F3F4);
  final lightText8 = Color(0xff8c98b4);

  final divider =  Color(0xffececec);
  final underLine = Color(0xffcccccc);
  final underLine2 = Color(0xffe3e3e3);
  final time = Color(0xff515151);
  final emoji =Color(0xff969696);
  final pinkShade = Color(0xffffefef);
  final border  = Color(0xffc3c3c3);
  final shadow = Color(0xffe7efff);
  final profileContainer = Color(0xffffefef);
  final contactName = Color(0xff1a1a1a);
  final textFieldColor = Color(0xffC9C9C9);
  final eye = Color(0xffADB0B4);
  final blueShadeBold = Color(0xff3E73D2);
  final blueShadeLight = Color(0xffCBDEFF);
  final greenShadeBold = Color(0xff2FA961);
  final greenShadeLight = Color(0xffC7FFDE);
  final orangeShadeBold = Color(0xffE87930);
  final yellowShade = Color(0xffE9B117);
  final orangeShadeLight = Color(0xffFFDAC2);
  final babyBlueShadeBold = Color(0xff3FAEDB);
  final babyBlueShadeLight = Color(0xffD1F2FF);
final invite = Color(0xff007AFF);

}

