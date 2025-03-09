
import 'package:Whatsback/model/contacts.dart';
import 'package:Whatsback/model/messages.dart';

class Group{
  int  id;
String subject;
bool fav;
List<ChatContact> groupContacts;
var image;
// List<Messages> groupMessgaes;

Group({required this.fav,required this.id,required this.image,required this.groupContacts,required this.subject});



}