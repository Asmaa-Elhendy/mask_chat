import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/controller/groups_controller.dart';

import '../screens/home/groups/add_group_participants.dart';

class AddGroup extends StatelessWidget {
  const AddGroup({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        Get.find<GroupController>().fetchContacts();
        Get.to(const AddGroupParticipants());
      },
      child: const Icon(Icons.add,color: Colors.white,),

    );
  }
}
