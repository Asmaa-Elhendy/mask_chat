import 'dart:developer';

import 'package:Whatsback/controller/api/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:Whatsback/const/sizes.dart';
import 'package:Whatsback/controller/api/chats/chats_controller.dart';
import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:Whatsback/controller/api/messages/messages_controller.dart';
import '../../../const/colors.dart';
import '../../../controller/user_controller.dart';
import '../../../model/contacts.dart';
import '../../../model/user_model.dart';
import '../../widgets/Alert_ask.dart';
import '../../widgets/popuomeny_add_contacts.dart';
import '../chat_screen.dart';

class chatList extends StatefulWidget {
  const chatList({super.key});

  @override
  State<chatList> createState() => _chatListState();
}

class _chatListState extends State<chatList> {
  List<ChatContact> selectedContacts = [];
  // bool isSelectionMode = false;
  UserModel? fetchedUser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  getUser() async {
    final AuthService _userApiService = AuthService();
    fetchedUser = await _userApiService.fetchUser(user_token.value);
    setState(() {});
    print('here' + fetchedUser!.name);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;
    Locale locale = Localizations.localeOf(context); // Get the current locale

    return GetBuilder<ChatsController>(
        init: ChatsController(),
        key: UniqueKey(),
        builder: (chatcontroller) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: h * .034, left: w * .039, right: w * .05),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(localizations.chats,
                          style: TextStyle(
                            fontFamily: 'Roboto-Medium',
                            color: Colors.white,
                            fontSize: (26 / baseWidth) * w,
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                          )),
                      Row(
                        children: [
                          // isSelectionMode
                          //     ? InkWell(
                          //         onTap: () {
                          //           Get.defaultDialog(
                          //             title:
                          //                 "${localizations.deleteConfirmationPart1} ${selectedContacts.length} ${localizations.deleteConfirmationPart2}",
                          //             middleText: "",
                          //             titlePadding:
                          //                 EdgeInsets.only(top: h * .04),
                          //             // textConfirm: "Yes",
                          //             // textCancel: "Ignore",
                          //             titleStyle: TextStyle(
                          //                 color: ColorsPlatte()
                          //                     .secondary
                          //                     .blackBoldText,
                          //                 fontSize: (16 / baseWidth) * w,
                          //                 fontFamily: "Roboto-Medium"),
                          //             actions: [
                          //               SizedBox(
                          //                 width: w * .27,
                          //                 child: OutlinedButton(
                          //                   onPressed: () {
                          //                     Get.back();
                          //                   },
                          //                   style: OutlinedButton.styleFrom(
                          //                     side: BorderSide(
                          //                         color: ColorsPlatte()
                          //                             .primary
                          //                             .redIcons), // Red border
                          //                     shape: RoundedRectangleBorder(
                          //                       borderRadius:
                          //                           BorderRadius.circular(100),
                          //                     ),
                          //                   ),
                          //                   child: Text(
                          //                     localizations.ignore,
                          //                     style: TextStyle(
                          //                       fontFamily: "Roboto-Regular",
                          //                       fontSize: (16 / baseWidth) * w,
                          //                       color: ColorsPlatte()
                          //                           .primary
                          //                           .redIcons,
                          //                     ), // Red text
                          //                   ),
                          //                 ),
                          //               ),
                          //               SizedBox(width: (12 / baseWidth) * w),
                          //               // Space between buttons
                          //
                          //               SizedBox(
                          //                 width: w * .27,
                          //                 child: ElevatedButton(
                          //                   onPressed: () {
                          //                     for (int i = 0;
                          //                         i < selectedContacts.length;
                          //                         i++) {
                          //                       chatcontroller.deleteContact(
                          //                           localizations,
                          //                           selectedContacts[i].id,
                          //                           user_token.value);
                          //                     }
                          //
                          //                     setState(() {
                          //                       isSelectionMode = false;
                          //                       selectedContacts = [];
                          //                     });
                          //                     Get.back();
                          //                   },
                          //                   style: ElevatedButton.styleFrom(
                          //                     backgroundColor: ColorsPlatte()
                          //                         .primary
                          //                         .redIcons,
                          //                     shape: RoundedRectangleBorder(
                          //                       borderRadius:
                          //                           BorderRadius.circular(100),
                          //                     ),
                          //                   ),
                          //                   child: Text(
                          //                     localizations.yes,
                          //                     style: TextStyle(
                          //                         color: Colors.white,
                          //                         fontFamily: "Roboto-Regular",
                          //                         fontSize:
                          //                             (16 / baseWidth) * w),
                          //                   ),
                          //                 ),
                          //               ),
                          //             ],
                          //           );
                          //         },
                          //         child: Icon(
                          //           Icons.delete_outline,
                          //           color: Colors.white,
                          //         ),
                          //       )
                          //     : SizedBox(),
                          AddContacts(
                            localizations: localizations,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: h * .02,
                ),
                Container(
                    padding: EdgeInsets.only(
                        left: w * .035,
                        right: w * .035,
                        bottom: (13 / baseHeight) * h,
                        top: (13 / baseHeight) * h),
                    width: w,
                    height: h * .765,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(35),
                            topLeft: Radius.circular(35),
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35))),
                    child: SizedBox(
                      child: chatcontroller.chatLoading == true
                          ? Center(
                              child: CircularProgressIndicator(
                              color: redCheck,
                            ))
                          : chatcontroller.contacts.isNotEmpty
                              ? AzListView(
                                  padding: EdgeInsets.only(bottom: h*.05),
                                  indexBarMargin: EdgeInsets.zero,
                                  data: chatcontroller.contacts,
                                  indexBarAlignment: locale.languageCode == 'ar'
                                      ? Alignment.topLeft
                                      : Alignment.topRight,
                                  itemCount: chatcontroller.contacts.length,
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
                                  itemBuilder: (context, index) {
                                    return Column(children: [
                                      SizedBox(
                                        height: h * .01,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            right: locale.languageCode == 'ar'
                                                ? 0
                                                : w * .08,
                                            left: locale.languageCode == 'ar'
                                                ? w * .08
                                                : 0),
                                        child: Slidable(
                                          direction: Axis.horizontal,
                                          key: ValueKey(chatcontroller
                                              .contacts[index].id),
                                          // Unique key for each contact
                                          endActionPane: ActionPane(
                                            motion: ScrollMotion(),
                                            //   extentRatio: 0.4, // Adjust width of the action buttons
                                            children: [
                                              //comment favourite feature now
                                              // Builder(
                                              //   builder: (cont) {
                                              //     return ElevatedButton(
                                              //       onPressed: () {
                                              //         chatcontroller
                                              //             .toggleClosed(
                                              //                 chatcontroller
                                              //                     .contacts[
                                              //                         index]
                                              //                     .id);
                                              //         Slidable.of(cont)!
                                              //             .close();
                                              //       },
                                              //       style: ElevatedButton
                                              //           .styleFrom(
                                              //         shape: CircleBorder(),
                                              //         backgroundColor: star,
                                              //         padding:
                                              //             EdgeInsets.all(2),
                                              //       ),
                                              //       child: const Icon(
                                              //         Icons.star,
                                              //         color: Colors.white,
                                              //         size: 30,
                                              //       ),
                                              //     );
                                              //   },
                                              // ),
                                              Builder(
                                                builder: (cont) {
                                                  return ElevatedButton(
                                                    onPressed: () {
                                                      Get.defaultDialog(
                                                        title:
                                                            "${localizations.deleteConfirmationPart21} ${chatcontroller.contacts[index].name}${localizations.deleteConfirmationPart22}",
                                                        middleText: "",
                                                        titlePadding:
                                                            EdgeInsets.only(
                                                                top: h * .04),
                                                        // textConfirm: "Yes",
                                                        // textCancel: "Ignore",
                                                        titleStyle: TextStyle(
                                                            color: ColorsPlatte()
                                                                .secondary
                                                                .blackBoldText,
                                                            fontSize: (16 /
                                                                    baseWidth) *
                                                                w,
                                                            fontFamily:
                                                                "Roboto-Medium"),
                                                        actions: [
                                                          SizedBox(
                                                            width: w * .27,
                                                            child:
                                                                OutlinedButton(
                                                              onPressed: () {
                                                                Get.back();
                                                              },
                                                              style:
                                                                  OutlinedButton
                                                                      .styleFrom(
                                                                side: BorderSide(
                                                                    color: ColorsPlatte()
                                                                        .primary
                                                                        .redIcons),
                                                                // Red border
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                localizations
                                                                    .ignore,
                                                                style:
                                                                    TextStyle(
                                                                  fontFamily:
                                                                      "Roboto-Regular",
                                                                  fontSize: (16 /
                                                                          baseWidth) *
                                                                      w,
                                                                  color: ColorsPlatte()
                                                                      .primary
                                                                      .redIcons,
                                                                ), // Red text
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width: (12 /
                                                                      baseWidth) *
                                                                  w),
                                                          // Space between buttons

                                                          SizedBox(
                                                            width: w * .27,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                Get.back();
                                                                chatcontroller.deleteContact(
                                                                    localizations,
                                                                    chatcontroller
                                                                        .contacts[
                                                                            index]
                                                                        .id,
                                                                    user_token
                                                                        .value);
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    ColorsPlatte()
                                                                        .primary
                                                                        .redIcons,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              100),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                localizations
                                                                    .yes,
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .white,
                                                                    fontFamily:
                                                                        "Roboto-Regular",
                                                                    fontSize:
                                                                        (16 / baseWidth) *
                                                                            w),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      );

                                                      Slidable.of(cont)!
                                                          .close();
                                                    },
                                                    style: ElevatedButton
                                                        .styleFrom(
                                                      shape: CircleBorder(),
                                                      backgroundColor: delete,
                                                      padding:
                                                          EdgeInsets.all(2),
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
                                            onLongPress: () {
                                              // setState(() {
                                              //   isSelectionMode = true;
                                              //   // selectedContacts.add(
                                              //   //     chatcontroller
                                              //   //         .contacts[index]);
                                              //   chatcontroller.select(
                                              //       chatcontroller
                                              //           .contacts[index]);
                                              // });
                                            },

                                            onTap: () async {
                                              // if (isSelectionMode) {
                                              //   setState(() {
                                              //     if (chatcontroller
                                              //         .contacts[index]
                                              //         .isSelected) {
                                              //       selectedContacts.remove(
                                              //           chatcontroller
                                              //               .contacts[index]);
                                              //       chatcontroller.unSelect(
                                              //           chatcontroller
                                              //               .contacts[index]);
                                              //       // selectedContacts.add(controller.contacts[index]);
                                              //       // controller.select(controller.contacts[index]);
                                              //     } else {
                                              //       selectedContacts.add(
                                              //           chatcontroller
                                              //               .contacts[index]);
                                              //       chatcontroller.select(
                                              //           chatcontroller
                                              //               .contacts[index]);
                                              //     }
                                              //
                                              //     if (selectedContacts
                                              //         .isEmpty) {
                                              //       isSelectionMode = false;
                                              //       selectedContacts = [];
                                              //     }
                                              //   });
                                              // }
                                              //else
                                              {
                                                Get.find<MessagesController>()
                                                    .getMessages(
                                                        chatcontroller
                                                            .contacts[index],
                                                        user_token.value);
                                                Get.to(Chat(
                                                    person: chatcontroller
                                                        .contacts[index],
                                                    isMask: chatcontroller
                                                                .contacts[index]
                                                                .isMasked ==
                                                            '1'
                                                        ? true
                                                        : false,
                                                    // chatcontroller
                                                    //     .contacts[index]
                                                    //     .talkingAnonymous,
                                                    contact: chatcontroller
                                                        .contacts[index],
                                                    userModel: fetchedUser));
                                              }
                                            },

                                            title: Row(
                                              children: [
                                                // isSelectionMode
                                                //     ? Checkbox(
                                                //         shape:
                                                //             const CircleBorder(),
                                                //
                                                //         side: BorderSide(
                                                //             color: chatcontroller
                                                //                     .contacts[
                                                //                         index]
                                                //                     .isSelected
                                                //                 ? redIcons
                                                //                 : divider),
                                                //         //fillColor: MaterialStateProperty.resolveWith((states) =>  redIcons),
                                                //         activeColor: redIcons,
                                                //         value: chatcontroller
                                                //             .contacts[index]
                                                //             .isSelected,
                                                //         onChanged:
                                                //             (bool? value) {
                                                //           setState(() {
                                                //             if (value!) {
                                                //               selectedContacts.add(
                                                //                   chatcontroller
                                                //                           .contacts[
                                                //                       index]);
                                                //               chatcontroller.select(
                                                //                   chatcontroller
                                                //                           .contacts[
                                                //                       index]);
                                                //             } else {
                                                //               selectedContacts.remove(
                                                //                   chatcontroller
                                                //                           .contacts[
                                                //                       index]);
                                                //               chatcontroller.unSelect(
                                                //                   chatcontroller
                                                //                           .contacts[
                                                //                       index]);
                                                //             }
                                                //
                                                //             if (selectedContacts
                                                //                 .isEmpty) {
                                                //               isSelectionMode =
                                                //                   false;
                                                //               selectedContacts =
                                                //                   [];
                                                //             }
                                                //           });
                                                //         },
                                                //       )
                                                //     : SizedBox(),
                                                Container(
                                                  width: 45,
                                                  height: 45,
                                                  decoration:
                                                      const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Image.asset(
                                                      chatcontroller
                                                          .contacts[index]
                                                          .image),
                                                ),
                                                SizedBox(
                                                  width: (15 / baseWidth) * w,
                                                ),
                                                Text(
                                                    chatcontroller
                                                                .contacts[index]
                                                                .isMasked ==
                                                            '1'
                                                        ? localizations
                                                            .anonymous
                                                        : chatcontroller
                                                            .contacts[index]
                                                            .name,
                                                    style: TextStyle(
                                                      fontFamily:
                                                          'Roboto-Regular',
                                                      color: contactName,
                                                      fontSize:
                                                          (15 / baseWidth) * w,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontStyle:
                                                          FontStyle.normal,
                                                    )),
                                              ],
                                            ),
                                            // title:
                                            trailing: chatcontroller
                                                    .contacts[index].closed
                                                ? Icon(
                                                    Icons.star,
                                                    color: star,
                                                  )
                                                : SizedBox(),
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: h * .01,
                                      ),
                                      Container(
                                          margin: EdgeInsets.only(
                                              right: locale.languageCode == 'ar'
                                                  ? 0
                                                  : w * .08,
                                              left: locale.languageCode == 'ar'
                                                  ? w * .08
                                                  : 0),
                                          height: 1,
                                          decoration: new BoxDecoration(
                                              color: divider)),
                                      //SizedBox(height: h*.02,),
                                    ]);
                                  })
                              : Center(
                                  child: Text(
                                    localizations
                                        .noChatsAvailable, //need to edit
                                    style: TextStyle(
                                      fontSize: (18 / baseWidth) * w,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                    )

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
        });
  }
}
