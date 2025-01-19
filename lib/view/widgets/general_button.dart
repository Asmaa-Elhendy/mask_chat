import 'package:flutter/material.dart';
import 'package:Whatsback/const/sizes.dart';

import '../../const/sizes.dart';

Widget GeneralButton(lable,function, double w, double h){
  return InkWell(
    onTap: function,
    child: Container(
      //padding: EdgeInsets.symmetric(vertical: (h*(26.7/100)),horizontal: (w*(36.1))),

       width: 280,

        height: 45,

        decoration:  BoxDecoration(

            borderRadius: BorderRadius.circular(100),

            gradient: const LinearGradient(

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

            )

        ),
      child: Center(
        child: Text(lable,

            style: TextStyle(

              fontFamily: 'Roboto-Regular',

              color: Colors.white,

              fontSize: (18/baseWidth)*w,

              fontWeight: FontWeight.w400,

              fontStyle: FontStyle.normal,





            )

        ),
      ),

    ),
  );
}