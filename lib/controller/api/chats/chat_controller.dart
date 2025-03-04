import 'dart:io';

import 'package:Whatsback/controller/api/auth/auth_controller.dart';
import 'package:Whatsback/controller/api/chats/chat_service.dart';
import 'package:Whatsback/model/retrieve_contact.dart';
import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';


class ChatController extends GetxController {
  var loading = false.obs; // Observable loading state


  void onInit() {
    super.onInit();

  }


  Future<void> createChat(localizations,String token,ContactModel contact) async {
    try {
      loading.value = true;
      String statusCode = await ChatService.createChat(contact, token);
      if (statusCode=='201') {
        SnackBarErrorWidget(localizations, localizations.chatCreatedSuccessfully,error: false);
      } else  if (statusCode=='200') {
        SnackBarErrorWidget(localizations, localizations.chatAlreadyExist);
      }
      else {
        SnackBarErrorWidget(localizations, localizations.failedToCreateChat);
      }
    } catch (e) {
      SnackBarErrorWidget(localizations,localizations.somethingWentWrong);
    }finally {
      loading.value = false; // Stop loading
    }
  }


}