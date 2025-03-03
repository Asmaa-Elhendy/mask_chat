

import 'package:Whatsback/controller/api/auth/auth_controller.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../model/contacts.dart';
import 'api/chats/chat_service.dart';
int currentId = 1;

class ChatsController extends GetxController{
 late Contacts savedChatPerson;
 List<Contacts> contacts =  [
  Contacts(
      id: 1,name: "Tasneem", image: "assets/images/Oval.png", closed: false,
      numOfMessage: "0",tag: "t",isSelected: false),
  Contacts(name: "Armen R. Kane", image: "assets/images/Oval2.png", closed: false,
      numOfMessage: "0",tag: "A",id: 2,isSelected: false),
  Contacts(name: "Tasneem Elattar", image: "assets/images/Oval3.png", closed: false,
      numOfMessage: "0",tag: "T",id: 3,isSelected: false),
  Contacts(name: "Tasneem Elattar", image: "assets/images/mask.png", closed: false,
      numOfMessage: "0",tag: "T",id: 3,isSelected: false,talkingAnonymous: true),
  Contacts(name: "Catt Corby", image: "assets/images/Oval5.png", closed: true,
      numOfMessage: "0",tag: "C",id: 4,isSelected: false),

  Contacts(name: "batt Corby", image: "assets/images/Oval.png", closed: true,
      numOfMessage: "0",tag: "B",id:5,isSelected: false),
  Contacts(name: "batt Corby", image: "assets/images/Oval3.png", closed: true,
      numOfMessage: "0",tag: "B",id:6, isSelected: false),
  Contacts(name: "Catt Corby", image: "assets/images/Oval2.png", closed: true,
      numOfMessage: "0",tag: "C",id: 7,isSelected: false),

 ];
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
 select(Contacts contact){
  contact.isSelected = true;
  update();

 }
 unSelect(Contacts contact){
  contact.isSelected = false;
  update();

 }
addContact(Contacts contact,{bool asMask=false}){
  contacts.add(contact);
  update();
}

saveChatPerson(Contacts con){
  savedChatPerson = con;
  update();

}


 }