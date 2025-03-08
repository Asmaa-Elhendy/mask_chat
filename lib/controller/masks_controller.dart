import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:get/get.dart';
import 'package:Whatsback/const/colors.dart';
import 'package:Whatsback/model/category_mask.dart';
import 'package:Whatsback/controller/assets.dart';
import 'package:Whatsback/model/contacts.dart';


class ClassController extends GetxController {

  List<Contact> contacts = [];
  List<ChatContact> azItems = [];
  int idCounter = 1;

  bool workWithChat=true;


  Class selectedMask = Class(
    id: 0,
    name: 'contacts'.tr,
    contacts: [],
    contactsNum: 0,
    icon: Assets.getGeneralMask(),
    image: "",
    selected: false,
    mainColor: ColorsPlatte().primary.redIcons,
    secondColor: ColorsPlatte().primary.pinkShade,);

  List<Class> masks = [

    Class(
      id: 1,
      contacts: [],
      contactsNum: 0,
      name: 'closed_friend'.tr,
      icon: Assets.getGeneralMask(),
      image: Assets.getClosedFriend(),
      selected: false,
      mainColor: ColorsPlatte().primary.redIcons,
      secondColor: ColorsPlatte().primary.pinkShade,
    ),
    Class(
      id: 2,
      name: 'friends'.tr,
      contacts: [],
      contactsNum: 0,
      icon: Assets.getGeneralMask(),
      image: Assets.getFriend(),
      selected: false,
      mainColor: ColorsPlatte().secondary.yellowShade,
      secondColor: ColorsPlatte().secondary.orangeShadeLight,

    ),

    Class(
      id: 3,
      contacts: [
        ChatContact(status:'',
            id: 5,
            name: "Tasneem Elattar",
            image: "assets/images/Oval2.png",
            closed: false,
            numOfMessage: "0",
            tag: "t",
            isSelected: false,userId: '0',contactId: '0',isMasked: '0'),
        ChatContact(status:'',name: "Armen R. Kane",
            image: "assets/images/Oval.png",
            closed: false,
            numOfMessage: "0",
            tag: "A",
            id: 2,
            isSelected: false,userId: '0',contactId: '0',isMasked: '0'),
        ChatContact(status:'',name: "Tasneem Elattar",
            image: "assets/images/Oval4.png",
            closed: false,
            numOfMessage: "0",
            tag: "T",
            id: 3,
            isSelected: false,userId: '0',contactId: '0',isMasked: '0'),
        ChatContact(status:'',name: "Catt Corby",
            image: "assets/images/Oval3.png",
            closed: true,
            numOfMessage: "0",
            tag: "C",
            id: 4,
            isSelected: false,userId: '0',contactId: '0',isMasked: '0'),

        ChatContact(status:'',name: "batt Corby",
            image: "assets/images/Oval5.png",
            closed: true,
            numOfMessage: "0",
            tag: "B",
            id: 5,
            isSelected: false,userId: '0',contactId: '0',isMasked: '0'),
        ChatContact(status:'',name: "batt Corby",
            image: "assets/images/Oval2.png",
            closed: true,
            numOfMessage: "0",
            tag: "B",
            id: 6,
            isSelected: false,userId: '0',contactId: '0',isMasked: '0'),
        ChatContact(status:'',name: "Catt Corby",
            image: "assets/images/Oval.png",
            closed: true,
            numOfMessage: "0",
            tag: "C",
            id: 7,
            isSelected: false,userId: '0',contactId: '0',isMasked: '0'),
      ],
      contactsNum: 0,
      name: 'workmates'.tr,
      icon: Assets.getGeneralMask(),
      image: Assets.getWorkmates(),
      selected: false,
      mainColor: ColorsPlatte().secondary.blueShadeBold,
      secondColor: ColorsPlatte().secondary.blueShadeLight,
    ),

    Class(
      id: 4,
      name:  'family'.tr,
      contacts: [],
      contactsNum: 0,
      icon: Assets.getGeneralMask(),
      image: Assets.getFamily(),
      selected: false,

      mainColor: ColorsPlatte().secondary.greenShadeBold,
      secondColor: ColorsPlatte().secondary.greenShadeLight,
    ),

  ];
  // List<Contacts> people = [
  //   Contacts(
  //       id: 5,
  //       name: "Tasneem Elattar",
  //       image: "assets/images/profile.png",
  //       closed: false,
  //       numOfMessage: "0",
  //       tag: "t",
  //       isSelected: false),
  //   Contacts(name: "Armen R. Kane",
  //       image: "assets/images/profile.png",
  //       closed: false,
  //       numOfMessage: "0",
  //       tag: "A",
  //       id: 2,
  //       isSelected: false),
  //   Contacts(name: "Tasneem Elattar",
  //       image: "assets/images/profile.png",
  //       closed: false,
  //       numOfMessage: "0",
  //       tag: "T",
  //       id: 3,
  //       isSelected: false),
  //   Contacts(name: "Catt Corby",
  //       image: "assets/images/profile.png",
  //       closed: true,
  //       numOfMessage: "0",
  //       tag: "C",
  //       id: 4,
  //       isSelected: false),
  //
  //   Contacts(name: "batt Corby",
  //       image: "assets/images/profile.png",
  //       closed: true,
  //       numOfMessage: "0",
  //       tag: "B",
  //       id: 5,
  //       isSelected: false),
  //   Contacts(name: "batt Corby",
  //       image: "assets/images/profile.png",
  //       closed: true,
  //       numOfMessage: "0",
  //       tag: "B",
  //       id: 6,
  //       isSelected: false),
  //   Contacts(name: "Catt Corby",
  //       image: "assets/images/profile.png",
  //       closed: true,
  //       numOfMessage: "0",
  //       tag: "C",
  //       id: 7,
  //       isSelected: false),
  //
  // ];

