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
            validator: (value){
              if (value == null || value.isEmpty) {

                if(widget.label==localizations.email){
                  return localizations.pleaseEnterEmail;
                }else if(widget.label==localizations.password||widget.label==localizations.confirmPassword){
                  return localizations.pleaseEnterPassword;
                }

              }
              return null;
            },

          ),
        ),
      ],
    );
  }
}
