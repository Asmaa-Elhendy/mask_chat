import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:contacts_service/contacts_service.dart';
class ChatContact  extends ISuspensionBean {
  int id;
  String name;
  String userId;//me
  String contactId;
  String isMasked; //0 1
String image;
String numOfMessage;
bool closed;
Contact? contact;
final String tag;
bool isSelected;
bool needInvite;
bool talkingAnonymous;


  ChatContact({this.talkingAnonymous=false,this.needInvite=false,required this.userId,required this.isMasked,required this.contactId,required this.isSelected,this.contact,required this.id,required this.tag,required this.name,required this.image,required this.closed,required this.numOfMessage});

  @override
  String getSuspensionTag() {
    // TODO: implement getSuspensionTag
    return tag;
  }

  // Convert JSON to Contacts instance

  factory ChatContact.fromJson(Map<String, dynamic> json) {
    return ChatContact(
      id: json['id'] as int,
      name: json['contact']?['name'] ?? '', // Extract name from contact
      image:json['is_masked']==1?'assets/images/faces.png' :'assets/images/profile.png', // Placeholder image
      numOfMessage: '0', // Default value
      closed: false, // Default value
      tag: '', // Default value
      isSelected: false, // Default value
      needInvite: false, // Default value
      talkingAnonymous: false, // Default value
      contact: json['contact'] != null ? Contact() : null, // Placeholder
      userId: json['user_id'].toString(), // Convert int to String
      contactId: json['contact_id'].toString(), // Convert int to String
      isMasked: json['is_masked'].toString(), // Convert int to String
    );
  }

}



