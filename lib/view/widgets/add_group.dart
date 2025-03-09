import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../screens/home/groups/create_group.dart';

class AddGroup extends StatelessWidget {
  const AddGroup({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: (){
        //Get.find<GroupController>().fetchContacts();
        Get.to(()=>CreateGroup());
      //  Get.to(const AddGroupParticipants());
      },
      child: const Icon(Icons.add,color: Colors.white,),

    );
  }
}
