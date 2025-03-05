import 'dart:io';

import 'package:contacts_service/contacts_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_native_contact_picker/flutter_native_contact_picker.dart' as native_picker;
import 'package:path/path.dart' as path;
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



import '../../../../const/colors.dart';
import '../../../../const/sizes.dart';
import '../../../../controller/assets.dart';
import '../../../../controller/audio_controller.dart';
import '../../../../controller/api/messages/messages_controller.dart';
import '../../../../model/contacts.dart';
import '../../../../model/messages.dart';

class GroupChat extends StatefulWidget {
  const GroupChat({super.key});

  @override
  State<GroupChat> createState() => _GroupChatState();
}

class _GroupChatState extends State<GroupChat> with TickerProviderStateMixin {
  late TabController _tabController;
  TextEditingController _controller = TextEditingController();
  // Get current date and time
  bool file = false;

  var outputFormat = DateFormat('MM dd, hh:mm a');
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  Type? _attachment;
  File? fileDocument;


  final native_picker.FlutterNativeContactPicker _contactPicker = native_picker.FlutterNativeContactPicker();
  AudioMessageController audioController = AudioMessageController();



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
  //
  //     _controller.text=filePath;
  //     // Send this file path in the chat or upload it to a server
  //   } else {
  //   }
  // }
  //
  // // Function to get current location
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
  //
  Future<void> _pickContact() async {
    try {
      // Open the contact picker
      var  contact = (await _contactPicker.selectPhoneNumber());
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
    _tabController = TabController(length: 2, vsync: this);
  }
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: GetBuilder<MessagesController>(
          init: MessagesController(),
          builder: (controller) {
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
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        scale: 1.5, // Adjust the scale
                                        image: controller.chatGroup.image
                                                is String
                                            ? AssetImage(
                                                controller.chatGroup.image == ""
                                                    ? "assets/images/categories/Closed friend.png"
                                                    : controller
                                                        .chatGroup.image,
                                              )
                                            : FileImage(
                                                controller.chatGroup.image,
                                                scale: 1.5,
                                                // fit: BoxFit.cover,
                                              ),
                                        fit: BoxFit.cover),
                                  ),
                                ),
                                SizedBox(
                                  width: w * .028,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      controller.chatGroup.subject,
                                      style: TextStyle(
                                        fontFamily: 'Roboto-Medium',
                                        color: Colors.white,
                                        fontSize: (18 / baseWidth) * w,
                                        fontWeight: FontWeight.w500,
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ],
                                )
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
                                  setState(
                                      () {}); // Update the active tab state
                                },
                              ),
                            )
                          ])),
                      //  SizedBox(height: h*.025,),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: (16 / baseWidth) * w),
                        child: Row(
                          children: [
                            SizedBox(
                              width: w * .8,
                              height: (25 / baseHeight) * h,
                              child: ListView.builder(
                                  controller: _scrollController,
                                  scrollDirection: Axis
                                      .horizontal, // Set horizontal scrolling
                                  itemCount:
                                      controller.chatGroup.groupContacts.length,
                                  //shrinkWrap: true,
                                  itemBuilder: (context, index) {



                                    return Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: (5 / baseWidth) * w),
                                      child: Image.asset(
                                        controller.chatGroup
                                            .groupContacts[index].image,
                                        width: 40,
                                        height: 40,

                                        fit: BoxFit.cover, // Adjust image fit
                                      ),
                                    );
                                  }),
                            ),
                            Spacer(),
                            InkWell(
                              onTap: () {},
                              child: Image.asset("assets/images/add.png"),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: h * .01,
                      ),

                      Container(
                        padding: EdgeInsets.only(
                            top: (1 / baseHeight) * h,
                            left: w * .033,
                            right: w * .033,
                            bottom: h * .0145),
                        width: w,
                        height: h * .6,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(35),
                          image: const DecorationImage(
                            image: AssetImage(
                                'assets/images/bitmap.png'), // Replace with your image path
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: ListView.builder(
                            itemCount: controller.messages.length,
                            itemBuilder: (context, index) {
                              final Messages currentMessage =
                                  controller.messages[index];
                              bool isMe = currentMessage.senderId == -1;
                              String m = controller.messages[index].message;

                              return Container(
                                child: Column(
                                  children: [
                                    isMe
                                        ? Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  Text(
                                                   _tabController.index==1? localizations.anonymous:controller.messages[index]
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
                             //   controller.messages[index].messageType==Type.text?
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

                                  decoration: isMe
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
                                        controller.messages[index].message,
                                        style: TextStyle(
                                          fontFamily: 'Roboto-Regular',
                                          color: isMe
                                              ? blackBoldText
                                              : Colors.white,
                                          fontSize: (15 / baseWidth) * w,
                                          fontWeight: FontWeight.w400,
                                          fontStyle: FontStyle.normal,
                                        ),
                                      )
                                  ),
                                )
                                    //:
                                // controller.messages[index].messageType==Type.image?
                                // Container(
                                //   width: 200,
                                //   height: 200,
                                //   child: Image.file(File(controller.messages[index].message)),
                                // ):
                                // controller.messages[index].messageType==Type.document?
                                //
                                //     GestureDetector(
                                //
                                //       onTap: () {
                                //         OpenFile.open(controller.messages[index].message);
                                //       },
                                //
                                //       child: Container(
                                //           margin: EdgeInsets.symmetric(horizontal: w*.1),
                                //           // width: 50,
                                //           // height: 50,
                                //           color: Colors.white,
                                //           child:Row(
                                //             children: [
                                //               Icon(Icons.insert_drive_file, color: Colors.blue),
                                //               SizedBox(width: w*.014,),
                                //               SizedBox(
                                //                 width: w*.2,
                                //                 child: Text("${path.basename(controller.messages[index].message)}",
                                //
                                //                   overflow: TextOverflow.ellipsis,
                                //
                                //                 ),
                                //               )
                                //
                                //             ],
                                //           )
                                //
                                //       ),
                                //     )
                                //
                                //         :controller.messages[index].messageType==Type.location?
                                //     TextButton(
                                //       onPressed: () => openLocation(controller.messages[index].message),
                                //       child: Text(localizations.shared_location_click_to_view),
                                //     )
                                //
                                //         :controller.messages[index].messageType==Type.audio?
                                //     Row(
                                //       children: [
                                //         IconButton(
                                //           icon: Icon(Icons.headphones),
                                //           onPressed: (){
                                //             _toggleAudio(controller.messages[index].message);
                                //
                                //           },
                                //         ),
                                //         Text(localizations.audio_file),
                                //       ],
                                //     )
                                //
                                //
                                //         :SizedBox()

                                                ],
                                              ),
                                              Stack(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage: AssetImage(
                                                        // controller
                                                        //             .messages[
                                                        //                 index]
                                                        //             .senderId
                                                        //             .image ==
                                                        //         "image"
                                                            // ?
                                                      "assets/images/profile.png"
                                                            // : controller
                                                            //     .messages[index]
                                                            //     .senderId
                                                            //     .image
                                                    ),
                                                  ),
                                                  _tabController.index == 1?
                                                      Image.asset("assets/images/mask.png")
                                                      :SizedBox()
                                                ],
                                              ),
                                            ],
                                          )
                                        : Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              CircleAvatar(
                                                backgroundImage: AssetImage(
                                                    // controller.messages[index]
                                                    //             .senderId.image ==
                                                    //         "image"
                                                    //     ?
                                                    "assets/images/profile.png"
                                                        // : controller
                                                        //     .messages[index]
                                                        //     .senderId
                                                        //     .image
                                                ),
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    controller.messages[index]
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
                                                    margin: EdgeInsets.only(
                                                        left: w * .022),
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: (10 /
                                                                    baseHeight) *
                                                                h,
                                                            horizontal: (15 /
                                                                    baseWidth) *
                                                                w),
                                                    constraints: BoxConstraints(
                                                        maxWidth:
                                                            (200 / baseWidth) *
                                                                w),
                                                    decoration: isMe
                                                        ? BoxDecoration(
                                                            color:
                                                                ColorsPlatte()
                                                                    .primary
                                                                    .chat,
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(16),
                                                              topRight: Radius
                                                                  .circular(16),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          0),
                                                              // Bottom-left remains unrounded
                                                              bottomLeft: Radius
                                                                  .circular(16),
                                                            ),
                                                          )
                                                        : const BoxDecoration(
                                                            color: redIcons,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .only(
                                                              topLeft: Radius
                                                                  .circular(16),
                                                              topRight: Radius
                                                                  .circular(16),
                                                              bottomRight:
                                                                  Radius
                                                                      .circular(
                                                                          16),
                                                              // Bottom-left remains unrounded
                                                              bottomLeft: Radius
                                                                  .circular(0),
                                                            ),
                                                          ),
                                                    child: Center(
                                                      child: Text(
                                                        controller
                                                            .messages[index]
                                                            .message,
                                                        style: TextStyle(
                                                          fontFamily:
                                                              'Roboto-Regular',
                                                          color: isMe
                                                              ? blackBoldText
                                                              : Colors.white,
                                                          fontSize:
                                                              (15 / baseWidth) *
                                                                  w,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                          fontStyle:
                                                              FontStyle.normal,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                    Text(
                                      controller.messages[index].time,
                                      style: TextStyle(
                                        fontFamily: 'Roboto-Regular',
                                        color: time,
                                        fontSize: (12 / baseWidth) * w,
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.normal,
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

                      SizedBox(
                        height: h * .022,
                      ),
                      Row(
                        children: [
                          // Attachment Icon
                          IconButton(
                            icon: Icon(
                              Icons.attachment_sharp,
                              color: Colors.white,
                              size: w * .07,
                            ),
                            onPressed: () async {
                              // Attach file functionality
                              showAttachmentOptions(localizations);
                            },
                          ),
                          // Input field
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Row(
                                children: [
                                  // Emoji Icon
                                  const Icon(Icons.emoji_emotions_outlined,
                                      color: emoji),
                                  SizedBox(width: 8),
                                  // TextField
                                  Expanded(
                                    child: TextField(
                                      controller: _controller,
                                      onSubmitted: (_) {
                                        if(_controller.text!=""){
                                        controller.addMessage(Messages(
                                            // messageType: _attachment ??
                                            //     Type.text,
                                            message: _controller.text,
                                            isRead: false,

                                            file: file,
                                            senderId: '0',
                                            // ChatContact(userId: '0',contactId: '0',isMasked: '0',
                                            //     isSelected: false,
                                            //     id: -1,
                                            //     tag: "tag",
                                            //     name: "name",
                                            //     image: "image",
                                            //     closed: false,
                                            //     numOfMessage: "numOfMessage"),
                                            time:
                                                "${outputFormat.format(DateTime.now())}", senderName: ''));
                                        _controller.clear();
                                        setState(() {
                                        file = false;
                                        _attachment = null;
                                        });
                                        setState(() {
                                          _scrollController.animateTo(
                                            _scrollController.position.maxScrollExtent,
                                            duration: const Duration(milliseconds: 300),
                                            curve: Curves.easeOut,
                                          );
                                        });


                                      }},
                                      decoration: InputDecoration(
                                          hintText: localizations.typeMessage,
                                          border: InputBorder.none,
                                          hintStyle: TextStyle(
                                            fontFamily: 'Roboto-Light',
                                            color: lightText4,
                                            fontSize: (16 / baseWidth) * w,
                                            fontWeight: FontWeight.w300,
                                            fontStyle: FontStyle.normal,
                                          )),
                                    ),
                                  ),
                                  // Send Button inside the input field container
                                  Container(
                                    width: (37 / baseWidth) * w,
                                    height: 37,
                                    decoration: new BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        gradient: LinearGradient(
                                          colors: [
                                            Color(0xffd42336),
                                            Color(0xffed4658)
                                          ],

                                          stops: [0, 1],

                                          begin: Alignment(1.00, -0.00),

                                          end: Alignment(-1.00, 0.00),

                                          // angle: 270,

                                          // scale: undefined,
                                        )),
                                    child: IconButton(
                                      icon:
                                          Icon(Icons.send, color: Colors.white),
                                      onPressed: () {
                                        // Send message functionality
                                        if(_controller.text!="") {
                                          controller.addMessage(Messages(
                                              // messageType: _attachment ??
                                              //     Type.text,
                                              message: _controller.text,
                                              file: file,
                                              isRead: false,
                                              senderId:'0',senderName: '',
                                              // ChatContact(userId: '0',contactId: '0',isMasked: '0',
                                              //     isSelected: false,
                                              //     id: 1,
                                              //     tag: "tag",
                                              //     name: "name",
                                              //     image: "image",
                                              //     closed: false,
                                              //     numOfMessage: "numOfMessage"),
                                              time:
                                              "${outputFormat.format(
                                                  DateTime.now())}"));

                                          _controller.clear();
                                          setState(() {
                                            file = false;
                                            _attachment = null;
                                          });
                                        }},
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: w * .044,
                          )
                        ],
                      ),
                    ]),
                  )),
            ));
          }),
    );
  }

  Widget _buildTab(
      {required String image,
      required double w,
      required double h,
      required String label,
      required bool isActive,
        required localizations
      }) {
    return Container(
      height: double.infinity,
      decoration: isActive
          ? BoxDecoration(
              color:
                  label == localizations.maskChat ? ColorsPlatte().primary.chat : shadow,
              borderRadius: BorderRadius.circular(20),
            )
          : null,
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 4),
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

  showAttachmentOptions(localizations) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Container(
          height: 280, // Adjust height based on content
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 16,
                    children: [
                      buildAttachment(
                          Assets.getDocument(), localizations.document,localizations),
                      buildAttachment(
                          Assets.getPhoto(), localizations.gallery,localizations),
                      buildAttachment(
                          Assets.getCamera(), localizations.camera,localizations),
                      buildAttachment(
                          Assets.getaudio(),localizations.audio,localizations),
                      buildAttachment(
                          Assets.getLocation(), localizations.location,localizations),
                      buildAttachment(
                          Assets.getContacts(),localizations.contact,localizations),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  buildAttachment( Widget widget, String label,localizations) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: (){
            Get.back();
            // onTap();
            // if(label==localizations.gallery){
            //   _pickImageFromGallery();
            //
            // }
            // else if(label==localizations.document){
            //   _pickDocument();
            //
            // }
            // else if(label==localizations.camera){
            //   _takePhoto();
            // }
            // else if(label== localizations.audio){
            //   _pickAudio();
            // }
            // else if(label== localizations.location){
            //   _getCurrentLocation();
            //
            // }
            // else{
              _pickContact();
         //   }
          },
          child: Container(
            width: 52,
            height: 52,
            child: widget,
          ),
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(    fontFamily: 'Roboto-Regular',

            color: time,

            fontSize: 14,

            fontWeight: FontWeight.w400,

            fontStyle: FontStyle.normal,


          ),
        ),
      ],
    );
  }}