  selectMask(id) {
    for (int i = 0; i < masks.length; i++) {
      if (masks[i].id == id) {
        masks[i].selected = true;
        update();
      } else {
        masks[i].selected = false;
        update();
      }
    }
  }

  setSelectedMask(Class mask) {
    selectedMask = mask;
    workWithChat = false;
    update();
  }

  deleteContact(Class classValue,int id) {
    int index = classValue.contacts.indexWhere((contact) => contact.id == id);
    // If the contact exists, remove it from the list
    if (index != -1) {
      classValue.contacts.removeAt(index);
      update();
   }
  }

 fetchContacts() async {
// Fetch phone contacts
   List<Contact> fetchedContacts =
   await ContactsService.getContacts(withThumbnails: true);

   // Convert contacts to AZItems with indices
   List<ChatContact> items = fetchedContacts.asMap().entries.map((entry) {
     int index = entry.key; // Index of the contact
     Contact contact = entry.value;
     String displayName = contact.displayName ?? "Unnamed";
     String tag = displayName[0].toUpperCase(); // First letter of the name
     print("$index $displayName\n ");
      return ChatContact(status: '',
          id:  idCounter++,userId: '0',contactId: '0',isMasked: '0',
          name: displayName,
          tag: RegExp(r'[A-Z]').hasMatch(tag) ? tag : "#",
          closed: false,
          image:idCounter%2==0?"assets/images/Oval2.png":
              idCounter%3==0?"assets/images/Oval3.png":idCounter%5==0?"assets/images/Oval4.png"
              :"assets/images/Oval.png",
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
      azItems[0].image="assets/images/profile.png";
       azItems[5].image="assets/images/profile.png";
      azItems[0].needInvite=true;
   azItems[5].needInvite=true;


   update();

  }
  addContactsToClass(int classId, ChatContact contactToAdd){
    int index = masks.indexWhere((contact) => contact.id == classId);
    masks[index].contacts.add(contactToAdd);
    update();

  }

}