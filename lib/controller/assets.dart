import 'package:flutter/material.dart';
class Assets{

  static final Assets _instance = Assets._internal();
  factory Assets() => _instance;
  Assets._internal();

  static getCamera(){
    return Image.asset("assets/images/attachment_icons/camera.png");
  }
  static getLocation(){
    return Image.asset("assets/images/attachment_icons/location.png");
  }

  static getaudio(){
    return Image.asset("assets/images/attachment_icons/audio.png");
  }
  static getDocument(){
    return Image.asset("assets/images/attachment_icons/document.png");
  }
  static getContacts(){
    return Image.asset("assets/images/attachment_icons/contact.png");
  }
  static getPhoto(){
    return Image.asset("assets/images/attachment_icons/photo.png");
  }
  static getWorkmates(){
    return AssetImage("assets/images/categories/workmates.png");
  }
  static getFamily(){
    return AssetImage("assets/images/categories/family.png");
  }
  static getClosedFriend(){
    return AssetImage("assets/images/categories/Closed friend.png");
  }
  static getFriend(){
    return AssetImage("assets/images/categories/friend.png");
  }

  static getWorkmatesIcon(){
    return Image.asset("assets/images/categories/workmates mask.png");
  }
  static getFamilyIcon(){
    return Image.asset("assets/images/categories/family mask.png");
  }
  static getClosedFriendIcon(){
    return Image.asset("assets/images/categories/closed friend mask.png");
  }
  static getFriendIcon(){
    return Image.asset("assets/images/categories/friend mask.png");
  }
  static getGeneralMask(){
    return Image.asset("assets/images/categories/party-mask.png");
  }

}

