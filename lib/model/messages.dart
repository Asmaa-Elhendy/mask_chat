import 'contacts.dart';

enum Type{
  text,
  image,
  document,
  audio,
  contact,location,
  voiceNote,

}

class Messages {
Type messageType;
  Contacts sender;
  final String time;
  final bool isRead;
   var message;
   bool file;
  Messages({required this.messageType,this.file=false,required this.message,required this.isRead,required this.sender,required this.time});


}