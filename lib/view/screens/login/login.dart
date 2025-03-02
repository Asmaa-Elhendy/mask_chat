import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:Whatsback/const/sizes.dart';
import 'package:Whatsback/const/colors.dart';
import 'package:Whatsback/view/screens/home/home.dart';
import 'package:Whatsback/view/screens/login/class_contacts.dart';
import 'package:Whatsback/view/widgets/general_button.dart';


import '../../../const/colors.dart';
import '../../../controller/api/auth/auth_controller.dart';
import '../../../controller/api/auth/auth_service.dart';
import '../../widgets/login_textField.dart';
import '../auth/pick_language.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(
      resizeToAvoidBottomInset: true,

      body: SingleChildScrollView(
      //  reverse: true,
      //  physics: const NeverScrollableScrollPhysics(),
        child: Stack(
          children: [
            Container(
              width: w,
              height: h,

              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/background.png'), // Background image
                  fit: BoxFit.cover, // Cover the whole container
                ),
              ),
              child:
              Padding(
                padding:  EdgeInsets.only(top:(20 / 422) * h),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: (77 / 360) * w,

                      child: Image.asset('assets/images/faces.png'),

                    ),
                    SizedBox(height: (8 / 422) * h,),
                    SizedBox(
                        width: (110 / 360) * w,
                        // height: (34 / 422) * h,
                        child: Image.asset('assets/images/whats back.png')),
                    SizedBox(height: (10 / 422) * h,),
                    SizedBox(
                        width: (110 / 360) * w,
                        // height: (34 / 422) * h,
                        child: Image.asset('assets/images/welcome.png'))


                  ],
                ),
              ),
            ),

              Positioned(
                bottom: 0,
                child: Column(
                             //   mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      padding:  EdgeInsets.only(top: (15/baseHeight)*h,left: (16/baseWidth)*w,right: (16/baseWidth)*w),

                      width: w,
                      height: h * .68,
                      decoration:  BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.zero,
                            bottomRight: Radius.zero,
                            topLeft: Radius.circular(35),
                            topRight: Radius.circular(35),
                          )

                      ),
                      child: loginContent(w, h,localizations),
                              ),
                  ],
                ),
              )

          ],
        ),
      ),
    );
  }
  Widget loginContent(w,h,localizations){
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(localizations.signIn ,
              style: TextStyle(
                fontFamily: "Roboto-Medium",
                fontWeight: FontWeight.w400,
                fontSize: (24/baseWidth) *w,
                color: blackBoldText,
              ),
              ),
              Text(localizations.signInToContinue,
                style: TextStyle(
                  fontFamily: "Roboto-Light",
                  fontWeight: FontWeight.w400,
                  fontSize: (16/baseWidth) *w,
                  color: lightText2,
                ),
              )
            ],
          ),
          SizedBox(height: (7/baseHeight)*h,),
          TextFieldsLogin(label: localizations.email, controller: _emailController,hidden:  false,localizations: localizations),
          TextFieldsLogin(label: localizations.password, controller: _passwordController,hidden:true,localizations: localizations),
          SizedBox(height: 16,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: (){},
                child: Text(localizations.forgetPassword,
                style:  TextStyle(
                  color: ColorsPlatte().primary.redIcons,
                  fontFamily: "Roboto-Regular",
                  fontWeight: FontWeight.w400,
                  fontSize: (14/baseWidth) * w
                ),
                ),

              ),

            ],
          ),
          SizedBox(height: (25/baseHeight)*h,),
      Obx(() => authController.isLoading.value
          ? CircularProgressIndicator(color: redCheck,) // Show loading
          :
          Center(
            child: GeneralButton(localizations.signIn, (){


      if (_formKey.currentState!.validate()) {

        String email = _emailController.text.trim();
        String password = _passwordController.text.trim();
        authController.login(email, password); // Call login

      //  Get.offAll(Home());
      }
            }, w, h),
          ),),
          SizedBox(height: (20/baseHeight)*h,),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(localizations.newToWhatsBack,
                style: TextStyle(
                  color: Colors.black,
                    fontFamily: "Roboto-Regular",
                    fontWeight: FontWeight.w400,
                    fontSize: (14/baseWidth) * w
                ),

              ),
              InkWell(
                onTap: (){

                  Get.offAll(PickLanguage(localizations: localizations,));
                },
                child: Text(localizations.signUp,
                  style: TextStyle(
                      color: ColorsPlatte().primary.redIcons,
                      fontFamily: "Roboto-Regular",
                      fontWeight: FontWeight.w400,
                      fontSize: (14/baseWidth) * w
                  ),

                ),

              )

            ],
          )




        ],
      ),
    );

  }

}
