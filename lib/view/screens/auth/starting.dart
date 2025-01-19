import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/const/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:Whatsback/view/screens/home/chat_list.dart';
import 'package:Whatsback/view/screens/home/home.dart';
import 'package:Whatsback/view/widgets/general_button.dart';
import 'package:flutter/cupertino.dart';

import '../../../const/colors.dart';
class Starting extends StatelessWidget {
  const Starting({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;

    return Scaffold(
      body: Center(
        child: Column(

          children: [

            SizedBox(
                width: (247 / baseWidth) * w,
                height: (227 / baseHeight) * h,
                child: Image.asset("assets/images/starting.png")),
         //   SizedBox(height: h* .036,),
             Padding(
               padding:  EdgeInsets.symmetric(horizontal: w * .0),
               child: Column(
                 children: [
                   Text(localizations.timeToPost,
                      style: TextStyle(
                        fontFamily: 'Roboto-Bold',
                        color: blackBoldText,
                        fontSize: (21 / baseWidth) *w,
                        fontWeight: FontWeight.w700,
                        fontStyle: FontStyle.normal,
                        letterSpacing: 0,

                      )
                               ),
                   Padding(
                     padding:  EdgeInsets.symmetric(horizontal: w * .128),
                     child: Text(localizations.loremIpsumText,
                         style: TextStyle(
                           fontFamily: 'Roboto-Light',
                           color: lightText3,
                           fontSize: (14 / baseWidth) * w,
                           fontWeight: FontWeight.w300,
                           fontStyle: FontStyle.normal,


                         )
                     ),
                   ),
                   SizedBox(height: .066*h,),
                   GeneralButton(localizations.getStart, (){
                     Get.offAll( Home());
                   }, w, h)
                 ],
               ),
             ),


          ],
        ),
      ),
    );
  }
}
