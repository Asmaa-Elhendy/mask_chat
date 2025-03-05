import 'package:flutter/material.dart';

import '../../const/colors.dart';

TypeRadioButton(String text,double width,double height,int btnValue,int groupValue,ValueChanged<int?> onChanged){
  return Row(
      mainAxisAlignment: MainAxisAlignment.start,

      children: <Widget>[

        SizedBox(width: width*.05, // Adjust the size as needed

          child: Radio(
              activeColor:redCheck,
              value: btnValue,
              groupValue: groupValue,
              onChanged:onChanged
          ),
        ),SizedBox(width: width*.02,),
        Text(text,style: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: .044 * width)),
      ]);
}
