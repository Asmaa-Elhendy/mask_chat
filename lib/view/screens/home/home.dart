import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:Whatsback/controller/api/chats/chats_controller.dart';
import 'package:Whatsback/view/screens/home/Requests.dart';
import 'package:Whatsback/view/screens/login/three_dots_slides.dart';

import '../../../const/colors.dart';
import '../../../const/sizes.dart';
import '../../../controller/api/groups/groups_controller.dart';
import 'chat_list.dart';
import 'groups/group_list.dart';

class Home extends StatefulWidget {
  int page;
   Home({this.page=0,super.key,});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  List _pages = [
    chatList(),
    GroupList(),
    ThreeDotsScreens(),
    Requests(),

  ];
  @override
  void initState() {
    Get.find<ChatsController>().sorting();

    if(widget.page==0){

    }else{
      _currentIndex=widget.page;

    }
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;

    return Container(
      width: w,
      height: h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffd42336),
            Color(0xffed4658),
          ],
          stops: [0, 1],
          end: Alignment(1.00, -0.00),
          begin: Alignment(-1.00, 0.00),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,

         body:  _pages[_currentIndex],


        bottomNavigationBar:_currentIndex!=2? BottomNavigationBar(

          backgroundColor: Colors.transparent, // Transparent to blend with gradient
          selectedItemColor: Colors.white,
          unselectedItemColor:unselectedRed,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          selectedLabelStyle: TextStyle(
            fontFamily: 'Roboto-Medium',
            color: Colors.white,
            fontSize: (14 / baseWidth) * w,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          unselectedLabelStyle: TextStyle(
            fontFamily: 'Roboto-Medium',
            color: unselectedRed,
            fontSize: (14 / baseWidth) * w,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.normal,
          ),
          items:  [
            BottomNavigationBarItem(

              icon: Padding(
                padding: const EdgeInsets.only(bottom:5.0),
                child: SizedBox(
                    width: (22/baseWidth)*w,

                    height: (22/baseHeight)*h,
                    child: Center(
                      child: Icon(Icons.chat,
                        color: _currentIndex==0?Colors.white:unselectedRed,
                      size: (25/baseWidth)*w,
                      ),
                    )),
              ),
              label: localizations.chats,


            ),
             BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: SizedBox(
                    width: (22/baseWidth)*w,

                    height: (22/baseHeight)*h,
                    child: Center(
                      child: Icon(Icons.groups_rounded,
                        size: (25/baseWidth)*w,
                        color: _currentIndex==1?Colors.white:unselectedRed,

                      ),
                    )),
              ),
              label: localizations.groups,
            ),
             BottomNavigationBarItem(

              icon: Padding(
                padding: const EdgeInsets.only(bottom: 5.0),
                child: SizedBox(
                    width: (22/baseWidth)*w,

                    height: (22/baseHeight)*h,
                    child: Center(child: Icon(Icons.contact_page_outlined,
                      size: (25/baseWidth)*w,
                    ))),
              ),
              label: localizations.contacts,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(bottom:( 5.0)),

                child: SizedBox(
                  width: (22/baseWidth)*w,

                  height: (22/baseHeight)*h,

                  child: Center(
                    child: Icon(Icons.question_mark,
                      size: (25/baseWidth)*w,
                      color: _currentIndex==3?Colors.white:unselectedRed,
                    ),
                  ),
                ),
              ),
              label: localizations.requests,
            ),
          ],
          currentIndex: _currentIndex, // Set the default selected index
          onTap: (index) {
            // Add navigation logic here

            setState(() {
              _currentIndex = index;
            });
            if (index == 0) {
              //solve issue of reinitialize chats controller
              Get.delete<ChatsController>(); // Remove old instance
              Get.put(ChatsController()); // Create new instance
              Get.find<ChatsController>().sorting(); // Call sorting function
            }
          },
        ):null,
      ),
    );
  }
}
