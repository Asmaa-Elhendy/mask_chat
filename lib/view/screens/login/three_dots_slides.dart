import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/const/colors.dart';
import 'package:Whatsback/const/sizes.dart';
import 'package:Whatsback/controller/masks_controller.dart';
import 'package:Whatsback/view/screens/home/home.dart';
import 'package:Whatsback/view/screens/login/start_chat.dart';
import 'package:Whatsback/view/screens/start_with_mask/list_of_people.dart';

import '../../../controller/assets.dart';
import '../../../model/category_mask.dart';
import '../../widgets/back_icon.dart';
import '../../widgets/float_Button.dart';
import '../home/contacts_list.dart';
import 'choose_mask_definition.dart';
import 'class_contacts.dart';
import 'mask_items.dart';
bool oneSelected = false;
class ThreeDotsScreens extends StatefulWidget {


   ThreeDotsScreens();

  @override
  State<ThreeDotsScreens> createState() => _ThreeDotsScreensState();
}

class _ThreeDotsScreensState extends State<ThreeDotsScreens> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      floatingActionButton: getFloatButton(() {
        if(_currentPage==1){
          Get.find<ClassController>().fetchContacts();
          Get.find<ClassController>().selectedMask =  Class(
            id: 0,
            name: 'contacts'.tr,
            contacts: [],
            contactsNum: 0,
            icon: Assets.getGeneralMask(),
            image: "",
            selected: false,
            mainColor: ColorsPlatte().primary.redIcons,
            secondColor: ColorsPlatte().primary.pinkShade,);
          Get.to(const ContactsList());
          Get.find<ClassController>().workWithChat =false;


        }else{
          _pageController.nextPage(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,);
        }


                },h),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: (10/baseWidth)*w,),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              children: [
               ClassYourContacts1(),
                ClassContacts(),
              ],
            ),
            Positioned(
              top: (27/baseHeight)*h,
              //left: (5/baseWidth)*w,
              //right: (260/baseWidth)*w,

              child: backIcon(w,(){Get.offAll(Home());},white: false)

            ),
            Positioned(
              bottom: (20/baseHeight)*h,
             //left: 0,
              //right: (260/baseWidth)*w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(2, (index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentPage != index ? Colors.black : ColorsPlatte().primary.redIcons,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
