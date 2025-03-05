import 'package:Whatsback/controller/requests_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';


import 'api/chats/chats_controller.dart';
import 'api/groups/groups_controller.dart';
import 'language.dart';
import 'masks_controller.dart';
import 'api/messages/messages_controller.dart';

class MyBinding implements  Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ChatsController(),fenix: true);
    Get.lazyPut(() => MessagesController(),fenix: true);
    Get.lazyPut(() => ClassController(),fenix: true);
    Get.lazyPut(() => GroupController(),fenix: true);
    Get.lazyPut(() => RequestsController(),fenix: true);
    //Get.put(() => LanguageController(),);


  }

}