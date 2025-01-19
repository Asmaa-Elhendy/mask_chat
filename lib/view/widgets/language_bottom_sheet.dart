import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:Whatsback/view/screens/auth/add_number.dart';

import '../../const/colors.dart';
import '../../const/sizes.dart';
import '../../controller/language.dart';

class LanguageBottomSheet extends StatefulWidget {
  var localizations;
   LanguageBottomSheet({required this.localizations,super.key});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  String selected = "";
  void selectLanguage(String code) {
    setState(() {
      selected = code;
    });
  }
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return AnimatedContainer(
      padding: EdgeInsets.only(
          top: baseHeight*.06,

          left: (20 / baseWidth) * w,
          right: (20 / baseWidth) * w,
          bottom: (21 / baseHeight) * h

      ),
      duration: const Duration(microseconds: 500),
      curve: Curves.bounceInOut,
      decoration: BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.circular(20)
      ),
      height: 300 * (h / baseHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Text(
              widget.localizations.choose_preferred_language,
              style: TextStyle(

                fontFamily: 'Roboto-Bold',

                color: blackBoldText,

                fontSize: (22 / baseWidth) * w,

                fontWeight: FontWeight.w700,

                fontStyle: FontStyle.normal,


              )
          ),
          SizedBox(height: baseHeight*.0107),
          Expanded(
            child: ListView(

              children: [
                _languageTile(
                    'English',
                    'assets/images/uk.png',
                        (){
                      setState(() {
                      selected = "English";
                    });
                      Get.find<LanguageController>().changeLanguage('en');
                    }
                ),
                Container(
                    width: 341,
                    height: 1,
                    decoration: const BoxDecoration(color:divider)
                ),
                _languageTile(
                    'русский',
                    'assets/images/russia.png',
                        (){setState(() {
                      selected = "русский";
                    });
                        Get.find<LanguageController>().changeLanguage('ru');
                    }
                ),
                Container(
                    width: 341,
                    height: 1,
                    decoration: const BoxDecoration(color:divider)
                ),
                _languageTile(
                    'العربية',
                    'assets/images/egypt_1.png',
                        (){setState(() {
                      selected = "العربية";
                    });
                        Get.find<LanguageController>().changeLanguage('ar');
                    }
                ),
                Container(
                    width: 341,
                    height: 1,
                    decoration: const BoxDecoration(color:divider)
                ),
                _languageTile(
                    'Türkçe',
                    'assets/images/egypt_1.png',
                        (){setState(() {
                      selected = "Türkçe";
                    });
                        Get.find<LanguageController>().changeLanguage('tr');
                    }
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget _languageTile(String language, String iconPath, onTab) {
    return GestureDetector(
      child: ListTile(

        // leading: Image.asset(
        //   iconPath,
        //   width: 32,
        //   height: 32,
        // ),
        title: Text(language,     style: const TextStyle(

          fontFamily: 'HelveticaNeue',

          color: blackBoldText,

          fontSize: 16,

          fontWeight: FontWeight.w400,

          fontStyle: FontStyle.normal,





        )),
        trailing: selected==language
            ? const Icon(Icons.check_circle, color: redCheck)
            : const SizedBox.shrink(),
        onTap: () {
          onTab();
          Get.off(const AddNumber());


          // Navigator.pop(context); // Close bottom sheet on selection
          // Handle language selection logic here
        },
      ),
    );
  }
}
