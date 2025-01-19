import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get_common/get_reset.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/const/sizes.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl_phone_field/countries.dart';
import 'package:Whatsback/view/screens/auth/verify.dart';
import '../../../const/colors.dart';
import '../../widgets/general_button.dart';
import 'package:flutter/cupertino.dart';

class AddNumber extends StatefulWidget {
  const AddNumber({super.key});

  @override
  State<AddNumber> createState() => _AddNumberState();
}

class _AddNumberState extends State<AddNumber> {
  Country? _selectedCountry; // Holds the selected country
  bool _isTyping = false; // Flag to check if the user is typing
  final TextEditingController _phoneNumberController = TextEditingController();

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
    return GestureDetector(
      onTap: () {
        // This unfocuses the current text field and dismisses the keyboard
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
                
            padding:  EdgeInsets.only(top:h*.13,left: w* (4.4/100),right: w* (4.4/100)),
                
            child: Column(
              children: [
                Text(localizations.header_title,
                    style: TextStyle(
                      fontFamily: 'Roboto-Bold', color: blackBoldText,
                      fontSize: (31/baseWidth) * w,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.normal,
                    )
                ),
                SizedBox(height: h*(6/100),),
                
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
               // const SizedBox(height: 4), // Space between dropdown and line
                
                 SizedBox(height: h * (3/100)),
                TextField(
                
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
                SizedBox(height: h * (20/100)),
                
                GeneralButton(localizations.continue_button,(){

                  Get.offAll(const VerifyNumber());},w,h)
                
                
              ],
            ),
          ),
        ),
      
      ),
    );
  }

}


