import 'dart:developer';

import 'package:Whatsback/controller/api/auth/auth_service.dart';
import 'package:Whatsback/controller/api/chats/chat_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/model/contacts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:phone_text_field/phone_text_field.dart';


import '../../const/colors.dart';
import '../../const/sizes.dart';
import '../../controller/api/phone/phone_cotroller.dart';
import '../../controller/language.dart';
import '../../controller/masks_controller.dart';
import '../../controller/requests_controller.dart';
import '../../model/retrieve_contact.dart';
import 'home/home.dart';

class AddPhoneNumber extends StatefulWidget {
  Contacts? unKnown;
  AddPhoneNumber({this.unKnown,super.key});

  @override
  State<AddPhoneNumber> createState() => _AddPhoneNumberState();
}

class _AddPhoneNumberState extends State<AddPhoneNumber> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final languageController = Get.find<LanguageController>();
  final PhoneController phoneController = Get.put(PhoneController());

  @override
  void initState() {
    super.initState();
    if(widget.unKnown!=null){

      _nameController.text =  'unKnown'.tr;
      _phoneNumberController.text = widget.unKnown!.name;
      setState(() {

      });
    }

    // Initialize controllers with initial values

  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;
    return GetBuilder<ClassController>(
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
          body: SingleChildScrollView(
            child: Column(
              children: [
                SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    children: [
                      Padding(padding: EdgeInsets.only(
                      top: h * .042,
                      left: w * .039,
                      right: w * .05,
                      bottom: h * .038),// .038
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
                      Text(localizations.addPhoneNumber,
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
                        padding: EdgeInsets.only(top: h*.079,left: w * .053, right: w * .044),
                        width: w,
                        height: h*.72,//.85  edit height
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                        ),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              // TextFormField(
                              //   controller: _nameController,
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return localizations.please_enter_name;
                              //     }
                              //     return null;
                              //   },enabled: false,
                              //   style: TextStyle(
                              //     fontFamily: 'Roboto-Medium',
                              //
                              //     color: blackBoldText,
                              //
                              //     fontSize: (16 / baseWidth) *w,
                              //
                              //     fontWeight: FontWeight.w500,
                              //
                              //     fontStyle: FontStyle.normal,
                              //   ),
                              //   decoration: InputDecoration(
                              //
                              //     labelText: localizations.name,
                              //
                              //
                              //
                              //     labelStyle: TextStyle(
                              //
                              //       fontFamily: 'Roboto-Medium',
                              //
                              //       color: lightText,
                              //
                              //       fontSize: (16 / baseWidth) * w,
                              //
                              //       fontWeight: FontWeight.w500,
                              //
                              //       fontStyle: FontStyle.normal,
                              //
                              //
                              //     ),
                              //
                              //     focusedBorder:  UnderlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color:controller.workWithChat? redCheck:controller.selectedMask.mainColor!, // Underline color when focused
                              //         width: 2.0,
                              //       ),
                              //     ),
                              //     enabledBorder: const UnderlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color: underLine, // Default underline color
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //     border: InputBorder.none, // Removes underline
                              //
                              //
                              //   ),
                              //   cursorColor: controller.workWithChat? redCheck:controller.selectedMask.mainColor!,
                              //   // Cursor color when focuse
                              // ),
                              Obx(() {
                                if (phoneController.isLoading.value) {
                                  return Center(child: CircularProgressIndicator(color: redCheck,));
                                } else if (phoneController.contactsList.isEmpty) {
                                  return Text('');
                                } else {
                                  return Column(
                                    children: phoneController.contactsList.map<Widget>((ContactModel contact) {
                                      return ListTile(
                                        title: Text(contact.name),
                                        subtitle: Text(contact.phone),
                                        leading: Icon(Icons.person, color: Colors.blue),
                                      );
                                    }).toList(), // ✅ Ensure conversion to List<Widget>
                                  );
                                }
                              }),

                              SizedBox(
                                height: h*.064,
                              ),
                              // TextFormField(
                              //   controller: _phoneNumberController,
                              //   validator: (value) {
                              //     if (value == null || value.isEmpty) {
                              //       return localizations.please_enter_phone;
                              //     }
                              //     Get.back();
                              //     return null;
                              //   },
                              //   style: TextStyle(
                              //     fontFamily: 'Roboto-Medium',
                              //
                              //     color: blackBoldText,
                              //
                              //     fontSize: (16 / baseWidth) *w,
                              //
                              //     fontWeight: FontWeight.w500,
                              //
                              //     fontStyle: FontStyle.normal,
                              //   ),
                              //   decoration: InputDecoration(
                              //
                              //     labelText: localizations.phoneNumber,
                              //
                              //
                              //     labelStyle: TextStyle(
                              //
                              //       fontFamily: 'Roboto-Medium',
                              //
                              //       color: Colors.black,//lightText,
                              //
                              //       fontSize: (16 / baseWidth) * w,
                              //
                              //       fontWeight: FontWeight.w500,
                              //
                              //       fontStyle: FontStyle.normal,
                              //
                              //
                              //     ),
                              //
                              //     focusedBorder:  UnderlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color:controller.workWithChat? redCheck:controller.selectedMask.mainColor!, // Underline color when focused
                              //         width: 2.0,
                              //       ),
                              //     ),
                              //     enabledBorder: const UnderlineInputBorder(
                              //       borderSide: BorderSide(
                              //         color: underLine, // Default underline color
                              //         width: 1.0,
                              //       ),
                              //     ),
                              //     border: InputBorder.none, // Removes underline
                              //
                              //
                              //   ),
                              //   cursorColor: controller.workWithChat? redCheck:controller.selectedMask.mainColor!,
                              //   onChanged: (value){
                              //    bool validMobileNumber = isValidPhoneNumber(value);
                              //    //here send search mobile number request
                              //   },
                              //   // Cursor color when focuse
                              // ),

                              PhoneTextField(
                                locale:  Get
                                    .find<LanguageController>()
                                    .locale,
                                showCountryCodeAsIcon:true,
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: (10/baseHeight)*h),//12

                                  labelText: localizations.phone_number_label,
                                  hintText: localizations.phone_number_label,

                                  hintStyle:TextStyle(

                                    fontFamily: 'Roboto_light',

                                    color: ColorsPlatte().secondary.textFieldColor,

                                    fontSize: (17 / baseWidth) * w,//18

                                    fontWeight: FontWeight.w400,

                                    fontStyle: FontStyle.normal,

                                  ),
                                  labelStyle: TextStyle(
                                    fontFamily: 'Roboto-Medium',

                                    color: Colors.black,

                                    fontSize: (14 / baseWidth) * w,

                                    fontWeight: FontWeight.w400,

                                    fontStyle: FontStyle.normal,

                                  ),

                                  focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: redCheck, // Underline color when focused
                                      width: 2.0,
                                    ),
                                  ),
                                  enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: underLine, // Default underline color
                                      width: 1.0,
                                    ),
                                  ),
                                  border: const UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color:underLine, // Default border color
                                      width: 1.0,
                                    ),
                                  ),
                                ),
                                searchFieldInputDecoration: InputDecoration(
                                  filled: true,
                                  enabledBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(),
                                  ),
                                  focusedBorder: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(),
                                  ),
                                  suffixIcon: const Icon(Icons.search),
                                  hintText: localizations.searchCountry,
                                ),
                                initialCountryCode: "AE",
                                onChanged: (phone) {
                                  debugPrint(phone.completeNumber);
                                  _phoneNumberController.text=phone.completeNumber;

                                  log(_phoneNumberController.text);
                                  phoneController.checkPhoneNumber(_phoneNumberController.text,user_token.value);
                                },
                              ),
                            ],
                          ),
                        ),

                      )
                    ],
                  ),
                ),
               //  Align(
               //      alignment: Alignment.bottomCenter,
               //      child: InkWell(
               //        onTap: (){
               //          if(widget.unKnown!=null){
               // log("first 1");
               //            Get.find<RequestsController>().deleteRequest(widget.unKnown!.id);
               //
               //          }
               //          if(controller.workWithChat){
               //            log("first 2");
               //                 if ((_formKey.currentState!.validate())) {
               //                   //not understand
               //                   // controller.addContactsToClass(controller.selectedMask
               //                   //     .id, Contacts(isSelected: false,
               //                   //     id: controller.selectedMask.contacts.isEmpty
               //                   //         ? 0
               //                   //         : (controller.selectedMask.contacts[controller
               //                   //         .selectedMask.contacts.length - 1].id + 1),
               //                   //
               //                   //     tag: _nameController.text[0].toUpperCase(),
               //                   //     name: _nameController.text,
               //                   //     image: "assets/images/profile.png",
               //                   //     closed: false,
               //                   //     numOfMessage: ""));
               //
               //
               //                 }
               //          }
               //          else {
               //            log("first 3");
               //            if ((_formKey.currentState!.validate())) {
               //              controller.addContactsToClass(controller.selectedMask
               //                  .id, Contacts(isSelected: false,
               //                  id: controller.selectedMask.contacts.isEmpty
               //                      ? 0
               //                      : (controller.selectedMask.contacts[controller
               //                      .selectedMask.contacts.length - 1].id + 1),
               //
               //                  tag: _nameController.text[0].toUpperCase(),
               //                  name: _nameController.text,
               //                  image: "assets/images/profile.png",
               //                  closed: false,
               //                  numOfMessage: ""));
               //
               //            }
               //            Get.back();
               //          } },
               //        child: Container(
               //          width: w,
               //          height: (45/baseHeight) *h, //45
               //          decoration:   BoxDecoration(
               //              borderRadius: BorderRadius.only(
               //                topLeft: Radius.circular(24.0), // Adjust radius as needed
               //                topRight: Radius.circular(24.0),
               //              ),
               //              gradient: controller.workWithChat?LinearGradient(
               //                colors: [
               //                  Color(0xffd42336),
               //                  Color(0xffed4658) ],
               //                stops: [
               //                  0,
               //                  1
               //                ],
               //                begin: Alignment(1.00, -0.00),
               //                end: Alignment(-1.00, 0.00),
               //                // angle: 270,
               //                // scale: undefined,
               //              ):null,
               //              color: controller.workWithChat?null:controller.selectedMask.mainColor
               //          ),
               //          child:  Center(
               //            child: Text(controller.workWithChat?"${localizations.addToChats}":"${localizations.addTo} ${controller.selectedMask.name}",
               //                style: TextStyle(
               //                  fontFamily: 'Roboto-Regular',
               //                  color: Colors.white,
               //                  fontSize: (18 / baseWidth) *w,
               //                  fontWeight: FontWeight.w400,
               //                  fontStyle: FontStyle.normal,
               //
               //
               //                )
               //            ),
               //          ),
               //        ),
               //      )),
                GetBuilder<ChatController>(
                    init: ChatController(),
                    builder: (chat_controller) {
                      if (chat_controller.loading==true) {
                        return Center(child: CircularProgressIndicator(color: Colors.white,));
                      }

                      return  Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: (){
                              if(widget.unKnown!=null){
                                log("first 1");
                                Get.find<RequestsController>().deleteRequest(widget.unKnown!.id);

                              }
                              if(controller.workWithChat){
                                //here handle create new chat
                                log("first 2");
                                chat_controller.createChat(localizations, user_token.value, phoneController.contactsList[0]);
                                Get.back();
                                if ((_formKey.currentState!.validate())) {
                                  //not understand
                                  // controller.addContactsToClass(controller.selectedMask
                                  //     .id, Contacts(isSelected: false,
                                  //     id: controller.selectedMask.contacts.isEmpty
                                  //         ? 0
                                  //         : (controller.selectedMask.contacts[controller
                                  //         .selectedMask.contacts.length - 1].id + 1),
                                  //
                                  //     tag: _nameController.text[0].toUpperCase(),
                                  //     name: _nameController.text,
                                  //     image: "assets/images/profile.png",
                                  //     closed: false,
                                  //     numOfMessage: ""));


                                }
                              }
                              else {
                                log("first 3");
                                if ((_formKey.currentState!.validate())) {
                                  controller.addContactsToClass(controller.selectedMask
                                      .id, Contacts(isSelected: false,
                                      id: controller.selectedMask.contacts.isEmpty
                                          ? 0
                                          : (controller.selectedMask.contacts[controller
                                          .selectedMask.contacts.length - 1].id + 1),

                                      tag: _nameController.text[0].toUpperCase(),
                                      name: _nameController.text,
                                      image: "assets/images/profile.png",
                                      closed: false,
                                      numOfMessage: ""));

                                }
                                Get.back();
                              } },
                            child: Container(
                              width: w,
                              height: (45/baseHeight) *h, //45
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
                          ));
                    }),
              ],
            ),
          ),
        )  );
      }
    );

  }
  bool isValidPhoneNumber(String phoneNumber) {
    RegExp regex = RegExp(r'^\+?[1-9]\d{6,14}$'); // E.164 format
    return regex.hasMatch(phoneNumber);
  }
}
