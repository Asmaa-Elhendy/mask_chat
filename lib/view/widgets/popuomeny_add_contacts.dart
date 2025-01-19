import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/const/colors.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../const/sizes.dart';
import '../screens/add from contacts.dart';
import '../screens/add_phone_number.dart';

class AddContacts extends StatelessWidget {
  Color myColor;
  var localizations;
   AddContacts({required this.localizations,super.key, this.myColor = redIcons});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return PopupMenuButton<int>(

        offset: const Offset(0, 55), // Adjust the position of the menu (x, y)
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Add a slight radius
        ),
      color: Colors.white,
      onSelected: (int result) {
        // Handle the selected option
        if(result==0){
          Future<bool> requestPermission() async {
            PermissionStatus status = await Permission.contacts.request();
            print("status$status");

            return status.isGranted;
          }
          requestPermission();
          Get.to(const AddFromContactes());
        }else if(result == 1){
          Get.to( AddPhoneNumber());
        }
        print(result);
      },
      itemBuilder: (BuildContext context) => [
        PopupMenuItem<int>(
          value: 0,
          child: tile(w,h,
           Icon(Icons.perm_contact_calendar_outlined,color: myColor,),localizations.addFromContacts
          ),
        ),
        const PopupMenuDivider(
          height: .01,
        ),
        PopupMenuItem<int>(
          value: 1,
          child: tile(w,h,
     Icon(Icons.contact_phone_outlined,color: myColor,),localizations.addPhoneNumber,
        ),)
      ],
        icon:  Icon(Icons.add,color: Colors.white,size: (25/baseWidth) * w,)
    );
  }
  Widget tile(w,h,icon,text){
    return Row(
      children: [
         Container(
            width: 37,
            height: 37,
            decoration: new BoxDecoration(
                color: pinkShade,
              shape: BoxShape.circle
            ),
          child: icon,

        ),
        SizedBox(width: w*.042,),
        Text(
            text,
            style: TextStyle(
              fontFamily: 'Roboto-Regular',
              color: contactName,
              fontSize: (15 / baseWidth) *w,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            )

        )
      ],
    );
  }
}
