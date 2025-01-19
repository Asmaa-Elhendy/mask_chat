import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/const/colors.dart';
import 'package:Whatsback/view/screens/login/three_dots_slides.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../const/sizes.dart';
import '../../../controller/assets.dart';
import '../../../controller/masks_controller.dart';
import '../../../model/category_mask.dart';
import '../../widgets/float_Button.dart';
import '../start_with_mask/list_of_people.dart';

class ClassContacts extends StatelessWidget {
  const ClassContacts({super.key});


  @override
  Widget build(BuildContext context) {

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;

    return  Padding(
        padding:  EdgeInsets.only(top: (22/baseHeight) * h,left: (17/baseWidth)*w,right: (13/baseWidth)*w,bottom: (16/baseHeight)*h),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Padding(
                padding:  EdgeInsets.only(left: (10/baseWidth)*w),
                child: textColum(w,h,localizations),
              ),
              SizedBox(height: (15/baseHeight) *h,),
              SizedBox(
                height: h*.9,
                child:GetBuilder<ClassController>(
                    builder: (controller) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),

                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, // Number of columns
                        crossAxisSpacing: 8, // Space between columns
                       mainAxisSpacing: 10  , // Space between rows
                        childAspectRatio: 2/2.6
                       ),
                      itemCount: 4, // Number of items
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: (){
                            controller.setSelectedMask(controller.masks[index]);

                            Get.to(PeopleOnMask());
                          },
                          child: Container(
                              width: (205/baseWidth) *w, // Adjust the width
                            height: (206/baseHeight) *h,
                              decoration: BoxDecoration(
                              color: Colors.white, // Card background color
                              borderRadius: BorderRadius.circular(16), // Rounded corners
                          boxShadow: [
                          BoxShadow(
                          color: Colors.grey.withOpacity(0.5), // Shadow color
                          blurRadius: 8, // Shadow blur
                          offset: Offset(0, 4), // Shadow position
                          ),
                          ],
                          ),
                            child: Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      width: 161,
                                      height: 160,
                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius.only(
                                              topRight: Radius.circular(20),
                                              topLeft: Radius.circular(20),
                                              bottomRight: Radius.zero,
                                              bottomLeft: Radius.zero
                                            ),
                                        image: DecorationImage(
                                          image:controller.masks[index].image, // Use Image.asset
                                          fit: BoxFit.cover, // Makes the image cover the container
                                        ),
                                      ),

                                    ),
                                    Positioned(
                                      right: 10,
                                        top: 8,
                                        child: Container(
                                          padding: EdgeInsets.all(3),
                                          width: 52,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white
                                          ),
                                          child: Center(
                                            child: Text("${controller.masks[index].contacts.length}",
                                            style: TextStyle(
                                              color: controller.masks[index].mainColor,
                                              fontFamily: "Roboto-Bold",
                                              fontSize: (16/baseWidth)*w
                                            ),
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                                SizedBox(height: h*.015,),
                                Text(controller.masks[index].name,

                                style: TextStyle(
                                    color: ColorsPlatte().secondary.blackBoldText,
                                    fontFamily: "Roboto-Regular",
                                    fontWeight: FontWeight.w500,
                                    fontSize: (15/baseWidth) * w

                                ),
                                )


                              ],
                            ),


                          ),
                        );
                      },
                    );
                  }
                ),
              ),


            ],
          ),
        ),



    );
  }
  Widget textColum(w,h,localizations){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
       Text(localizations.classYourContacts2,
    style: TextStyle(
        color: ColorsPlatte().secondary.blackBoldText,
        fontFamily: "Roboto-Bold",
        fontWeight: FontWeight.w400,
        fontSize: (24/baseWidth) * w

    ),
    ),
        SizedBox(height: h*.01,),
        Text(localizations.addContacts,
          style: TextStyle(
              color: ColorsPlatte().secondary.lightText5,
              fontFamily: "Roboto-Regular",
              fontWeight: FontWeight.w400,
              fontSize: (15/baseWidth) * w

          ),
        ),


      ],
    );
  }
  // Widget gridVieWidgets(){
  //
  // }
}
