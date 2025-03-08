import 'dart:developer';

import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/model/contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../const/colors.dart';
import '../../const/sizes.dart';
import '../../controller/masks_controller.dart';
import 'home/home.dart';

Future<bool> requestPermission() async {
  PermissionStatus status = await Permission.contacts.request();
  print("status$status");

  return status.isGranted;
}

Future<List<Contact>> getContacts() async {
  // Request permission to access contacts
  bool permissionGranted = await requestPermission();
  if (permissionGranted) {
    // Fetch contacts
    Iterable<Contact> contacts = await ContactsService.getContacts(
        withThumbnails: true); // Fetch contacts with thumbnails (photos)
    return contacts.toList();
  } else {
    // Handle the case where permission is not granted
    throw Exception('Permission to access contacts was denied');
  }
}

class AddFromContactes extends StatefulWidget {
  const AddFromContactes({super.key});

  @override
  State<AddFromContactes> createState() => _AddFromContactesState();
}

class _AddFromContactesState extends State<AddFromContactes> {
  List<Contact> contacts = [];
  List<ChatContact> azItems = [];
  List<ChatContact> _selectedContacts = [];
  int idCounter = 1;

  @override
  void initState() {
    super.initState();
    _fetchContacts();
  }
    Future<void> _fetchContacts() async {
      // Fetch phone contacts
      Iterable<Contact> fetchedContacts =
      await ContactsService.getContacts(withThumbnails: true);

      // Convert contacts to AZItems
      List<ChatContact> items = fetchedContacts.map((contact) {
        String displayName = contact.displayName ?? "Unnamed";
        String tag = displayName[0].toUpperCase(); // First letter of the name
        return ChatContact(userId: '0',contactId: '0',isMasked: '0',status: '',
          id:  idCounter++,
          name: displayName,
          tag: RegExp(r'[A-Z]').hasMatch(tag) ? tag : "#",
          closed: false,
            image:idCounter%2==0?"assets/images/Oval2.png":
            idCounter%3==0?"assets/images/Oval3.png":idCounter%5==0?"assets/images/Oval4.png"
                :"assets/images/Oval.png",
          numOfMessage: "0",
          contact: contact,
          isSelected: false
        );
      }).toList();

      // Sort the items by their tag
      SuspensionUtil.sortListBySuspensionTag(items);
      SuspensionUtil.setShowSuspensionStatus(items);

      setState(() {
        contacts = fetchedContacts.toList();
        azItems = items;
        azItems[0].image="assets/images/profile.png";
        azItems[5].image="assets/images/profile.png";
        azItems[0].needInvite=true;
        azItems[5].needInvite=true;
      });
    }


  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;
    Locale locale = Localizations.localeOf(context); // Get the current locale


