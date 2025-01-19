import 'package:flutter/material.dart';
import 'package:Whatsback/model/contacts.dart';

class Class{
  int id = 1;
  String name;
  var image;
  var icon;
  int contactsNum;
  List<Contacts> contacts;
  bool selected;
  Color? mainColor;
  Color? secondColor;
  Class({required this.contacts,required this.contactsNum,this.mainColor,this.secondColor,required this.id,this.selected=false,this.image,required this.name,this.icon});

}