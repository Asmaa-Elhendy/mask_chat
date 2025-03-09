import 'package:intl/intl.dart';

import 'contacts.dart';

// enum Type{   //handle in second version ,need storage
//   text,
//   image,
//   document,
//   audio,
//   contact,location,
//   voiceNote,
//
// }

class Messages {
// String messageType;
 // ChatContact sender;
  String senderId;
  String senderName;
  final String time;
  final bool isRead;
   var message;
   bool file;
   String is_masked;
  Messages({this.file=false,required this.message,required this.isRead,required this.senderId,required this.senderName,required this.time,this.is_masked='0'});

  // Convert JSON to Messages instance

factory Messages.fromJson(Map<String, dynamic> json) {

  String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss').format(
      DateTime.parse(json['created_at'])
  );


  return Messages(
  //  messageType: json['message_type'] as String? ?? 'text', // Default to 'text'
    senderId: json['sender_id'].toString(),
    senderName: json['group_id']==null?'':json['sender_name'],
    time:formattedDate as String? ?? '',
    isRead: false,
    message: json['message'],
    file: false,
    is_masked: json['is_masked'].toString()
  );
}

}