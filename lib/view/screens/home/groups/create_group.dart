import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:Whatsback/view/screens/home/groups/group_list.dart';
import 'package:Whatsback/view/widgets/alert_warning.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/colors.dart';
import '../../../../const/sizes.dart';
import '../../../../controller/api/groups/groups_controller.dart';
import '../../../widgets/back_icon.dart';
import '../home.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _subjectController = TextEditingController();
  File? _image; // To store the selected image
  final ImagePicker _picker = ImagePicker();
  // Function to pick an image from the gallery or camera
  Future<void> _pickImage(ImageSource source) async {
    final XFile? pickedFile = await _picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
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
        body: GetBuilder<GroupController>(builder: (controller) {
          return Stack(
            children: [
              SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          top: h * .034, left: w * .039, right: w * .05),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          backIcon(w, () {
                            Get.back();
                          }),
                          SizedBox(
                            width: (7.5 / baseWidth) * w,
                          ),
                          Text(localizations.new_group,
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
                    SizedBox(
                      height: h * .03,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: (40 / baseHeight) * h),
                      width: w,
                      height: h * .85,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                            topLeft: Radius.circular(35),
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.zero),
                      ),
                      child: Column(children: [
                        Container(
                          padding: EdgeInsets.only(
                              left: (16 / baseWidth) * w,
                              right: (16 / baseWidth) * w,
                              bottom: (29 / baseWidth) * w),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: (){
                                      _showImageSourceSelector(context,localizations);
                                    },

                                    child: CircleAvatar(
                                      backgroundColor: pinkShade,
                                      radius: 35,
                                      child:  _image!=null? Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: DecorationImage(image: FileImage(_image!),
                                              fit: BoxFit.cover
                                          ),
                                        ),
                                      ):Icon(Icons.camera_alt,
                                          color: ColorsPlatte().primary.redIcons),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Expanded(
                                    child: TextField(
                                      controller: _subjectController,
                                      style: TextStyle(
                                        fontFamily: 'Roboto-Medium',
                                        color: blackBoldText,
                                        fontSize: (16 / baseWidth) * w,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      ),
                                      decoration: InputDecoration(
                                        labelText: localizations.group_subject,

                                        labelStyle: TextStyle(
                                            fontFamily: "Roboto-Bold",
                                            color:
                                                Colors.black.withOpacity(.44),
                                            fontWeight: FontWeight.w200,
                                            fontSize: (14 / baseWidth) * w),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: ColorsPlatte()
                                                .primary
                                                .redIcons, // Underline color when focused
                                            width: 2.0,
                                          ),
                                        ),
                                        enabledBorder:
                                            const UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                underLine, // Default underline color
                                            width: 1.0,
                                          ),
                                        ),
                                        border: InputBorder
                                            .none, // Removes underline
                                      ),
                                      cursorColor:
                                          ColorsPlatte().primary.redIcons,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                children: [
                                  //  SizedBox(width:(90/baseWidth)*w),
                                  Spacer(),
                                  Text(
                                    localizations.provide_subject_and_image,
                                    style: TextStyle(
                                        fontFamily: "Roboto-Regular",
                                        color:
                                            ColorsPlatte().secondary.lightText6,
                                        fontSize: (12 / baseWidth) * w),
                                  ),
                                  SizedBox(
                                    width: (20 / baseWidth) * w,
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                        Container(
                          width: w,
                          color: ColorsPlatte().secondary.lightText7,
                          child: // Participants Section
                              Padding(
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(localizations.participants,
                                    style: TextStyle(
                                        color:
                                            ColorsPlatte().secondary.lightText3,
                                        fontFamily: "Roboto-Regular",
                                        fontSize: (16 / baseWidth) * w,
                                        fontWeight: FontWeight.w300)),
                                Text(
                                    '${controller.selectedContactsAddtoGroup.length}/230',
                                    style: TextStyle(
                                        color:
                                            ColorsPlatte().secondary.lightText3,
                                        fontFamily: "Roboto-Regular",
                                        fontSize: (15 / baseWidth) * w,
                                        fontWeight: FontWeight.w300)),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: (10 / baseHeight) * h),
                        Expanded(
                            child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                           //  mainAxisSpacing: 8,
                           //
                           // crossAxisSpacing: 10,
                                childAspectRatio: 2/2.6
                          ),
                          itemCount: controller.selectedContactsAddtoGroup
                              .length, // Replace with actual participant count
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Stack(
                                  children: [
                                    Container(
                                      height: (50 / baseHeight) * h,
                                      width: (50 / baseWidth) * w,
                                      child: CircleAvatar(
                                        radius: 25,
                                        child: Image.asset(controller
                                            .selectedContactsAddtoGroup[index]
                                            .image),
                                      ),
                                    ),
                                    Positioned(
                                      top: 3,
                                      right: 0,
                                      //top: 0,
                                      //right: -2,
                                      child: GestureDetector(
                                        onTap: () {
                                          // Remove participant
                                          controller.selectContactToAdd(
                                              controller
                                                  .selectedContactsAddtoGroup[
                                                      index]
                                                  .id,
                                              false);
                                        },
                                        child: CircleAvatar(
                                          radius: 10,
                                          backgroundColor:
                                              ColorsPlatte().primary.remove,
                                          child: const Icon(Icons.close,
                                              color: Colors.white, size: 16),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 4),
                                Text(
                                  '${controller.selectedContactsAddtoGroup[index].name}', // Replace with actual name
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            );
                          },
                        ))
                      ]),
                    )
                  ])),
              Align(
                  alignment: Alignment.bottomCenter,
                  child: InkWell(
                    onTap: () {
                      if(_subjectController.text!=""&&_subjectController.text.isNotEmpty){
                        controller.addNewGroup(_subjectController.text, controller.selectedContactsAddtoGroup, _image);
                        Get.offAll(Home(page: 1,));

                      }else{
                        dialogWarning(localizations.enter_subject_warning, w, h,localizations);
                      }

                    },
                    child: Container(
                      width: w,
                      height: (45 / baseHeight) * h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(24.0), // Adjust radius as needed
                          topRight: Radius.circular(24.0),
                        ),
                        gradient: LinearGradient(
                          colors: [Color(0xffd42336), Color(0xffed4658)],
                          stops: [0, 1],
                          begin: Alignment(1.00, -0.00),
                          end: Alignment(-1.00, 0.00),
                          // angle: 270,
                          // scale: undefined,
                        ),
                      ),
                      child: Center(
                        child: Text(localizations.create_group,
                            style: TextStyle(
                              fontFamily: 'Roboto-Regular',
                              color: Colors.white,
                              fontSize: (18 / baseWidth) * w,
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                            )),
                      ),
                    ),
                  ))
            ],
          );
        }),
      ),
    );
  }
  void _showImageSourceSelector(BuildContext context,localizations) {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: Icon(Icons.photo),
              title: Text(localizations.gallery),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
            ListTile(
              leading: Icon(Icons.camera),
              title: Text(localizations.camera),
              onTap: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
            ),
          ],
        ),
      ),
    );
  }
}
