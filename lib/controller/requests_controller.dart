import 'package:get/get.dart';
import 'package:Whatsback/model/contacts.dart';

class RequestsController extends GetxController{
  List<Contacts> requests = [

      Contacts(isSelected: false, id: 1, tag: "tag", name: "01274144578", image: "assets/images/profile.png", closed: false, numOfMessage: "5"),
    Contacts(isSelected: false, id: 2, tag: "tag", name: "01274144578", image: "assets/images/profile.png", closed: false, numOfMessage: "0"),


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