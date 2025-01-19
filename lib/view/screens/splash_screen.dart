import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:Whatsback/view/screens/auth/pick_language.dart';
import 'package:Whatsback/view/screens/login/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{
  @override
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
    Future.delayed(const Duration(seconds: 3),(){
     // _showLanguageBottomSheet();
    //  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const PickLanguage()));
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_)=>const Login()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(

      body:Container(
    decoration: const BoxDecoration(
    image: DecorationImage(
        image: AssetImage('assets/images/splash.png'), // Background image
    fit: BoxFit.cover, // Cover the whole container
    ),
    ),


      )
    );
  }



}

