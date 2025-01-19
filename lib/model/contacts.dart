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
}



