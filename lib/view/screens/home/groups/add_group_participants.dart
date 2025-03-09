import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/view/screens/home/groups/create_group.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../const/colors.dart';
import '../../../../const/sizes.dart';
import '../../../../controller/api/groups/groups_controller.dart';
import '../../../widgets/Alert_ask.dart';
import '../../../widgets/alert_warning.dart';
import '../../../widgets/back_icon.dart';

class AddGroupParticipants extends StatefulWidget {
  const AddGroupParticipants({super.key});

  @override
  State<AddGroupParticipants> createState() => _AddGroupParticipantsState();
}

class _AddGroupParticipantsState extends State<AddGroupParticipants> {
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
          body: GetBuilder<GroupController>(
              builder: (controller) {
            return Stack(
              children: [
                SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    child: Column(children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: h * .034, left: w * .039, right: w * .05),
                        child: Row(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            backIcon(w, () {
                              Get.back();
                            }),
                            SizedBox(
                              width: (7.5 / baseWidth) * w,
                            ),
                            Text(localizations.add_participant,
                                style: TextStyle(
                                  fontFamily: 'Roboto-Medium',
                                  color: Colors.white,
                                  fontSize: (21 / baseWidth) * w,
                                  fontWeight: FontWeight.w500,
                                  fontStyle: FontStyle.normal,
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * .03,
                      ),
                      Container(
                          padding:
                              EdgeInsets.only(left: w * .045, right: w * .032),
                          width: w,
                          height: h * .85,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(35),
                                topLeft: Radius.circular(35),
                                bottomLeft: Radius.zero,
                                bottomRight: Radius.zero),
                          ),
                          child: controller.azItems.isEmpty
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: alphabetRed,
                                    ))
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
                                            color: Colors
                                                .transparent, // No background color
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
                                                // margin: EdgeInsets.symmetric(
                                                //     horizontal: (12 / baseWidth) * w),
                                                child: ListTile(
                                                  onTap: () {
                                                    if (controller.azItems[index].needInvite) {
                                                      dialog(localizations.inviteMessage,
                                                          () {},
                                                          w,
                                                          h,localizations);
                                                    } else {


                                                      // Get.find<MessagesController>()
                                                      //     .getMessages(controller.azItems[index]);
                                                      // Get.to(Chat(person: controller.azItems[index],
                                                      // ));
                                                    }
                                                  },

                                                  title: Row(
                                                    children: [
                                                      Checkbox(
                                                        shape:
                                                            const CircleBorder(),

                                                        side: BorderSide(
                                                            color: controller
                                                                    .azItems[
                                                                        index]
                                                                    .isSelected
                                                                ? ColorsPlatte()
                                                                    .primary
                                                                    .redIcons
                                                                : divider),
                                                        //fillColor: MaterialStateProperty.resolveWith((states) =>  redIcons),
                                                        activeColor: controller
                                                                .azItems[index]
                                                                .isSelected
                                                            ? ColorsPlatte()
                                                                .primary
                                                                .redIcons
                                                            : divider,
                                                        value: controller
                                                            .azItems[index]
                                                            .isSelected,
                                                        onChanged:
                                                            (bool? value) {
                                                          if (controller
                                                              .azItems[index]
                                                              .needInvite) {
                                                            dialog(
                                                                localizations.inviteMessage,
                                                                () {},
                                                                w,
                                                                h,localizations);
                                                          } else {
                                                            controller
                                                                    .azItems[index]
                                                                    .isSelected =
                                                                value!;
                                                            if (value) {
                                                              // controller.selectContactToAdd(
                                                              //     controller
                                                              //         .azItems[
                                                              //             index]
                                                              //         .id,
                                                              //     value);
                                                            }
                                                          }
                                                        },
                                                      ),
                                                      Container(
                                                          width: 45,
                                                          height: 45,
                                                          decoration:
                                                              const BoxDecoration(
                                                            shape: BoxShape.circle,
                                                          ),
                                                          child: Image.asset(
                                                              "assets/images/profile.png")),
                                                      SizedBox(
                                                        width: w * .04,
                                                      ),
                                                      Text(controller
                                                          .azItems[index].name,style: TextStyle(fontSize:w*.038,overflow: TextOverflow.ellipsis ),),
                                                    ],
                                                  ),
                                                  // title: Text(controller.azItems[index].name,
                                                  //     style: TextStyle(
                                                  //       fontFamily: 'Roboto-Regular',
                                                  //       color: contactName,
                                                  //       fontSize: (15 / baseWidth) * w,
                                                  //       fontWeight: FontWeight.w400,
                                                  //       fontStyle: FontStyle.normal,
                                                  //     )),
                                                  //trailing: controller.people[index].closed?Icon(Icons.star,color: star,):SizedBox(),
                                                  contentPadding:
                                                      EdgeInsets.zero,
                                                  // trailing:  //need to edit invite feature to next level
                                                  //     controller.azItems[index]
                                                  //             .needInvite
                                                  //         ? TextButton(
                                                  //             onPressed: () {},
                                                  //             child: Text(
                                                  //               localizations.invite,
                                                  //               style: TextStyle(
                                                  //                   color: ColorsPlatte()
                                                  //                       .secondary
                                                  //                       .invite,
                                                  //                   fontFamily:
                                                  //                       "Roboto-Medium",
                                                  //                   fontSize:
                                                  //                       (13 / baseWidth) *
                                                  //                           w,
                                                  //                   fontWeight:
                                                  //                       FontWeight
                                                  //                           .w400),
                                                  //             ))
                                                  //         : SizedBox(),
                                                ),
                                              ),
                                              SizedBox(
                                                height: h * .01,
                                              ),
                                              Container(
                                                  margin: EdgeInsets.only(right:locale.languageCode == 'ar'?0: w*.1,left: locale.languageCode == 'ar'?w*.1:0),

                                                  height: 1,
                                                  decoration: new BoxDecoration(
                                                      color: divider)),
                                            ],
                                          ))

                      )
                    ])),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: InkWell(
                      onTap: () {
                        if(controller.selectedContactsAddtoGroup.isEmpty){
                          dialogWarning(localizations.warning_add_participants,w,h,localizations);
                        }else{
                          Get.to(const CreateGroup());

                        }

                      },
                      child: Container(
                        width: w,
                        height: (45 / baseHeight) * h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                                24.0), // Adjust radius as needed
                            topRight: Radius.circular(24.0),
                          ),
                          gradient: LinearGradient(
                            colors: [Color(0xffd42336), Color(0xffed4658)],
                            stops: [0, 1],
                            begin: Alignment(1.00, -0.00),
                            end: Alignment(-1.00, 0.00),
                            // angle: 270,
                            // scale: undefined,
                          ),
                        ),
                        child: Center(
                          child: Text(localizations.next_button,
                              style: TextStyle(
                                fontFamily: 'Roboto-Regular',
                                color: Colors.white,
                                fontSize: (18 / baseWidth) * w,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal,
                              )),
                        ),
                      ),
                    ))
              ],
            );
          })),
    );
  }
}
