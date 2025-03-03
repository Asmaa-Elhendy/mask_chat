import 'dart:io';

import 'package:Whatsback/controller/api/auth/auth_controller.dart';
import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';

import '../model/contacts.dart';
import '../model/gtroup.dart';
import '../model/messages.dart';
import 'api/auth/auth_service.dart';
import 'api/groups/group_service.dart';

class GroupController extends GetxController {
  var loading = false.obs; // Observable loading state
  List<Contact> contacts = [];
  List<Contacts> azItems = [];
  int idCounter = 1;
  List<Contacts> selectedContactsAddtoGroup=[];
  // List<Group> groupsList = [
  //   Group(
  //       id: 0,
  //       fav: false,
  //       image: "",
  //       groupContacts: [
  //         Contacts(
  //             id: 5,
  //             name: "Tasneem Elattar",
  //             image: "assets/images/profile.png",
  //             closed: false,
  //             numOfMessage: "0",
  //             tag: "t",
  //             isSelected: false),
  //         Contacts(name: "Armen R. Kane",
  //             image: "assets/images/profile.png",
  //             closed: false,
  //             numOfMessage: "0",
  //             tag: "A",
  //             id: 2,
  //             isSelected: false),
  //       ],
  //
  //       subject: "New Group For Test")
  // ];
  List<Group> groupsList=[];
  final GroupService _groupService = GroupService();
  void onInit() {
    super.onInit();
    fetchGroups(user_token.value);
  }

  Future<void> fetchGroups(String token) async {
    try {
      loading.value = true; // Start loading
      groupsList = await _groupService.fetchGroups(token);
    } catch (e) {
      print("Error fetching groups: $e");
    } finally {
      loading.value = false; // Stop loading
    }
    update();
  }

  toggleClosed(int id) {
    int index = groupsList.indexWhere((contact) => contact.id == id);
    if (index != -1) {
      groupsList[index].fav = !groupsList[index].fav;
      update();
    }
  }
  Future<void> deleteGroup(localizations,int id) async {
    try {
      bool isDeleted = await GroupService.deleteGroup(id,user_token.value);
      if (isDeleted) {
        int index = groupsList.indexWhere((group) => group.id == id);
        if (index != -1) {
          groupsList.removeAt(index);
          update(); // Notify UI
        }
      } else {
        SnackBarWidget(localizations, localizations.failedToDeleteGroupFromServer);
      }
    } catch (e) {
      SnackBarWidget(localizations,localizations.somethingWentWrong);
    }
  }

  fetchContacts() async {
selectedContactsAddtoGroup=[];
    // Fetch phone contacts
    Iterable<Contact> fetchedContacts =
    await ContactsService.getContacts(withThumbnails: true);

    // Convert contacts to AZItems
    List<Contacts> items = fetchedContacts.map((contact) {
      String displayName = contact.displayName ?? "Unnamed";
      String tag = displayName[0].toUpperCase(); // First letter of the name

      return Contacts(
        id:  idCounter++,
        name: displayName,
        tag: RegExp(r'[A-Z]').hasMatch(tag) ? tag : "#",
        closed: false,
        image: "assets/images/profile.png",
        numOfMessage: "0",
        contact: contact,
        isSelected: false,
        needInvite: false,
      );
    }).toList();

    // Sort the items by their tag
    SuspensionUtil.sortListBySuspensionTag(items);
    SuspensionUtil.setShowSuspensionStatus(items);


    contacts = fetchedContacts.toList();
    azItems = items;
    azItems[0].needInvite=true;
    azItems[5].needInvite=true;
    update();

  }
  selectContactToAdd(int id,bool add){
    int index = azItems.indexWhere((contact) => contact.id == id);

    if(add){
      selectedContactsAddtoGroup.add(azItems[index]);
      azItems[index].isSelected=true;
      update();

    }else{
      selectedContactsAddtoGroup.remove(azItems[index]);
      azItems[index].isSelected=false;

      update();
    }

  }
  addNewGroup(String name,List<Contacts> groupContacts, File? _image){

    groupsList.add(
      Group(fav: false,
          id: (groupsList[groupsList.length-1].id+1),

          image: _image??"assets/images/categories/Closed friend.png",
          groupContacts: groupContacts,
          subject: name)
    );
update();

  }

}