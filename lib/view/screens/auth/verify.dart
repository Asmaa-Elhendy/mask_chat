import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get_common/get_reset.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:Whatsback/const/sizes.dart';
import 'package:Whatsback/view/screens/auth/profile.dart';
import 'package:Whatsback/view/widgets/general_button.dart';
import 'package:flutter/cupertino.dart';

import '../../../const/colors.dart';

class VerifyNumber extends StatefulWidget {
  const VerifyNumber({super.key});

  @override
  State<VerifyNumber> createState() => _VerifyNumberState();
}

class _VerifyNumberState extends State<VerifyNumber> {
  Country? _selectedCountry; // Holds the selected country
  String code = "234567";
  final TextEditingController _phoneNumberController = TextEditingController(text: "01271441036");
  final TextEditingController _codeController = TextEditingController();

  bool edit = false;
  @override
  void initState() {
    super.initState();
    // Set default country (e.g., Egypt)
    _selectedCountry = countries.firstWhere((country) => country.code == 'EG');
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;

    return
      GestureDetector(
        onTap: () {
          // This unfocuses the current text field and dismisses the keyboard
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding:  EdgeInsets.only(top:h*.1,left: w* (4.4/100),right: w* (4.4/100),bottom: h * (.1)),

            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(localizations.verifyPhone,
                    style: TextStyle(
                      fontFamily: 'Roboto-Bold',
                      color: blackBoldText,
                      fontSize: (31/baseWidth)*w,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,


                    )
                ),
                SizedBox(height: h * (1/100),),
                 Text(localizations.enterCode,
                    style: TextStyle(
                      fontFamily: 'Roboto-Regular',
                      color: Colors.black,
                      fontSize: (15/baseWidth) * w,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    )
                ),
                SizedBox(height: h*(5.5/100),),
                SizedBox(
                  width: (328/baseWidth) * w,
                  height: 60,
                  child: DropdownButton<Country>(
                    underline: Container(
                        width: (328 / baseWidth) * w,
                        height: 1,
                        decoration:  const BoxDecoration(color: underLine)

                    ),
                    icon: const Icon(Icons.keyboard_arrow_down,color: dropIcons,),
                    isExpanded: true,
                    value: _selectedCountry,
                    onChanged: (Country? country) {
                      setState(() {
                        _selectedCountry = country;
                      });
                    },
                    items: countries
                        .map((country) => DropdownMenuItem<Country>(
                      value: country,
                      child: Row(
                        children: [
                          // Country Flag
                          ClipOval(
                            child: Image.asset(
                              'assets/flags/${country.code.toLowerCase()}.png',
                              package: 'intl_phone_field',
                              width: (33 / baseWidth) * w,
                              height: (33 / baseWidth) * w,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(width: w*(2.8/100),),
                          Container(
                              width: 1,
                              height: 32,
                              decoration: const BoxDecoration(
                                  color: divider
                              )
                          ),
                          SizedBox(width: w*(3.6/100),),
                          // Country Name and Dial Code
                          Text('${country.name} (${country.dialCode})',
                            style: TextStyle(

                              fontFamily: 'Roboto-Bold',

                              color: blackBoldText,
                              fontSize: (16/baseWidth) * w,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ],
                      ),
                    ))
                        .toList(),

                  ),
                ),

                SizedBox(height: h * (3/100)),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        enabled: edit,

                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: localizations.phone_number_label,

                          labelStyle: TextStyle(

                            fontFamily: 'Roboto_light',

                            color: lightText,

                            fontSize: (16 / baseWidth) * w,

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
                        cursorColor: redCheck, // Cursor color when focused
                      ),
                    ),
                    GestureDetector(
                        onTap: (){
                          setState(() {
                            edit = true;
                          });
                        },
                        child: Icon(Icons.edit,color: redCheck,size: (18/baseWidth) * w,))
                  ],
                ),

                SizedBox(height: h * (3/100),),


                TextField(


                  controller: _codeController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: localizations.code,

                    labelStyle: TextStyle(

                      fontFamily: 'Roboto-Bold',

                      color: Colors.black,

                      fontSize: (14 / baseWidth) * w,

                      fontWeight: FontWeight.w500,

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
                  cursorColor: redCheck, // Cursor color when focused
                ),
              SizedBox(height: h* .032,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  _codeController.text!=code? Text(localizations.codeMismatch,
                      style: TextStyle(
                        fontFamily: 'Roboto-Regular',
                        color: redText,
                        fontSize: (14/ baseWidth) * w,
                        fontWeight: FontWeight.w500,
                       // fontStyle: FontStyle.normal,


                      )
                  ):const SizedBox(),
                    InkWell(
                      child:  Text(localizations.resendCode,
                          style: TextStyle(
                            fontFamily: 'Roboto-Regular',
                            color: blueText,
                            fontSize: (14/baseWidth) * w,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,


                          )
                      ),
                    )
                ],),
                SizedBox(height: h* .136,),

                Center(child: GeneralButton(localizations.verify, (){
                  Get.offAll(const YourProfile());
                }, w, h))




              ],
            ),
          ),
        ),
            ),
      );
  }
}