    return  GetBuilder<ClassController>(
        builder: (controller) {
        return Container(
            width: w,
            height: h,
            decoration:  BoxDecoration(
              gradient: controller.workWithChat? LinearGradient(
                colors: [
                   Color(0xffd42336),
                  Color(0xffed4658),
                ],
                stops: [0, 1],
                end: Alignment(1.00, -0.00),
                begin: Alignment(-1.00, 0.00),
              ):null,
              color: controller.workWithChat?null:controller.selectedMask.mainColor
            ),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              top: h * .042,
                              left: w * .039,
                              right: w * .05,
                              bottom: h * .038),
                          child: Row(
                            children: [
                              InkWell(
                                onTap: (){
                                  Get.back();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios_new,
                                  color: Colors.white,
                                  size: (18 / baseWidth) * w,
                                ),
                              ),
                              SizedBox(
                                width: w * .017,
                              ),
                              Text(localizations.addFromContacts,
                                  style: TextStyle(
                                    fontFamily: 'Roboto-Medium',
                                    color: Colors.white,
                                    fontSize: (21 / baseWidth) * w,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal,
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(left: w * .037, right: w * .034),
                          width: w,
                          height: h * .8,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              topRight: Radius.circular(35),
                              bottomRight: Radius.zero,
                              bottomLeft: Radius.zero
                            ),
                          ),
                          child: azItems.isEmpty
        ?  Center(child: CircularProgressIndicator(color:controller.workWithChat? alphabetRed:controller.selectedMask.mainColor!,))
                                  // Display contacts with their photos
                                    : AzListView(
                            padding: EdgeInsets.zero,

                            indexBarMargin: EdgeInsets.zero,
                              indexBarAlignment: locale.languageCode == 'ar' ?Alignment.topLeft:Alignment.topRight,
                            indexBarOptions: IndexBarOptions(

                                textStyle: TextStyle(
                                  fontFamily: 'Roboto-Medium',
                                  color: controller.workWithChat? alphabetRed:controller.selectedMask.mainColor! ,
                                  fontSize: (12/ baseWidth) * w,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                                selectTextStyle: TextStyle(
                                  fontFamily: 'Roboto-Medium',
                                  color: blackBoldText,
                                  fontSize: (12/ baseWidth) * w,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                ),
                                selectItemDecoration: BoxDecoration(
                                  color: Colors.transparent, // No background color
                                ),
                                needRebuild: true
                              // Optionally customize other styles like background or shape
                            ),

                            data: azItems,
                                      itemCount: azItems.length,
                                      itemBuilder: (context, index) {
                                        ChatContact item = azItems[index];
                                        return Column(
                                          children: [
                                            SizedBox(height: h*.01,),

                                            ListTile(

                                              contentPadding: EdgeInsets.zero,

                                                title: Row(
                                                  children: [
                                            Checkbox(

                                            shape: const CircleBorder(),

                                            side: BorderSide(color: item.isSelected?controller.workWithChat?redIcons:controller.selectedMask.mainColor!:divider),
                                            //fillColor: MaterialStateProperty.resolveWith((states) =>  redIcons),
                                            activeColor: controller.workWithChat?redIcons:controller.selectedMask.mainColor!,
                                            value: item.isSelected,
                                            onChanged: (bool? value) {
                                            setState(() {
                                            item.isSelected = value!;
                                            if(value){

                                              _selectedContacts.add(item);
                                          //    log(item.contact!.phones!.first.value.toString());
                                            }else{
                                              _selectedContacts.remove(item);
                                            }

                                            });
                                            },
                                            ),
                                                    Container(
                                                        width: 45,
                                                        height: 45,
                                                        decoration: const BoxDecoration(
                                                          shape: BoxShape.circle,

                                                        ),
                                                        child:Image.asset(item.image)
                                                    ),
                                                    SizedBox(width: w*.042,),
                                                    Text(item.name),
                                                  ],
                                                ),

                                            ),
                                            SizedBox(height: h*.01,),
                                            Container(
                                                margin: EdgeInsets.only(right:locale.languageCode == 'ar'?0: w*.1,left: locale.languageCode == 'ar'?w*.1:0),
                                                height: 1,
                                                decoration: new BoxDecoration(
                                                    color: divider
                                                )
                                            ),
                                          ],
                                        );
                                      }
                                    ),
                        )
            ]),

                    Align(
                      alignment: Alignment.bottomCenter,
                      child: InkWell(
                        onTap: (){
                          if(controller.workWithChat){}else {

                           for(int i =0;i<_selectedContacts.length;i++){
                             controller.addContactsToClass(controller.selectedMask.id,
                                 ChatContact(userId: '0',contactId: '0',isMasked: '0',
                                   id: _selectedContacts[i].id,status: '',
                                   name: _selectedContacts[i].name,
                                   tag: _selectedContacts[i].name[0].toUpperCase(),
                                   image: "assets/images/profile.png",
                                   isSelected: false,
                                   closed: false,
                                   numOfMessage: "",
                                   needInvite: false,

                                 ));
                           }
                          }
                          Get.back();
                        },
                        child: Container(
                            width: w,
                            height: (52/baseHeight) *h,//45 edit height
                            decoration:   BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(24.0), // Adjust radius as needed
                                  topRight: Radius.circular(24.0),
                                ),
                                gradient: controller.workWithChat?LinearGradient(
                                  colors: [
                                    Color(0xffd42336),
                                    Color(0xffed4658) ],
                                  stops: [
                                    0,
                                    1
                                  ],
                                  begin: Alignment(1.00, -0.00),
                                  end: Alignment(-1.00, 0.00),
                                  // angle: 270,
                                  // scale: undefined,
                                ):null,
                                color: controller.workWithChat?null:controller.selectedMask.mainColor
                            ),
                          child:  Center(
                            child: Text(controller.workWithChat?"${localizations.addToChats}":"${localizations.addTo} ${controller.selectedMask.name}",
                                style: TextStyle(
                                  fontFamily: 'Roboto-Regular',
                                  color: Colors.white,
                                  fontSize: (18 / baseWidth) *w,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,


                                )
                            ),
                          ),
                        ),
                      ))

                  ],
                )));
      }
    );
  }

}
