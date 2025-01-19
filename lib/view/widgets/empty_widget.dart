import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:Whatsback/const/colors.dart';
import 'package:Whatsback/const/sizes.dart';

import '../../controller/masks_controller.dart';




class EmptyWidget extends StatelessWidget {
  var localizations;
   EmptyWidget({required this.localizations,super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GetBuilder<ClassController>(
        builder: (controller) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Image.asset("assets/images/categories/party-mask.png",
            // color: controller.selectedMask.mainColor,scale: .7,),
            // SizedBox(height:(5/baseHeight)*h),
            Text(localizations.empty,
              style: TextStyle(
                  color: ColorsPlatte().secondary.blackBoldText,
                  fontFamily: "Roboto-Medium",
                  fontWeight: FontWeight.w400,
                  fontSize: (18/baseWidth)*w
              ),
            ),
            SizedBox(height:(2/baseHeight)*h),

            Column(
              children: [
                Text(localizations.start_now_add_contacts,
                  style: TextStyle(
                      color: ColorsPlatte().secondary.lightText5,
                      fontFamily: "Roboto-Regular",
                      fontWeight: FontWeight.w400,
                      fontSize: (15/baseWidth)*w
                  ),
                ),
                SizedBox(height:(2/baseHeight)*h),

                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: w*.15),
                  child: Text("${controller.selectedMask.name} ${localizations.group}",
                    style: TextStyle(
                        color: ColorsPlatte().secondary.lightText5,
                        fontFamily: "Roboto-Regular",
                        fontWeight: FontWeight.w400,
                        fontSize: (15/baseWidth)*w
                    ),
                  ),
                ),
              ],
            ),



          ],
        );
      }
    );
  }
}


Widget emptyList(icon,w,h,localizations){
  return Center(
    child: Column(
      children: [
        icon,
        SizedBox(height:(20/baseHeight)*h),
        Text(localizations.empty,
        style: TextStyle(
          color: ColorsPlatte().secondary.blackBoldText,
          fontFamily: "Roboto-Medium",
          fontWeight: FontWeight.w400,
          fontSize: (18/baseWidth)*w
        ),
        ),



      ],
    ),
  );
}