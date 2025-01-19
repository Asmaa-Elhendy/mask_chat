// import 'package:flutter/material.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import '../../../const/colors.dart';
// import '../../../const/sizes.dart';
//
// class StartChat extends StatelessWidget {
//   const StartChat({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     final localizations = AppLocalizations.of(context)!;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: (40/baseWidth)*w),
//           child: Column(
//             // mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: (40/baseHeight)*h,),
//               SizedBox(
//                 //  width: (194/baseWidth)*w,
//                 height: (160/baseHeight)*h,
//                 child: Image.asset("assets/images/start chat.png"),
//               ),
//               Text(localizations.startChatTitle,
//                 style: TextStyle(
//                     color: ColorsPlatte().secondary.blackBoldText,
//                     fontFamily: "Roboto-Bold",
//                     fontWeight: FontWeight.w500,
//                     fontSize: (21/baseWidth)*w
//
//                 ),
//               ),
//               SizedBox(height: (7/baseHeight)*h,),
//               Text(localizations.startChatDescription,
//                 style: TextStyle(
//                   color: ColorsPlatte().secondary.lightText3,
//                   fontFamily: "Roboto-Light",
//                   fontWeight: FontWeight.w400,
//
//                 ),
//               ),
//
//
//
//             ],
//           ),
//         )
//
//
//       ],
//     );
//   }
// }
