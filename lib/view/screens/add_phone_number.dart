import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/model/contacts.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../const/colors.dart';
import '../../const/sizes.dart';
import '../../controller/masks_controller.dart';
import '../../controller/requests_controller.dart';
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
          body: Stack(
            children: [
              SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(
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
                      height: h*.85,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            TextFormField(
                              controller: _nameController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return localizations.please_enter_name;
                                }
                                return null;
                              },
                              style: TextStyle(
                                fontFamily: 'Roboto-Medium',

                                color: blackBoldText,

                                fontSize: (16 / baseWidth) *w,

                                fontWeight: FontWeight.w500,

                                fontStyle: FontStyle.normal,
                              ),
                              decoration: InputDecoration(

                                labelText: localizations.name,



                                labelStyle: TextStyle(

                                  fontFamily: 'Roboto-Medium',

                                  color: lightText,

                                  fontSize: (16 / baseWidth) * w,

                                  fontWeight: FontWeight.w500,

                                  fontStyle: FontStyle.normal,


                                ),

                                focusedBorder:  UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:controller.workWithChat? redCheck:controller.selectedMask.mainColor!, // Underline color when focused
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: underLine, // Default underline color
                                    width: 1.0,
                                  ),
                                ),
                                border: InputBorder.none, // Removes underline


                              ),
                              cursorColor: controller.workWithChat? redCheck:controller.selectedMask.mainColor!,
                              // Cursor color when focuse
                            ),
                            SizedBox(
                              height: h*.064,
                            ),
                            TextFormField(
                              controller: _phoneNumberController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return localizations.please_enter_phone;
                                }
                                Get.back();
                                return null;
                              },
                              style: TextStyle(
                                fontFamily: 'Roboto-Medium',

                                color: blackBoldText,

                                fontSize: (16 / baseWidth) *w,

                                fontWeight: FontWeight.w500,

                                fontStyle: FontStyle.normal,
                              ),
                              decoration: InputDecoration(

                                labelText: localizations.phoneNumber,



                                labelStyle: TextStyle(

                                  fontFamily: 'Roboto-Medium',

                                  color: lightText,

                                  fontSize: (16 / baseWidth) * w,

                                  fontWeight: FontWeight.w500,

                                  fontStyle: FontStyle.normal,


                                ),

                                focusedBorder:  UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color:controller.workWithChat? redCheck:controller.selectedMask.mainColor!, // Underline color when focused
                                    width: 2.0,
                                  ),
                                ),
                                enabledBorder: const UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: underLine, // Default underline color
                                    width: 1.0,
                                  ),
                                ),
                                border: InputBorder.none, // Removes underline


                              ),
                              cursorColor: controller.workWithChat? redCheck:controller.selectedMask.mainColor!,
                              // Cursor color when focuse
                            ),

                          ],
                        ),
                      ),

                    )
                  ],
                ),
              ),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: (){
                      if(widget.unKnown!=null){

                        Get.find<RequestsController>().deleteRequest(widget.unKnown!.id);

                      }
                      if(controller.workWithChat){
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
                      }
                      else {
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
                      height: (45/baseHeight) *h,
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
          ),
        )  );
      }
    );

  }
}
