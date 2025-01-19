import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:Whatsback/const/colors.dart';
import 'package:Whatsback/view/widgets/empty_widget.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../const/sizes.dart';
import '../../../controller/masks_controller.dart';
import '../../../controller/messages_controller.dart';
import '../../widgets/back_icon.dart';
import '../../widgets/popuomeny_add_contacts.dart';
import '../chat_screen.dart';

class PeopleOnMask extends StatefulWidget {
  const PeopleOnMask({super.key});

  @override
  State<PeopleOnMask> createState() => _PeopleOnMaskState();
}

class _PeopleOnMaskState extends State<PeopleOnMask> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;
    return Scaffold(

      body:  GetBuilder<ClassController>(
    builder: (controller) {
      return Column(
        children: [
          Container(
            color: controller.selectedMask.mainColor,
            height: (70/baseHeight)*h,
      padding:  EdgeInsets.only(top: h* .034,
      left: w * .039,right: w * .05),
            width: w,
            child: Row(

              children: [
                backIcon(w,(){Get.back();}),
                SizedBox(
                  width: w * .017,
                ),
                Text(controller.selectedMask.name,
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      color: Colors.white,
                      fontSize: (21 / baseWidth) * w,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    )
                ),
                Spacer(),
                 AddContacts(myColor: controller.selectedMask.mainColor!,localizations: localizations,),
              ],
            ),
          ),
          SizedBox(height: h * .03,),
          controller.selectedMask.contacts.isEmpty?Padding(
            padding:  EdgeInsets.only(top: h*.25,left: (50/baseWidth)*w,right: (50/baseWidth)*w),
            child: EmptyWidget(localizations: localizations,),
          ):Expanded(
            child: ListView.builder(
              itemCount: controller.selectedMask.contacts.length,

                itemBuilder: (context,index)=>Column(
                  children: [
                    SizedBox(height: h*.01,),
                    Container( margin: EdgeInsets.symmetric(horizontal: (17/baseWidth)*w),

                      child: Slidable(
                        direction: Axis.horizontal,
                        key: ValueKey(controller.selectedMask.contacts[index].id), // Unique key for each contact
                        endActionPane: ActionPane(
                          motion: ScrollMotion(

                          ),
                          extentRatio: 0.4, // Adjust width of the action buttons
                          children: [

                           Builder(
                             builder: (cont) {
                               return ElevatedButton(
                                      onPressed: () {
                                         controller.deleteContact(controller.selectedMask,controller.selectedMask.contacts[index].id);
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
                             }
                           )

                          ],
                        ),
                        child: ListTile(

                          onTap: (){
                             Get.find<MessagesController>().getMessages(controller.selectedMask.contacts[index]);
                            Get.to(Chat(person:controller.selectedMask.contacts[index],));
                          },

                          leading:Container(
                              width: 45,
                              height: 45,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,

                              ),
                              child:Image.asset( controller.selectedMask.contacts[index].image)
                          ),
                          title: Text(controller.selectedMask.contacts[index].name,

                              style: TextStyle(
                                fontFamily: 'Roboto-Regular',
                                color: contactName,
                                fontSize: (15 / baseWidth) * w,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,

                              )

                          ),
                          //trailing: controller.people[index].closed?Icon(Icons.star,color: star,):SizedBox(),
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
                  ],
                ),


            ),
          )
        ],

      );
    } ) );
  }
  // Widget listOfContacts(){
  //   return ListView.builder(
  //
  //       itemBuilder: (context,index)=>
  //   ) ;
  // }

}
