



import 'package:Whatsback/controller/api/messages/message_service.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:Whatsback/model/contacts.dart';
import 'package:Whatsback/model/gtroup.dart';

import '../../../model/messages.dart';
import '../../../model/retrieve_contact.dart';
import '../auth/auth_controller.dart';

class MessagesController extends GetxController{
  late ChatContact chatPerson;
  late Group chatGroup ;
  var createChatloading = false.obs;
  var groupLoading = false.obs;
  final MessageService _messageService = MessageService();
  var loading = false.obs;
  List<Messages> messages = [];
  List<Messages> groupMessages = [];

  getMessages (ChatContact contact, String token,{bool mask=false})async{
    chatPerson = contact;
    // List<Messages> allMessages = [
    //   Messages( message: "Hi!!", isRead: true, sender: contact, time: "Feb 08,3.10 pm"),
    //   Messages(message: "hi", isRead: false, sender: ChatContact(
    //       isSelected: false, id: -1, tag: "tag", userId: '0',contactId: '0',isMasked: '0',
    //       name: "name", image: "image", closed: false, numOfMessage: "numOfMessage"), time: "Feb 08, 4.30 pm")
    // ];
   // messages =mask?[]:allMessages;
    try {
      loading.value = true; // Start loading
      List<Messages> chatMessages = await _messageService.getChatMesssages(token,contact.id.toString());
      messages=chatMessages;
    } catch (e) {
      print("Error fetching chat messages: $e");
    } finally {
      loading.value = false; // Stop loading
    }

    update();

  }
  getGroupMessages (String token,String groupId)async{

    try {
      groupLoading.value = true; // Start loading
      List<Messages> futureGroupMessages = await _messageService.getGroupMesssages(token,groupId);
      groupMessages=futureGroupMessages;
    } catch (e) {
      print("Error fetching group messages: $e");
    } finally {
      groupLoading.value = false; // Stop loading
    }

    update();

  }
  // getGroupMessage(Group group){
  //   chatGroup = group;
  //   List<Messages> allMessages = [
  //     // Messages(messageType: Type.text, message: "Hi!!", isRead: true, sender: group.groupContacts[0], time: "Feb 08,3.10 pm"),
  //     // Messages( messageType: Type.text,message: "new group", isRead: true, sender: group.groupContacts[1], time: "Feb 08,3.10 pm"),
  //     // Messages(messageType: Type.text,message: "hi", isRead: false, sender: Contacts(isSelected: false, id: -1, tag: "tag", name: "owner", image: "image", closed: false, numOfMessage: "numOfMessage"), time: "Feb 08, 4.30 pm")
  //   ];
  //   messages = allMessages;
  //   update();
  //
  // }
  // addMessage(Messages message){
  //   // message.sender.id=-1;
  //   // message.sender.name="me";
  //   messages.add(message);
  //   update();
  // }

  Future<void> createMessage(localizations,ChatContact contact,String token,String message) async {
    try {
   //   createChatloading.value = true;
      String statusCode = await _messageService.sendChatMessage(contact, token, message);
      if (statusCode=='201') {
      //  SnackBarErrorWidget(localizations, localizations.messageSentSuccessfully,error: false);
        getMessages(contact, token);
      }
      else {
     //   SnackBarErrorWidget(localizations, localizations.failedTosendMessage);
      }
    } catch (e) {
  //    SnackBarErrorWidget(localizations,localizations.somethingWentWrong);
    }finally {
  //    createChatloading.value = false; // Stop loading
    //  update();
    }
  }
}
