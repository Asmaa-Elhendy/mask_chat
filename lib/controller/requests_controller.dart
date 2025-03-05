import 'package:get/get.dart';
import 'package:Whatsback/model/contacts.dart';

class RequestsController extends GetxController{
  List<ChatContact> requests = [

      ChatContact(isSelected: false, id: 1,userId: '0',contactId: '0',isMasked: '0', tag: "tag", name: "01274144578", image: "assets/images/profile.png", closed: false, numOfMessage: "5"),
    ChatContact(isSelected: false, id: 2,userId: '0',contactId: '0',isMasked: '0', tag: "tag", name: "01274144578", image: "assets/images/profile.png", closed: false, numOfMessage: "0"),


  ];
  deleteRequest(int id){
    int index = requests.indexWhere((req) => req.id == id);
    // If the contact exists, remove it from the list
    if (index != -1) {
      requests.removeAt(index);
      update();
    }

  }




}