import 'package:azlistview_plus/azlistview_plus.dart';
import 'package:contacts_service/contacts_service.dart';
class Contacts  extends ISuspensionBean {
  int id;
  String name;
String image;
String numOfMessage;
bool closed;
Contact? contact;
final String tag;
bool isSelected;
bool needInvite;
bool talkingAnonymous;


  Contacts({this.talkingAnonymous=false,this.needInvite=false,required this.isSelected,this.contact,required this.id,required this.tag,required this.name,required this.image,required this.closed,required this.numOfMessage});

  @override
  String getSuspensionTag() {
    // TODO: implement getSuspensionTag
    return tag;
  }

  // Convert JSON to Contacts instance
  factory Contacts.fromJson(Map<String, dynamic> json) {
    return Contacts(
      id: json['id'] as int,
      name: json['name'] as String,
      image: json['image'] as String,
      numOfMessage: json['numOfMessage'] as String,
      closed: json['closed'] as bool,
      tag: json['tag'] as String,
      isSelected: json['isSelected'] as bool,
      needInvite: json['needInvite'] as bool? ?? false,
      talkingAnonymous: json['talkingAnonymous'] as bool? ?? false,
      contact: json['contact'] != null ? Contact.fromMap(json['contact']) : null,
    );
  }
}



