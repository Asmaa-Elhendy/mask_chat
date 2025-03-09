import 'dart:developer';

import 'package:get/get.dart';
import 'package:Whatsback/model/contacts.dart';

import 'api/auth/auth_service.dart';
import 'api/chats/chat_service.dart';

class RequestsController extends GetxController{
  final ChatService _chatService = ChatService();
  var loading = false.obs;
  List<ChatContact> requests = [

    //   ChatContact(isSelected: false, id: 1,userId: '0',contactId: '0',isMasked: '0', tag: "tag", name: "01274144578", image: "assets/images/profile.png", closed: false, numOfMessage: "5"),
    // ChatContact(isSelected: false, id: 2,userId: '0',contactId: '0',isMasked: '0', tag: "tag", name: "01274144578", image: "assets/images/profile.png", closed: false, numOfMessage: "0"),


  ];
  void onInit() {
    super.onInit();
    log("in on init");
    fetchChatsRequests(user_token.value);

  }
  Future<void> fetchChatsRequests(String token) async {

    log("in request controller");
    try {
      loading.value = true; // Start loading
      List<ChatContact>  allChats = await _chatService.getChats(token);
      allChats.forEach((ChatContact contact){

        if(contact.status=='pending'){
          requests.add(contact);
          log(contact.id.toString());
        }
      });
      log('new requests');

    } catch (e) {
      print("Error fetching chats: $e");
    } finally {
      loading.value = false; // Stop loading
    }
    update();
  }

  deleteRequest(int id){
    int index = requests.indexWhere((req) => req.id == id);
    // If the contact exists, remove it from the list
    if (index != -1) {
      requests.removeAt(index);
      update();
    }

  }




}