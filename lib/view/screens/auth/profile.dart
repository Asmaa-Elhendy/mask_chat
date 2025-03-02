import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:Whatsback/const/sizes.dart';
import 'package:Whatsback/view/screens/auth/starting.dart';
import 'package:Whatsback/view/widgets/general_button.dart';
import '../../../const/colors.dart';
import 'package:flutter/cupertino.dart';

import '../../../controller/api/auth/auth_controller.dart';
import '../login/login.dart';

class YourProfile extends StatefulWidget {
  String email;
  String password;
  String confirmPassword;
   YourProfile({required this.email,required this.password,required this.confirmPassword});

  @override
  State<YourProfile> createState() => _YourProfileState();
}

class _YourProfileState extends State<YourProfile> {
  final AuthController authController = Get.put(AuthController());
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userName = TextEditingController();
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
    return Scaffold(
      body: Padding(
        padding:  EdgeInsets.symmetric(vertical: h*.09),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                       Text(localizations.yourProfile,
                          style: TextStyle(
                            fontFamily: 'Roboto-Bold',
                            color: blackBoldText,
                            fontSize: (28 /baseWidth) * w,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.normal,


                          )
                      ),
                      SizedBox(height: h * .05,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                                      //    mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              width: 100,
                              height: 100,
                              child: _image!=null? Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(image: FileImage(_image!),
                                    fit: BoxFit.cover
                                    ),
                                  ),
                              ):Image.asset("assets/images/profile.png")),
                              GestureDetector(
                               onTap:()=> _showImageSourceSelector(context,localizations),
                                child: Container(
                                  padding: const EdgeInsets.all(3),
                                    margin: EdgeInsets.only(left: w*.01,top: h*.08),

                                    decoration:  const BoxDecoration(
                                        color: redCheck,
                                      shape: BoxShape.circle
                                    ),
                                child: const Icon(Icons.edit,color: profileContainer,size: 15,)
                                ),
                              )

                        ],
                      ),
                    ],

                  ),
                ),
                SizedBox(height: h * .052,),
                Padding(
                  padding:  EdgeInsets.symmetric(horizontal: w * .044),
                  child: TextFormField(

                    controller: _userName,
                    keyboardType: TextInputType.text,
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      color: lightText2,
                      fontSize: (16 / baseWidth) * w,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.normal,
                    ),
                    decoration: InputDecoration(
                      labelText: localizations.userName,

                      labelStyle: TextStyle(

                        fontFamily: 'Roboto-Bold',

                        color: Colors.black,

                        fontSize: (16 / baseWidth) * w,

                        fontWeight: FontWeight.w400,

                        fontStyle: FontStyle.normal,

                      ),
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: underLine2, // Underline color when focused
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
                    ),validator: (value){
    if (value == null || value.isEmpty) {
      return localizations.pleaseEnterName;
    }
                  },
                  //  cursorColor: redCheck, // Cursor color when focused
                  ),
                ),
                SizedBox(height: h * .27,),
        Obx(() => authController.isLoading.value
            ? CircularProgressIndicator(color: redCheck,) // Show loading
            :   Center(child: GeneralButton(localizations.continue_button, (){
                if (_formKey.currentState!.validate()) {
                  authController.register(_userName.text, widget.email, widget.password, widget.confirmPassword, localizations);
                  //  Get.offAll(const Starting()); instead ogf this go to login to solve to fit api in register function in controller

                }

                }, w, h)))



              ],
            ),
          ),
        ),
      ),
    );
  }
  // Function to show a dialog for selecting the image source
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
