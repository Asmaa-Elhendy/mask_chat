import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:Whatsback/controller/api/auth/auth_service.dart';
import 'package:Whatsback/model/user_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart' as native_picker;
import 'package:Whatsback/controller/requests_controller.dart';
import 'package:path/path.dart' as path;
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:Whatsback/controller/api/chats/chats_controller.dart';
import 'package:Whatsback/controller/api/messages/messages_controller.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:just_audio/just_audio.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:uuid/uuid.dart';


import '../../const/colors.dart';
import '../../const/sizes.dart';
import '../../controller/assets.dart';
import '../../controller/audio_controller.dart';
import '../../controller/user_controller.dart';
import '../../model/contacts.dart';
import '../../model/messages.dart';
import '../widgets/bootom_sheet_attachment.dart';
import 'add_phone_number.dart';

class Chat extends StatefulWidget {
  ChatContact person;
  bool isMask;
  bool unKnown;
  ChatContact? contact;
  UserModel? userModel;
  bool fromChatScreen;
  Chat({this.unKnown = false,this.isMask=false,required this.person, this.contact=null,this.userModel=null,this.fromChatScreen=true});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> with TickerProviderStateMixin {
  final native_picker.FlutterNativeContactPicker _contactPicker = native_picker.FlutterNativeContactPicker();
  final ScrollController _scrollController = ScrollController();

  late TabController _tabController;
  bool file = false;
  TextEditingController _controller = TextEditingController();
  var outputFormat = DateFormat('MM.dd, hh:mm a');
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  Type? _attachment;
  File? fileDocument;
  AudioMessageController audioController = AudioMessageController();
  final record = AudioRecorder();
  final AudioPlayer voiceNitePlayer = AudioPlayer();
  bool isrecording = false;
  bool isPlaying = false;
  String? pathRecord;
  String url = '';
  startRecord()async{
    final status = await Permission.microphone.request();
    final  Directory location = await getApplicationDocumentsDirectory();//to get location path to record inside.
    final String filePath = path.join(location.path,"recording.wav");

    if(status.isGranted){
      isrecording = true;
      pathRecord =null;
      await record.start(RecordConfig(), path: filePath);
      setState(() {

      });
    }
    print("start record");
  }
  stopRecord()async{
    String?finalPath = await record.stop();
    if(finalPath!=null) {
      setState(() {
        isrecording = false;
        pathRecord = finalPath;
      });
      print("stop record");
    }
    return finalPath;
  }



  // Function to pick an image from the gallery
  // Future<void> _pickImageFromGallery() async {
  //   final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
  //   if (pickedImage != null) {
  //     print('Image selected: ${pickedImage.path}');
  //     _imageFile = pickedImage;
  //     _controller.text=pickedImage.path;
  //     file=true;
  //     _attachment = Type.image;
  //     setState(() {
  //
  //     });
  //     // Add your upload or processing logic here
  //   }
  // }

  //Function to take a photo using the camera
  // Future<void> _takePhoto() async {
  //   final XFile? photo = await _picker.pickImage(source: ImageSource.camera);
  //   if (photo != null) {
  //     print('Photo taken: ${photo.path}');
  //     _imageFile=photo;
  //     _controller.text=photo.path;
  //     file=true;
  //     _attachment = Type.image;
  //     setState(() {
  //
  //     });
  //     // Add your upload or processing logic here
  //   }
  // }

  // Function to pick a document
  // Future<void> _pickDocument() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom,
  //       allowedExtensions: ['pdf', 'doc', 'docx', 'xls', 'xlsx', 'ppt', 'txt',
  //         'zip', 'json', 'jpg', 'jpeg', 'png', 'gif', 'svg']);
  //   if (result != null) {
  //     File file = File(result.files.single.path!);
  //     fileDocument = file;
  //     _controller.text=result.files.single.path!;
  //     _attachment = Type.document;
  //     setState(() {
  //
  //     });
  //     // Add your upload or processing logic here
  //   }
  // }
  //
  // Function to pick an audio file
  // Future<void> _pickAudio() async {
  //   FilePickerResult? result = await FilePicker.platform.pickFiles(
  //     type: FileType.audio,
  //   );
  //
  //   if (result != null) {
  //     _attachment = Type.audio;
  //     String filePath = result.files.single.path!;
  //     print('Selected audio file: $filePath');
  //     _controller.text=filePath;
  //     // Send this file path in the chat or upload it to a server
  //   } else {
  //     print('No file selected');
  //   }
  // }

  // Function to get current location
  // Future<void> _getCurrentLocation() async {
  //
  //
  //   Position position = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.high);
  //   String locationUrl = 'https://www.google.com/maps?q=${position.latitude},${position.longitude}';
  //   _controller.text = locationUrl;
  //   _attachment = Type.location;
  //
  //   // Now send this `locationUrl` as a message in your chat
  //   print('Location URL: $locationUrl');
  // }
  // Future<void> openLocation(String url) async {
  //   if (await canLaunchUrl(Uri.parse(url))) {
  //     await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  //   } else {
  //     throw 'Could not open location';
  //   }
  // }

  Future<void> _pickContact() async {
    try {
      // Open the contact picker
      var  contact = (await _contactPicker.selectContact());
      _controller.text = contact.toString();

      if (contact != null) {
        // Extract contact details
        // final contactMessage = {
        //   'name': contact.displayName ?? 'Unknown Name',
        //   //'phone': contact.androidAccountType. ?? 'Unknown Number',
        // };
print(contact);
        // Print or send the contact

      }
    } catch (e) {
      print('Error picking contact: $e');
    }
    }
  // Future<void> _toggleAudio(path) async {
  //   if (audioController.isPlaying) {
  //     await audioController.stop();
  //   } else {
  //     await audioController.play(path);
  //   }
  //   setState(() {});
  // }


  @override
  void dispose() {
    audioController.dispose();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();

    audioController.audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {
          audioController.isPlaying = false;
        });
      }
    });
    _tabController = TabController(length: 2, vsync: this);
    _tabController.index=   widget.isMask?1:0;  //handle stop in which tab bar
    if(widget.isMask) {
      setState(() {
        _tabController.index = 1;
      });
    }


    }


  late UserController userController;

  @override
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;

    // final isMe=widget.userModel!.id==widget.contact!.contactId?true:false;
    log('${widget.userModel?.id}  and ${widget.contact!.id}');
    // log("isme $isMe");
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();

      },
      child: GetBuilder<MessagesController>(
          init: MessagesController(),
          builder: (controller) {
            Future.delayed(Duration(milliseconds: 100), () {
              _scrollController.animateTo(
                _scrollController.position.maxScrollExtent,
                duration: Duration(milliseconds: 300),
                curve: Curves.easeOut,
              );});
            return SingleChildScrollView(
              //physics: NeverScrollableScrollPhysics(),
              child: Container(
                  width: w,
                  height: h,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xffd42336),
                        Color(0xffed4658),
                      ],
                      stops: [0, 1],
                      end: Alignment(1.00, -0.00),
                      begin: Alignment(-1.00, 0.00),
                    ),
                  ),
                  child: Scaffold(
                      //resizeToAvoidBottomInset: true,
                  
                      backgroundColor: Colors.transparent,
                      body: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        reverse: true,
                        child: Column(children: [
                          Padding(
                              padding: EdgeInsets.only(
                                  top: h * .022,
                                  left: w * .047,
                                  right: w * .033,
                                  bottom: h * .014),
                              child: Column(children: [
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Get.back();
                                      },
                                      child: Icon(
                                        Icons.arrow_back_ios_new,
                                        color: Colors.white,
                                        size: (18 / baseWidth) * w,
                                      ),
                                    ),
                                    SizedBox(
                                      width: w * .017,
                                    ),
                                    Container(
                                        width: 35,
                                        height: 35,
                                        child:
                                            Image.asset(controller.chatPerson.image)),
                                    SizedBox(
                                      width: w * .028,
                                    ),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(widget.contact!=null?widget.isMask?localizations.anonymous:widget.contact!.name:'',
                                         // controller.chatPerson.name,
                                          style: TextStyle(
                                            fontFamily: 'Roboto-Medium',
                                            color: Colors.white,
                                            fontSize: (18 / baseWidth) * w,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.normal,
                                          ),
                                        ),
                                        // Row(
                                        //   children: [
                                        //     Text(localizations.lastSeen,
                                        //         style: TextStyle(
                                        //           fontFamily: 'Roboto-Regular',
                                        //           color: Colors.white,
                                        //           fontSize: (14 / baseWidth) * w,
                                        //           fontWeight: FontWeight.w400,
                                        //           fontStyle: FontStyle.normal,
                                        //         )),
                                        //     Text("09.20 PM",
                                        //         style: TextStyle(
                                        //           fontFamily: 'Roboto-Regular',
                                        //           color: Colors.white,
                                        //           fontSize: (14 / baseWidth) * w,
                                        //           fontWeight: FontWeight.w400,
                                        //           fontStyle: FontStyle.normal,
                                        //         )),
                                        //   ],
                                        // )
                                      ],
                                    ),
                                    Spacer(),
                                    widget.unKnown?InkWell(
                                      onTap: () {
                                        Get.off( AddPhoneNumber(unKnown: widget.person,));


                                      },
                                      child: Image.asset("assets/images/add.png"),
                                    ):SizedBox()
                                  ],
                                ),
                                SizedBox(
                                  height: h * .023,
                                ),
                                Container(
                                  height: (30 / baseHeight) * h,
                                  padding: EdgeInsets.symmetric(
                                      vertical: (2.5 / baseHeight) * h,
                                      horizontal: (4 / baseWidth) * w),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(35),
                                    color: Colors.white,
                                  ),
                                  child: TabBar(
                                    controller: _tabController,
                                    padding: EdgeInsets.zero,
                                    dividerColor: Colors.transparent,
                                    indicatorPadding: EdgeInsets.zero,
                                    labelPadding: EdgeInsets.zero,

                                    indicator:
                                        const BoxDecoration(), // Remove default underline
                                    tabs: [
                                      _buildTab(
                                        h: h,
                                        w: w,
                                        image: "assets/images/profile.png",
                                        label: localizations.regularChat,
                                        isActive: _tabController.index == 0,
                                        localizations: localizations
                                      ),
                                      _buildTab(
                                        h: h,
                                        w: w,
                                        image: "assets/images/mask.png",
                                        label: localizations.maskChat,
                                        isActive: _tabController.index == 1,
                                        localizations: localizations
                                      ),
                                    ],
                                    onTap: (index) {
                                      if(widget.fromChatScreen==true){ //handle not toggle regular or mask in chat
                                        return;
                                      }
                                      setState(() {
                                        if( _tabController.index == 1){
                                          log("in mask chat");



                                        }else{
                                          Get.off(Chat(
                                            isMask: false,
                                            person: Get.find<ChatsController>().savedChatPerson ),
                                          );
                                          Get.find<MessagesController>().getMessages(
                                              Get.find<ChatsController>().savedChatPerson,user_token.value);

                                        }

                                      }); // Update the active tab state
                                    },
                                  ),
                                )
                              ])),
                          Container(
                            padding: EdgeInsets.only(
                                top: (1 / baseHeight) * h,
                                left: w * .033,
                                right: w * .033,
                                bottom: h * .0145),
                            width: w,
                            height: h * .68,//.65 edit height
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35),
                              image: const DecorationImage(
                                image: AssetImage(
                                    'assets/images/bitmap.png'), // Replace with your image path
                                fit: BoxFit.cover,
                              ),
                            ),
                            child:controller.loading==true?Center(child: CircularProgressIndicator(color: redCheck,)):
                            ListView.builder(
                              controller: _scrollController,

                                shrinkWrap: true,
                                itemCount: controller.messages.length,
                                itemBuilder: (context, index) {
                                  final Messages currentMessage = controller.messages[index];
                                  // bool isMe = currentMessage.sender.id == -1;
                                  // if(controller.messages[index].messageType==Type.document){
                                  // //  String m = controller.messages[index].message;
                                  // //
                                  // //
                                  //
                                  //
                                  //
                                  //
                                  // }
                                  return Container(
                                    child: Column(
                                      children: [
                                        controller.messages[index].senderId!=widget.userModel?.id? //isme need to handle sender id with user id
                                       Row(
                                        //  margin: EdgeInsets.only(top: h*.065,left: w*.022),
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                              children: [
                                                Text(// need to check , here handle directions and name of sender messgae
                                                  widget.isMask?
                                                  "${localizations.anonymous}"
                                                      :
                                                (  controller.messages[index].senderId.toString()==widget.userModel?.id.toString())?
                                                      widget.userModel!.name:
                                                  widget.contact!.name,
                                                  style: TextStyle(
                                                    fontFamily:
                                                    'Roboto-Regular',
                                                    color: time,
                                                    fontSize:
                                                    (10 / baseWidth) * w,
                                                    fontWeight:
                                                    FontWeight.w400,
                                                    fontStyle:
                                                    FontStyle.normal,
                                                  ),
                                                ),
                                    //  controller.messages[index].messageType==Type.text?
                                      Container(
                                                  margin: EdgeInsets.only(left: w*.022),
                                        padding:
                                        EdgeInsets.symmetric(
                                            vertical: (10 /
                                                baseHeight) *
                                                h,
                                            horizontal: (10 /
                                                baseWidth) *
                                                w),
                                                  constraints: BoxConstraints(
                                                     maxWidth: (200 / baseWidth) * w,
                                                  //  minWidth: (50 / baseWidth) * w

                                                  ),

                                                  decoration:     controller.messages[index].senderId.toString()==widget.userModel?.id.toString()  //isme need to handle sender id with user id
                                                      ? BoxDecoration(
                                                    color:  ColorsPlatte().primary.chat,
                                                    borderRadius: const BorderRadius.only(
                                                      topLeft: Radius.circular(16),
                                                      topRight: Radius.circular(16),
                                                      bottomRight: Radius.circular(0),
                                                      // Bottom-left remains unrounded
                                                      bottomLeft: Radius.circular(16),
                                                    ),
                                                  )
                                                      : const BoxDecoration(
                                                    color: redIcons,
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(16),
                                                      topRight: Radius.circular(16),
                                                      bottomRight: Radius.circular(16),
                                                      // Bottom-left remains unrounded
                                                      bottomLeft: Radius.circular(0),
                                                    ),
                                                  ),

                                                    child: Center(
                                                      child:
                                                      Text(
                                                        softWrap: true,
                                                       // overflow: TextOverflow.visible,
                                                        controller.messages[index].message,
                                                        style: TextStyle(
                                                          fontFamily: 'Roboto-Regular',
                                                          color:     controller.messages[index].senderId.toString()==widget.userModel?.id.toString()// isme need to edit is me sender id with user id
                                                              ? blackBoldText
                                                              : Colors.white,
                                                          fontSize: (15 / baseWidth) * w,
                                                          fontWeight: FontWeight.w400,
                                                          fontStyle: FontStyle.normal,
                                                        ),
                                                      )
                                                    ),
                                                  //),
                                                )
                                      //     :controller.messages[index].messageType==Type.image?
                                      // Container(
                                      //   width: 200,
                                      //   height: 200,
                                      //   child: Image.file(File(controller.messages[index].message)),
                                      // )
                                      //     :controller.messages[index].messageType==Type.document?
                                      //
                                      //
                                      //   GestureDetector(
                                      //
                                      //       onTap: () {
                                      //         OpenFile.open(controller.messages[index].message);
                                      //       },
                                      //
                                      //     child: Container(
                                      //       margin: EdgeInsets.symmetric(horizontal: w*.1),
                                      //       // width: 50,
                                      //       // height: 50,
                                      //       color: Colors.white,
                                      //       child:Row(
                                      //         children: [
                                      //           Icon(Icons.insert_drive_file, color: Colors.blue),
                                      //           SizedBox(width: w*.014,),
                                      //           SizedBox(
                                      //             width: w*.2,
                                      //             child: Text("${path.basename(controller.messages[index].message)}",
                                      //
                                      //               overflow: TextOverflow.ellipsis,
                                      //
                                      //             ),
                                      //           )
                                      //
                                      //         ],
                                      //       )
                                      //
                                      //     ),
                                      //   )
                                      //
                                      //       :controller.messages[index].messageType==Type.location?
                                      //   TextButton(
                                      //     onPressed: () => openLocation(controller.messages[index].message),
                                      //     child: Text(localizations.shared_location_click_to_view),
                                      //   )
                                      //
                                      //       :controller.messages[index].messageType==Type.audio?
                                      //   Row(
                                      //     children: [
                                      //       IconButton(
                                      //         icon: Icon(Icons.headphones),
                                      //         onPressed: (){
                                      //           _toggleAudio(controller.messages[index].message);
                                      //
                                      //         },
                                      //       ),
                                      //       Text(localizations.audio_file),
                                      //     ],
                                      //   )
                                      //     :controller.messages[index].messageType == Type.voiceNote?
                                      //     StreamBuilder<Object>(
                                      //         stream: voiceNitePlayer.positionStream,
                                      //       builder: (context, snapshot) {
                                      //         final Object? duration = snapshot.data;
                                      //         return Container(
                                      //           margin: EdgeInsets.symmetric(horizontal: w*.1),
                                      //           child: GestureDetector(
                                      //               onTap: ()async{
                                      //                 if(voiceNitePlayer.playing){
                                      //                   voiceNitePlayer.stop();
                                      //                   setState(() {
                                      //                     isPlaying == false;
                                      //                   });
                                      //
                                      //                 }else{
                                      //                   await voiceNitePlayer.setFilePath(controller.messages[index].message);
                                      //                   voiceNitePlayer.play();
                                      //                   setState(() {
                                      //                     isPlaying = true;
                                      //                   });
                                      //                  // final duration = Duration(milliseconds: voiceNitePlayer.duration);
                                      //                   Timer playTimer = Timer(voiceNitePlayer.duration!, () {
                                      //                     setState(() {
                                      //                       isPlaying = false;
                                      //                     });
                                      //                   });
                                      //
                                      //                 }
                                      //
                                      //               },
                                      //               child: isPlaying?
                                      //                   Row(
                                      //                     mainAxisAlignment: MainAxisAlignment.center,
                                      //                     children: [
                                      //                       Icon(Icons.stop,color: shadow,),
                                      //                       SizedBox(width: w*.05,),
                                      //                       Text("Stop Audio")
                                      //                     ],
                                      //                   )
                                      //                   :Row(
                                      //                 mainAxisAlignment: MainAxisAlignment.center,
                                      //                 children: [
                                      //                   Icon(Icons.play_arrow_outlined,color: ColorsPlatte().primary.chat,),
                                      //                   SizedBox(width: w*.05,),
                                      //                   Text("Play Audio ")
                                      //                 ],
                                      //               )),
                                      //         );
                                      //       }
                                      //     )


                                        //    :SizedBox()

                                              ],
                                            ),
                                              _tabController.index==1?  CircleAvatar(

                                                backgroundImage: AssetImage( "assets/images/mask.png",)

                                              ):CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                      // controller
                                                      //   .messages[index].senderId.image=="image"?
                                                    "assets/images/profile.png"
                                                    //     :controller
                                                    // .messages[index].senderId.image,
                                                    )),


                                          ],
                                        ):  Row(
                                         //  margin: EdgeInsets.only(top: h*.065,left: w*.022),
                                         mainAxisAlignment:  MainAxisAlignment.start,
                                         children: [


                                               CircleAvatar(
                                             backgroundImage: AssetImage("assets/images/profile.png"),
                                           ),
                                           Column(

                                             crossAxisAlignment:
                                             CrossAxisAlignment.start,
                                             children: [
                                               Text(
                                                 controller.messages[index].senderId.toString()==widget.userModel?.id.toString()?widget.userModel!.name   :controller.messages[index]
                                                     .senderName,
                                                 style: TextStyle(
                                                   fontFamily:
                                                   'Roboto-Regular',
                                                   color: time,
                                                   fontSize:
                                                   (10 / baseWidth) * w,
                                                   fontWeight:
                                                   FontWeight.w400,
                                                   fontStyle:
                                                   FontStyle.normal,
                                                 ),
                                               ),
                                               Container(
                                                 margin: EdgeInsets.only(left: w*.022),
                                                 padding:
                                                 EdgeInsets.symmetric(
                                                     vertical: (10 /
                                                         baseHeight) *
                                                         h,
                                                     horizontal: (15 /
                                                         baseWidth) *
                                                         w),
                                                 constraints: BoxConstraints(
                                                     maxWidth: (200 / baseWidth) * w),

                                                 decoration:     controller.messages[index].senderId.toString()==widget.userModel?.id.toString()//isMe  edit is me sender id with my id
                                                     ? BoxDecoration(
                                                   color:  ColorsPlatte().primary.chat,
                                                   borderRadius: const BorderRadius.only(
                                                     topLeft: Radius.circular(16),
                                                     topRight: Radius.circular(16),
                                                     bottomRight: Radius.circular(0),
                                                     // Bottom-left remains unrounded
                                                     bottomLeft: Radius.circular(16),
                                                   ),
                                                 )
                                                     : const BoxDecoration(
                                                   color: redIcons,
                                                   borderRadius: BorderRadius.only(
                                                     topLeft: Radius.circular(16),
                                                     topRight: Radius.circular(16),
                                                     bottomRight: Radius.circular(16),
                                                     // Bottom-left remains unrounded
                                                     bottomLeft: Radius.circular(0),
                                                   ),
                                                 ),
                                                 child: Center(
                                                   child: Text(
                                                     controller.messages[index].message,
                                                     overflow: TextOverflow
                                                         .visible,
                                                     softWrap: true,

                                                     style: TextStyle(
                                                       fontFamily: 'Roboto-Regular',
                                                       color: true// need edit is me sender id with my id
                                                           ? blackBoldText
                                                           : Colors.white,
                                                       fontSize: (15 / baseWidth) * w,
                                                       fontWeight: FontWeight.w400,
                                                       fontStyle: FontStyle.normal,
                                                     ),
                                                   ),
                                                 ),
                                               ),
                                             ],
                                           ),


                                         ],
                                       ),
                                        Text(
                                          controller.messages[index].time,
                                          style: TextStyle(
                                              fontFamily: 'Roboto-Regular',

                                              color: time,

                                              fontSize: (12/baseWidth) *w,

                                              fontWeight: FontWeight.w400,

                                              fontStyle:FontStyle.normal,
                                          ),
                                        ),
                                        SizedBox(
                                          height: h * .012,
                                        )
                                      ],
                                    ),
                                  );
                                }),

                          ),

                          SizedBox(height: h*.02,), //edit height

                          Row(
                            children: [
                              SizedBox(width: w*.02,),
                              // Attachment Icon
                              // IconButton(
                              //   icon: Icon(Icons.attachment_sharp, color: Colors.white,size: w*.07,),
                              //   onPressed: () async{
                              //     // Attach file functionality
                              //   // showAttachmentOptions(
                              //   //   localizations);
                              //   },
                              // ),
                              // Input field
                              Expanded(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Row(
                                    children: [
                                      // Emoji Icon
                                     const Icon(Icons.emoji_emotions_outlined, color: emoji),
                                   //    InkWell(
                                   //        onTap: ()async{
                                   //          if(isrecording){
                                   //            String  m = await stopRecord();
                                   //            controller.addMessage(
                                   //              Messages(
                                   //              //    messageType: Type.voiceNote,
                                   //                  message: m, isRead: false,
                                   //                senderId: '0',
                                   //                //ChatContact(userId: '0',contactId: '0',isMasked: '0',
                                   //                  //     isSelected: false,
                                   //                  //     id: -1,
                                   //                  //     tag: "tag",
                                   //                  //     name: "name",
                                   //                  //     image: "image",
                                   //                  //     closed: false,
                                   //                  //     numOfMessage: "numOfMessage"),
                                   //                  time: "${outputFormat
                                   //                      .format(
                                   //                      DateTime.now())}", senderName: '')
                                   //            );
                                   //
                                   //          }else{
                                   //            startRecord();
                                   //
                                   //          }
                                   //
                                   //        },
                                   //        child: Icon(isrecording?Icons.stop:Icons.mic_none, color: redIcons)),
                                      SizedBox(width: 8),

                                      // TextField
                                    Expanded(
                                        child: TextField(
                                          controller: _controller,
                                          // onSubmitted: (_){
                                          //   if(_controller.text!="") {
                                          //     controller.addMessage(
                                          //         Messages(
                                          //             // messageType: _attachment ??
                                          //             //     Type.text,
                                          //             message:
                                          //             _controller.text,
                                          //             file: file,
                                          //
                                          //
                                          //             isRead: false,
                                          //              senderId:'0',
                                          //             // ChatContact(userId: '0',contactId: '0',isMasked: '0',
                                          //             //     isSelected: false,
                                          //             //     id: -1,
                                          //             //     tag: "tag",
                                          //             //     name: "name",
                                          //             //     image: "image",
                                          //             //     closed: false,
                                          //             //     numOfMessage: "numOfMessage"),
                                          //             time: "${outputFormat
                                          //                 .format(
                                          //                 DateTime.now())}", senderName: '')
                                          //     );
                                          //     _controller.clear();
                                          //     setState(() {
                                          //       file = false;
                                          //       _attachment = null;
                                          //     });
                                          //     FocusScope.of(context).unfocus();
                                          //   }},
                                          decoration: InputDecoration(
                                            hintText: localizations.typeMessage,
                                            border: InputBorder.none,
                                            hintStyle: TextStyle(
                                              fontFamily: 'Roboto-Light',

                                              color: lightText4,

                                              fontSize: (16/baseWidth)*w,

                                              fontWeight: FontWeight.w300,

                                              fontStyle: FontStyle.normal,
                                            )
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                      // Send Button inside the input field container
                                      Container(
                                          width: (37/baseWidth)*w,

                                          height: 37,

                                          decoration: new BoxDecoration(

                                              borderRadius: BorderRadius.circular(100),

                                              gradient: LinearGradient(

                                                colors: [

                                                  Color(0xffd42336),

                                                  Color(0xffed4658) ],

                                                stops: [

                                                  0,

                                                  1

                                                ],

                                                begin: Alignment(1.00, -0.00),

                                                end: Alignment(-1.00, 0.00),

                                              )

                                          ),
                                        child: IconButton(
                                          icon: Icon(Icons.send, color: Colors.white),
                                          onPressed: () {

                                            // Send message functionality
                                            if(_controller.text!="") {

                                              controller.createChatMessage(localizations, widget.contact!, user_token.value, _controller.text!);
                                              // controller.addMessage(
                                              //
                                              //     Messages(
                                              //         // messageType: _attachment ??
                                              //         //     Type.text,
                                              //         message: _controller.text,
                                              //         file: file,
                                              //
                                              //
                                              //         isRead: false,
                                              //         senderId:'0',
                                              //         senderName: '',
                                              //         //ChatContact(userId: '0',contactId: '0',isMasked: '0',
                                              //         //     isSelected: false,
                                              //         //     id: -1,
                                              //         //     tag: "tag",
                                              //         //     name: "name",
                                              //         //     image: "image",
                                              //         //     closed: false,
                                              //         //     numOfMessage: "numOfMessage"),
                                              //         time: "${outputFormat
                                              //             .format(
                                              //             DateTime.now())}")
                                              // );
                                              FocusScope.of(context).unfocus();
                                              _controller.clear();


                                              // setState(() {
                                              //   file = false;
                                              //   _attachment = null;
                                              // });
                                              // if (_scrollController.hasClients) {
                                              //   final position = _scrollController.position.maxScrollExtent;
                                              //   _scrollController.jumpTo(position);
                                              // }
                                              // FocusScope.of(context).unfocus();
                                              // FocusScope.of(context).unfocus();
                                            } },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),),
                             SizedBox(width: w*.02,)

                            ],
                          ),

                                          ]),
                      )),
              ) );
          }));


  }

  Widget _buildTab(

      {required String image,
      required double w,

      required double h,
      required String label,
      required bool isActive,
        required localizations,
      }) {
    return Container(
      height: double.infinity,
      decoration: isActive
          ? BoxDecoration(
              color: label==localizations.maskChat? ColorsPlatte().primary.chat:shadow,
              borderRadius: BorderRadius.circular(20),
            )
          : null,
      padding: const EdgeInsets.symmetric(vertical:2.5, horizontal: 4),
      child: Row(
        //  mainAxisSize: MainAxisSize.min,
        children: [
          Container(width: 30, height: 30, child: Image.asset(image)),
          SizedBox(width: w * .04),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Roboto-Medium',
              color: darkBlueText,
              fontSize: (14 / baseWidth) * w,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
  // showAttachmentOptions(localizations) {
  //   showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (BuildContext context) {
  //       return Container(
  //         height: 280, // Adjust height based on content
  //         decoration: BoxDecoration(
  //           color: Colors.white,
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20),
  //             topRight: Radius.circular(20),
  //           ),
  //         ),
  //         child: Padding(
  //           padding: const EdgeInsets.all(16.0),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //
  //               Expanded(
  //                 child: GridView.count(
  //                   crossAxisCount: 3,
  //                   mainAxisSpacing: 16,
  //                   crossAxisSpacing: 16,
  //                   children: [
  //                     buildAttachment(
  //                         Assets.getDocument(), localizations.document,localizations),
  //                     buildAttachment(
  //                        Assets.getPhoto(), localizations.gallery,localizations),
  //                     buildAttachment(
  //                          Assets.getCamera(), localizations.camera,localizations),
  //                     buildAttachment(
  //                        Assets.getaudio(),localizations.audio,localizations),
  //                     buildAttachment(
  //                        Assets.getLocation(), localizations.location,localizations),
  //                     buildAttachment(
  //                         Assets.getContacts(),localizations.contact,localizations),
  //                   ],
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // buildAttachment( Widget widget, String label,localizations) {
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     children: [
  //       InkWell(
  //         onTap: (){
  //           Get.back();
  //           // onTap();
  //           if(label==localizations.gallery){
  //             _pickImageFromGallery();
  //
  //           }else if(label==localizations.document){
  //             _pickDocument();
  //
  //           }else if(label==localizations.camera){
  //             _takePhoto();
  //           }else if(label== localizations.audio){
  //             _pickAudio();
  //           }else if(label== localizations.location){
  //             _getCurrentLocation();
  //
  //           }else{
  //             _pickContact();
  //           }
  //         },
  //         child: Container(
  //           width: 52,
  //           height: 52,
  //           child: widget,
  //         ),
  //       ),
  //       SizedBox(height: 8),
  //       Text(
  //         label,
  //         style: TextStyle(    fontFamily: 'Roboto-Regular',
  //
  //           color: time,
  //
  //           fontSize: 14,
  //
  //           fontWeight: FontWeight.w400,
  //
  //           fontStyle: FontStyle.normal,
  //
  //
  //         ),
  //       ),
  //     ],
  //   );
  // }
  // Future<void> _openPdfLink(String url) async {
  //   final Uri pdfUri = Uri.parse(url);
  //
  //   if (await canLaunchUrl(pdfUri)) {
  //     await launchUrl(pdfUri, mode: LaunchMode.externalApplication);
  //   } else {
  //     throw 'Could not launch $url';
  //   }
  // }
}

