import 'package:flutter/material.dart';

import '../../const/colors.dart';
import '../../const/sizes.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class TextFieldsLogin extends StatefulWidget {
  String label;
      var controller;
      bool hidden;
      var localizations;

   TextFieldsLogin({required this.localizations,required this.hidden,required this.label,this.controller});

  @override
  State<TextFieldsLogin> createState() => _TextFieldsLoginState();
}

class _TextFieldsLoginState extends State<TextFieldsLogin> {

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;
    return  Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //  widget.label,
        //   style: TextStyle(
        //     fontFamily: 'Roboto-Medium',
        //
        //     color: Colors.black,
        //
        //     fontSize: (14 / baseWidth) * w,
        //
        //     fontWeight: FontWeight.w400,
        //
        //     fontStyle: FontStyle.normal,
        //
        //   ),
        //
        //
        //
        // ),
        SizedBox(
          height: h*.12,
          child: TextFormField(

            controller: widget.controller,
      //      keyboardType: widget.hidden?TextInputType.text:TextInputType.phone,
            obscureText: widget.hidden,


            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: (10/baseHeight)*h),//12

              labelText: widget.label,
              hintText: widget.label,
              suffix:widget.label==widget.localizations.password?
              InkWell(
                  onTap: (){
                    setState(() {
                      widget.hidden = !widget.hidden;
                    });
                  },
                  child: Icon(widget.hidden?Icons.remove_red_eye_rounded:Icons.remove_red_eye_outlined,color: ColorsPlatte().secondary.eye,)):SizedBox(),
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
            cursorColor: redCheck, // Cursor color when focused
            validator:


                widget.label==localizations.email?
                  validateEmail:
    ( widget.label==localizations.password||widget.label==localizations.confirmPassword)?
                  validatePassword:  (value) {

    return null;
    },autovalidateMode: AutovalidateMode.onUserInteraction,



          ),
        ),
      ],
    );
  }
  String?  validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isEmpty ||value==null?widget.localizations.pleaseEnterEmail: !regex.hasMatch(value)
        ? widget.localizations.enterValidEmailAddress
        : null;
  }
  String?  validatePassword(String? value) {
    if(value!.isEmpty ||value==null) {
      return widget.localizations.pleaseEnterPassword;

    }
    else{
      if (!RegExp(r'^[a-zA-Z]').hasMatch(value)) {
        return widget.localizations.passwordMustStartWithLetter;
      }
      if (value.length < 8) {
        return widget.localizations.passwordMustBeAtLeast8charactersLong;
      }
      if (!RegExp(r'\d').hasMatch(value)) {
        return widget.localizations.passwordMustContainAtLeastOneNumber;
      }
    }
    return null;

  }
}
