

import 'dart:developer';

import 'package:Whatsback/controller/api/auth/auth_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../../model/contacts.dart';
import '../../../model/retrieve_contact.dart';
import '../auth/auth_service.dart';
import 'chat_service.dart';
int currentId = 1;

class ChatsController extends GetxController {
 final ChatService _chatService = ChatService();
 var chatLoading = false.obs;

 var createChatloading = false.obs;
 late ChatContact savedChatPerson;
 List<ChatContact> contacts =  [
  // ChatContacts(
  //     id: 1,name: "Tasneem", image: "assets/images/Oval.png", closed: false,
  //     numOfMessage: "0",tag: "t",isSelected: false),
  // ChatContacts(name: "Armen R. Kane", image: "assets/images/Oval2.png", closed: false,
  //     numOfMessage: "0",tag: "A",id: 2,isSelected: false),
  // ChatContacts(name: "Tasneem Elattar", image: "assets/images/Oval3.png", closed: false,
  //     numOfMessage: "0",tag: "T",id: 3,isSelected: false),
  // ChatContacts(name: "Tasneem Elattar", image: "assets/images/mask.png", closed: false,
  //     numOfMessage: "0",tag: "T",id: 3,isSelected: false,talkingAnonymous: true),
  // ChatContacts(name: "Catt Corby", image: "assets/images/Oval5.png", closed: true,
  //     numOfMessage: "0",tag: "C",id: 4,isSelected: false),
  //
  // ChatContacts(name: "batt Corby", image: "assets/images/Oval.png", closed: true,
  //     numOfMessage: "0",tag: "B",id:5,isSelected: false),
  // ChatContacts(name: "batt Corby", image: "assets/images/Oval3.png", closed: true,
  //     numOfMessage: "0",tag: "B",id:6, isSelected: false),
  // ChatContacts(name: "Catt Corby", image: "assets/images/Oval2.png", closed: true,
  //     numOfMessage: "0",tag: "C",id: 7,isSelected: false),

 ];
 void onInit() {
  super.onInit();
  log("in on init");
  fetchChats(user_token.value);

 }
 Future<void> fetchChats(String token) async {
  log("in chat controller");
  try {
   chatLoading.value = true; // Start loading
   contacts = await _chatService.getChats(token);
  } catch (e) {
   print("Error fetching chats: $e");
  } finally {
   chatLoading.value = false; // Stop loading
  }
  update();
 }

 Future<void> createChat(localizations,String token,ContactModel contact,int groupValue) async {
  try {
   createChatloading.value = true;
   String statusCode = await ChatService.createChat(contact, token, groupValue);
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
   createChatloading.value = false; // Stop loading
  }
 }

 List<String>  names = ["s","a"];
 void sorting (){
  contacts.sort((a, b) => a.name.compareTo(b.name));
  update();
 }
 Future<void> deleteContact(localizations,int id, String token) async {
  bool success = await ChatService.deleteChat(id, token);

  if (success) {
   int index = contacts.indexWhere((contact) => contact.id == id);
   if (index != -1) {
    contacts.removeAt(index);
    update(); // Notify UI
   }

   SnackBarErrorWidget(localizations, localizations.chatDeletedSuccessfully,error: false);
  } else {
   SnackBarErrorWidget(localizations, localizations.failedToDeleteChat);
  }
 }



 toggleClosed(int id){
  int index = contacts.indexWhere((contact) => contact.id == id);
  if (index != -1) {
   contacts[index].closed = !contacts[index].closed;
   update();
  }
 }
 select(ChatContact contact){
  contact.isSelected = true;
  update();

 }
 unSelect(ChatContact contact){
  contact.isSelected = false;
  update();

 }
addContact(ChatContact contact,{bool asMask=false}){
  contacts.add(contact);
  update();
}

saveChatPerson(ChatContact con){
  savedChatPerson = con;
  update();

}


 }