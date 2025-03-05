



import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:Whatsback/model/contacts.dart';
import 'package:Whatsback/model/gtroup.dart';

import '../model/messages.dart';

class MessagesController extends GetxController{
  late ChatContact chatPerson;
  late Group chatGroup ;

  List<Messages> messages = [];

  getMessages (ChatContact contact, {bool mask=false}){
    chatPerson = contact;
    List<Messages> allMessages = [
      Messages( messageType: Type.text,message: "Hi!!", isRead: true, sender: contact, time: "Feb 08,3.10 pm"),
      Messages(messageType: Type.text,message: "hi", isRead: false, sender: ChatContact(
          isSelected: false, id: -1, tag: "tag", userId: '0',contactId: '0',isMasked: '0',
          name: "name", image: "image", closed: false, numOfMessage: "numOfMessage"), time: "Feb 08, 4.30 pm")
    ];
    messages =mask?[]:allMessages;
    update();

  }
  getGroupMessage(Group group){
    chatGroup = group;
    List<Messages> allMessages = [
      // Messages(messageType: Type.text, message: "Hi!!", isRead: true, sender: group.groupContacts[0], time: "Feb 08,3.10 pm"),
      // Messages( messageType: Type.text,message: "new group", isRead: true, sender: group.groupContacts[1], time: "Feb 08,3.10 pm"),
      // Messages(messageType: Type.text,message: "hi", isRead: false, sender: Contacts(isSelected: false, id: -1, tag: "tag", name: "owner", image: "image", closed: false, numOfMessage: "numOfMessage"), time: "Feb 08, 4.30 pm")
    ];
    messages = allMessages;
    update();

  }
  addMessage(Messages message){
    message.sender.id=-1;
    message.sender.name="me";
    messages.add(message);
    update();
  }

}
