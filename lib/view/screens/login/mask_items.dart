// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:flutter_gen/gen_l10n/app_localizations.dart';
//
// import 'package:maskchat/view/screens/login/three_dots_slides.dart';
// import 'package:maskchat/view/widgets/skip_Button.dart';
//
//
// import '../../../const/colors.dart';
// import '../../../const/sizes.dart';
// import '../../../controller/masks_controller.dart';
// import '../../../model/category_mask.dart';
//
// class MaskItems extends StatelessWidget {
//   const MaskItems({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     final localizations = AppLocalizations.of(context)!;
//
//
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//
//       children: [
//         skipButton(w, h,localizations),
//         Padding(
//           padding:  EdgeInsets.symmetric(horizontal: (71/baseWidth)*w,),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               SizedBox(height: (28/baseHeight)*h,),
//               listItems(w,h),
//               Text("Chose Your Mask \n And Start The Chat",
//                 style: TextStyle(
//                     color: ColorsPlatte().secondary.blackBoldText,
//                     fontFamily: "Roboto-Bold",
//                     fontWeight: FontWeight.w500,
//                     fontSize: (21/baseWidth)*w
//
//                 ),
//               ),
//               SizedBox(height: (7/baseHeight)*h,),
//               Text("Lorem Ipsum is simply dummy text of the \n printing and typesetting industry.\n Lorem Ipsum hasdummy text ever.",
//                 style: TextStyle(
//                   color: ColorsPlatte().secondary.lightText3,
//                   fontFamily: "Roboto-Light",
//                   fontWeight: FontWeight.w400,
//
//                 ),
//               ),
//
//
//             ],
//           ),
//         ),
//
//       ],
//     );
//   }
//   Widget listItems(w,h){
//     return GetBuilder<ClassController>(
//       init: ClassController(),
//       builder: (controller) {
//         return SizedBox(
//           height: (185/baseHeight)*h,
//           child: ListView.builder(
//             itemCount: controller.masks.length,
//               itemBuilder: (context,index)=>
//                   Column(
//                     children: [
//                       InkWell(
//                           onTap: (){
//                             controller.selectMask(controller.masks[index].id);
//                             oneSelected = true;
//                             controller.setSelectedMask(controller.masks[index]);
//                           },
//                           child: itemView(controller.masks[index],w,h)),
//                       SizedBox(height: h*.01,)
//                     ],
//                   )
//
//           ),
//         );
//       }
//     );
//   }
//   Widget itemView(Class mask,w,h){
//     return Row(
//       children: [
//         Container(
//     width: (55/baseWidth)*w,
//           height: (32/baseHeight)*h,
//           decoration: BoxDecoration(
//               color: mask.mainColor,
//             borderRadius: BorderRadius.only(
//                 bottomRight: Radius.zero,
//                 bottomLeft: Radius.circular(12),
//                 topRight: Radius.zero,
//                 topLeft: Radius.circular(12)
//             ), // Optional: Add rounded corners, // Optional: Add rounded corners
//
//         ),
//           child: Center(
//             child: mask.icon,
//           ),
//
//         ),
//         Container(
//           padding: EdgeInsets.symmetric(horizontal: 11),
//           width: (155/baseWidth)*w,
//           height: (32/baseHeight)*h,
//           decoration: BoxDecoration(
//             color: mask.secondColor,
//             borderRadius: BorderRadius.only(
//               bottomLeft: Radius.zero,
//               bottomRight: Radius.circular(12),
//               topLeft: Radius.zero,
//               topRight: Radius.circular(12)
//             ), // Optional: Add rounded corners
//
//           ),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Center(
//                 child: Text(
//                   mask.name,
//                   style: TextStyle(
//                     fontSize: (14/baseWidth)*w,
//                     fontWeight: FontWeight.w400,
//                     fontFamily: "Roboto-Medium",
//                     color: ColorsPlatte().secondary.blackBoldText
//                   ),
//                 ),
//               ),
//              mask.selected? Container(
//               width: (15/baseWidth)*w, // Diameter of the circle
//               height: (15/baseHeight)*h, // Same as width for a perfect circle
//     decoration: BoxDecoration(
//     color: mask.mainColor, // Background color
//     shape: BoxShape.circle, // Makes the container circular
//
//     ),
//                 child: Icon(Icons.check,color: Colors.white,size: 15,),
//               ) :SizedBox()  ],
//           ),
//
//         ),
//
//       ],
//     );
//
//   }
//
// }
