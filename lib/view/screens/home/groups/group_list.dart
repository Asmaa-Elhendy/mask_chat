import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:Whatsback/view/screens/home/groups/group_Chat.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../../const/colors.dart';
import '../../../../const/sizes.dart';
import '../../../../controller/groups_controller.dart';
import '../../../../controller/messages_controller.dart';
import '../../../widgets/add_group.dart';
import '../../chat_screen.dart';

class GroupList extends StatelessWidget {
  const GroupList({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: h* .034,
                left: w * .039,right: w * .05
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(localizations.groups,
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      color: Colors.white,
                      fontSize: (26 / baseWidth) * w,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    )
                ),
                const AddGroup()
              ],
            ),
          ),
          SizedBox(height: h * .03,),
          Container(
            padding:  EdgeInsets.only(left: w *.035,right: w*.035,bottom: (13/baseHeight)*h,top: (13/baseHeight)*h),

            width: w,
            height: h * .765,
            decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35),
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35)
                )


            ),
            child:GetBuilder<GroupController>(
                init: GroupController(),
                builder: (controller) {
                  return SizedBox(
                    child: ListView.builder(
                        padding: EdgeInsets.zero,

                       itemCount: controller.groupsList.length,
                        itemBuilder: (context,index){
                          return Column(
                              children: [
                                SizedBox(height: h*.01,),
                                Container(
                                  margin: EdgeInsets.only(right: w*.1),

                                  child:Slidable(

                                    direction: Axis.horizontal,

                                    key: ValueKey(controller.groupsList[index].id), // Unique key for each contact
                                    endActionPane: ActionPane(
                                      motion: ScrollMotion(

                                      ),
                                    //  extentRatio: 0.4, // Adjust width of the action buttons
                                      children: [
                                        Builder(
                                          builder: (cont) {
                                            return ElevatedButton(
                                              onPressed: () {
                                               controller.toggleClosed(controller.groupsList[index].id);
                                                Slidable.of(cont)!.close();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: CircleBorder(),
                                                backgroundColor: star,

                                                padding: EdgeInsets.all(2),

                                              ),
                                              child: const Icon(
                                                Icons.star,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            );
                                          },
                                        ),
                                        Builder(
                                          builder: (cont) {
                                            return ElevatedButton(
                                              onPressed: () {
                                                controller.deleteGroup(controller.groupsList[index].id);
                                                Slidable.of(cont)!.close();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                shape: CircleBorder(),
                                                backgroundColor: delete,
                                                padding: EdgeInsets.all(2),
                                              ),
                                              child: const Icon(
                                                Icons.delete_outline,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            );
                                          },
                                        ),
                                        // Delete Icon Button

                                      ],
                                    ),
                                    child: ListTile(

                                      onTap: (){
                                        Get.find<MessagesController>().getGroupMessage(controller.groupsList[index]);
                                        Get.to(GroupChat());
                                      },

                                      leading:Container(
                                          width: 45,
                                          height: 45,
                                          decoration:  BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                scale: 1.5, // Adjust the scale
                                                image: controller.groupsList[index].image is String?
                                            AssetImage(

                                                controller.groupsList[index].image==""?"assets/images/categories/Closed friend.png":controller.groupsList[index].image,
                                            )

                                                     :FileImage(
                                              controller.groupsList[index].image,
                                              scale: 1.5,
                                               // fit: BoxFit.cover,

                                            ),
                                                fit: BoxFit.cover
                                            ),

                                          ),
                                          // child:controller.groupsList[index].image is String?Image.asset( controller.groupsList[index].image==""?"assets/images/group (2).png":controller.groupsList[index].image
                                          //
                                          //   ,scale: 1.5,
                                          //
                                          // ):Image.file(
                                          //   controller.groupsList[index].image,
                                          //   scale: 1.5,
                                          //   fit: BoxFit.cover,
                                          //
                                          // )
                                      ),
                                      title: Text(controller.groupsList[index].subject,

                                          style: TextStyle(
                                            fontFamily: 'Roboto-Regular',
                                            color: contactName,
                                            fontSize: (15 / baseWidth) * w,
                                            fontWeight: FontWeight.w400,
                                            fontStyle: FontStyle.normal,

                                          )

                                      ),
                                      trailing: controller.groupsList[index].fav?Icon(Icons.star,color: star,):SizedBox(),
                                      contentPadding: EdgeInsets.zero,

                                    ),
                                  ),
                                ),
                                SizedBox(height: h*.01,),
                                Container(
                                    margin: EdgeInsets.only(right: w*.1),
                                    height: 1,
                                    decoration: new BoxDecoration(
                                        color: divider
                                    )
                                ),
                                //SizedBox(height: h*.02,),
                              ]);
                        }


                    ),
                  );}),

            // child: GetBuilder<ChatsController>(
            //     init: ChatsController(),
            //   builder: (controller) {
            //     return ListView.builder(
            //       padding: EdgeInsets.zero,
            //         itemCount: controller.contacts.length,
            //    //     shrinkWrap: true,
            //
            //         itemBuilder: (context, index) {
            //           return
            //             Column(
            //               children: [
            //                 SizedBox(height: h*.02,),
            //                 Container(
            //                   margin: EdgeInsets.only(right: w*.1),
            //
            //                   child: ListTile(
            //
            //                     onTap: (){},
            //
            //                     leading:Container(
            //                         width: 45,
            //                         height: 45,
            //                         decoration: const BoxDecoration(
            //                           shape: BoxShape.circle,
            //
            //                         ),
            //                         child:Image.asset( controller.contacts[index].image)
            //                     ),
            //                     title: Text(controller.contacts[index].name,
            //
            //                         style: TextStyle(
            //                           fontFamily: 'Roboto-Regular',
            //                           color: contactName,
            //                           fontSize: (15 / baseWidth) * w,
            //                           fontWeight: FontWeight.w400,
            //                           fontStyle: FontStyle.normal,
            //
            //                         )
            //
            //                     ),
            //                     trailing: controller.contacts[index].closed?Icon(Icons.star,color: star,):SizedBox(),
            //                     contentPadding: EdgeInsets.zero,
            //
            //                   ),
            //                 ),
            //                 SizedBox(height: h*.02,),
            //                 Container(
            //                     margin: EdgeInsets.only(right: w*.1),
            //                     height: 1,
            //                     decoration: new BoxDecoration(
            //                         color: divider
            //                     )
            //                 ),
            //                 SizedBox(height: h*.02,),
            //
            //               ],
            //             );
            //
            //         }
            //     );
            //   }
            // ),
          )

        ],
      ),
    );
  }
}
