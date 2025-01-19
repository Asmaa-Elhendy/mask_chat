import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:Whatsback/const/colors.dart';
import 'package:Whatsback/const/sizes.dart';
import 'package:Whatsback/view/widgets/skip_Button.dart';

class ClassYourContacts1 extends StatelessWidget {
  const ClassYourContacts1({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        skipButton(w,h,localizations),

        Center(
          child: Column(
           // mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
              //  width: (194/baseWidth)*w,
                height: (160/baseHeight)*h,
                child: Image.asset("assets/images/choose_mask.png"),
              ),
              //SizedBox( height: (20/baseHeight)*h,),
              Text(localizations.classYourContacts,
              style: TextStyle(
                color: ColorsPlatte().secondary.blackBoldText,
                fontFamily: "Roboto-Bold",
                  fontWeight: FontWeight.w500,
                fontSize: (21/baseWidth)*w

              ),
              ),
              SizedBox(height: (7/baseHeight)*h,),
              Text(localizations.dummyText,
                style: TextStyle(
                  color: ColorsPlatte().secondary.lightText3,
                  fontFamily: "Roboto-Light",
                  fontWeight: FontWeight.w400,

                ),
              ),



            ],
          ),
        )


      ],
    );
  }
}
