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
  ChatContact sender;
  final String time;
  final bool isRead;
   var message;
   bool file;

  Messages({this.file=false,required this.message,required this.isRead,required this.sender,required this.time});

  // Convert JSON to Messages instance

factory Messages.fromJson(Map<String, dynamic> json) {
  return Messages(
  //  messageType: json['message_type'] as String? ?? 'text', // Default to 'text'
    sender: ChatContact.fromJson(json['sender']),
    time: json['time'] as String? ?? '',
    isRead: json['is_read'] as bool? ?? false,
    message: json['message'],
    file: json['file'] as bool? ?? false,
  );
}

}