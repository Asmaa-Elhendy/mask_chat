import 'package:Whatsback/controller/api/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:Whatsback/view/screens/home/groups/group_Chat.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../const/colors.dart';
import '../../../../const/sizes.dart';
import '../../../../controller/api/groups/groups_controller.dart';
import '../../../../controller/api/messages/messages_controller.dart';
import '../../../../model/user_model.dart';
import '../../../widgets/add_group.dart';

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  UserModel? fetchedUser;
  getUser() async {
    final AuthService _userApiService = AuthService();
    fetchedUser = await _userApiService.fetchUser(user_token.value);
    setState(() {});
    print('here' + fetchedUser!.name);
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }
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
            padding: EdgeInsets.only(top: h * .034, left: w * .039, right: w * .05),
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
                    )),
                const AddGroup()
              ],
            ),
          ),
          SizedBox(height: h * .03),
          Container(
            padding: EdgeInsets.only(left: w * .035, right: w * .035, bottom: (13 / baseHeight) * h, top: (13 / baseHeight) * h),
            width: w,
            height: h * .74,//edit groups height
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(35)),
            child: GetBuilder<GroupController>(
                init: GroupController(),

                builder: (controller) {
                  if (controller.loading==true) {
                    return Center(child: CircularProgressIndicator(color: redCheck,));
                  }
                  if (controller.groupsList.isEmpty) {
                    return Center(
                      child: Text(
                        localizations.noGroupsAvailable,
                        style: TextStyle(
                          fontSize: (18 / baseWidth) * w,
                          color: Colors.grey,
                        ),
                      ),
                    );
                  }
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: controller.groupsList.length,
                      itemBuilder: (context, index) {
                        return Column(children: [
                          SizedBox(height: h * .01),
                          Container(
                            margin: EdgeInsets.only(right: w * .1),
                            child: Slidable(
                              direction: Axis.horizontal,
                              key: ValueKey(controller.groupsList[index].id),
                              endActionPane: ActionPane(
                                motion: ScrollMotion(),
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
                                          controller.deleteGroup(localizations,controller.groupsList[index].id);
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
                                ],
                              ),
                              child: ListTile(
                                onTap: () {
                                  Get.find<MessagesController>().getGroupMessages(user_token.value,controller.groupsList[index].id.toString());
                                  Get.to(()=>GroupChat(current_group:controller.groupsList[index],userModel: fetchedUser,),);
                                },
                                leading: Container(
                                  width: 45,
                                  height: 45,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      scale: 1.5,
                                      image: controller.groupsList[index].image is String
                                          ? AssetImage(controller.groupsList[index].image == "" ? "assets/images/categories/Closed friend.png" : controller.groupsList[index].image)
                                          : FileImage(controller.groupsList[index].image, scale: 1.5),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                title: Text(controller.groupsList[index].subject,
                                    style: TextStyle(
                                      fontFamily: 'Roboto-Regular',
                                      color: contactName,
                                      fontSize: (15 / baseWidth) * w,
                                      fontWeight: FontWeight.w400,
                                    )),
                                trailing: controller.groupsList[index].fav ? Icon(Icons.star, color: star) : SizedBox(),
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                          SizedBox(height: h * .01),
                          Container(
                              margin: EdgeInsets.only(right: w * .1),
                              height: 1,
                              decoration: BoxDecoration(color: divider)),
                        ]);
                      });
                }),
          )
        ],
      ),
    );
  }
}
