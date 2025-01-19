import 'package:flutter/material.dart';
import 'package:Whatsback/view/widgets/language_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';

import '../../../const/colors.dart';
import '../../../const/sizes.dart';

class PickLanguage extends StatefulWidget {
  var localizations;
   PickLanguage({required this.localizations,super.key});

  @override
  State<PickLanguage> createState() => _PickLanguageState();
}

class _PickLanguageState extends State<PickLanguage> {

  @override
  void initState() {
    super.initState();
    // Automatically open the bottom sheet after 1 second
    Future.delayed(const Duration(seconds: 1), () {
      bottomSheet(widget.localizations);
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: (){
          bottomSheet(widget.localizations);
        },
        child: Container(
          width: w,
          height: h,

          decoration: const BoxDecoration(
          image: DecorationImage(
          image: AssetImage('assets/images/background.png'), // Background image
            fit: BoxFit.cover, // Cover the whole container
            ),
            ),
          child:
          Padding(
            padding:  EdgeInsets.only(top:(49 / 422) * h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: (124 / 360) * w,

                  child: Image.asset('assets/images/faces.png'),

                ),
                SizedBox(height: (8 / 422) * h,),
                SizedBox(
                    width: (191 / 360) * w,
                   // height: (34 / 422) * h,
                    child: Image.asset('assets/images/whats back.png')),
                SizedBox(height: (10 / 422) * h,),
                SizedBox(
                    width: (132 / 360) * w,
                    // height: (34 / 422) * h,
                    child: Image.asset('assets/images/welcome.png'))


              ],
            ),
          ),
        ),
      ),

    );
  }
   bottomSheet(localizations){

     showModalBottomSheet(
         context: context,
         builder: (builder) {
           return  LanguageBottomSheet(localizations: localizations,);
         }
    );

  }
}
