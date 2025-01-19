import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../const/colors.dart';
import '../../../const/sizes.dart';
import '../../../controller/masks_controller.dart';
import '../../../controller/messages_controller.dart';
import '../../widgets/Alert_ask.dart';
import '../../widgets/back_icon.dart';
import '../../widgets/empty_widget.dart';
import '../../widgets/popuomeny_add_contacts.dart';
import '../chat_screen.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({super.key});

  @override
  State<ContactsList> createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;
    Locale locale = Localizations.localeOf(context); // Get the current locale


    return Container(
      width: w,
      height: h,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xffd42336),
            Color(0xffed4658),
          ],
          stops: [0, 1],
          end: Alignment(1.00, -0.00),
          begin: Alignment(-1.00, 0.00),
        ),
      ),

      child: Scaffold(
          backgroundColor: Colors.transparent,

          body: GetBuilder<ClassController>(builder: (controller) {
        return Column(
          children: [
            Container(
             // height: (65 / baseHeight) * h,
              padding:
                  EdgeInsets.only(top: h * .045, left: w * .039, right: w * .05),
              width: w,
              child: Row(
                children: [
                  backIcon(w,
                          (){Get.back();}

                  ),
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
                      )),
                  Spacer(),
                   AddContacts(localizations: localizations,),
                ],
              ),
            ),
            SizedBox(
              height: h * .03,
            ),
            Expanded(
                    child: Container(

            padding: EdgeInsets.only(left: w * .037, right: w * .032),
            width: w,
            height: h * .8,
            decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(35),
              topLeft: Radius.circular(35)
            ),
            ),
                          child:controller.azItems.isEmpty
                              ? const Center(child: CircularProgressIndicator(color: alphabetRed,))
                          // Display contacts with their photos
                              : AzListView(
                                              padding: EdgeInsets.zero,
                                              indexBarMargin: EdgeInsets.zero,
                                              data: controller.azItems,
                                              itemCount: controller.azItems.length,
                            indexBarAlignment: locale.languageCode == 'ar' ?Alignment.topLeft:Alignment.topRight,


                                              indexBarOptions: IndexBarOptions(
                            textStyle: TextStyle(
                              fontFamily: 'Roboto-Medium',
                              color: alphabetRed,
                              fontSize: (12 / baseWidth) * w,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                            selectTextStyle: TextStyle(
                              fontFamily: 'Roboto-Medium',
                              color: blackBoldText,
                              fontSize: (12 / baseWidth) * w,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                            ),
                            selectItemDecoration: BoxDecoration(
                              color: Colors.transparent, // No background color
                            ),
                            needRebuild: true
                            // Optionally customize other styles like background or shape
                            ),
                                              itemBuilder: (context, index) => Column(
                          children: [
                            SizedBox(
                              height: h * .01,
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: (17 / baseWidth) * w),
                              child: ListTile(
                                onTap: () {
                                  if(controller.azItems[index].needInvite){
                                    dialog(localizations.inviteMessage,(){},w,h,localizations);

                                  }else{
                                    Get.find<MessagesController>()
                                        .getMessages(controller.azItems[index]);
                                    Get.to(Chat(person: controller.azItems[index],
                                    ));
                                  }

                                },

                                leading: Container(
                                    width: 45,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                    ),
                                    child: Image.asset(
                                        controller.azItems[index].image)),
                                title: Text(controller.azItems[index].name,
                                    style: TextStyle(
                                      fontFamily: 'Roboto-Regular',
                                      color: contactName,
                                      fontSize: (15 / baseWidth) * w,
                                      fontWeight: FontWeight.w400,
                                      fontStyle: FontStyle.normal,
                                    )),
                                //trailing: controller.people[index].closed?Icon(Icons.star,color: star,):SizedBox(),
                                contentPadding: EdgeInsets.zero,
                                trailing: controller.azItems[index].needInvite?TextButton(onPressed: (){},
                                    child: Text(localizations.invite,
                                    style: TextStyle(
                                      color: ColorsPlatte().secondary.invite,
                                      fontFamily: "Roboto-Medium",
                                      fontSize: (13/baseWidth)*w,
                                      fontWeight: FontWeight.w400
                                    ),
                                    )):SizedBox(),
                              ),
                            ),
                            SizedBox(
                              height: h * .01,
                            ),
                            Container(
                                margin: EdgeInsets.only(right:locale.languageCode == 'ar'?0: w*.1,left: locale.languageCode == 'ar'?w*.1:0),
                                height: 1,
                                decoration: new BoxDecoration(color: divider)),
                          ],
                                              ),
                                            ),
                        ),
                  )
          ],
        );
      })),
    );
  }
}
