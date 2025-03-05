import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:Whatsback/const/colors.dart';
import 'package:Whatsback/controller/requests_controller.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../../const/sizes.dart';
import '../../../controller/messages_controller.dart';
import '../chat_screen.dart';

class Requests extends StatelessWidget {
  const Requests({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    final localizations = AppLocalizations.of(context)!;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding:  EdgeInsets.only(top: h* .034,
                left: w * .039,right: w * .05
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(localizations.requests,
                    style: TextStyle(
                      fontFamily: 'Roboto-Medium',
                      color: Colors.white,
                      fontSize: (26 / baseWidth) * w,
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                    )
                ),

              ],
            ),
          ),
          SizedBox(height: h * .03,),
          Container(
            padding:  EdgeInsets.only(left: w *.035,right: w*.035,bottom: (13/baseHeight)*h,top: (13/baseHeight)*h),

            width: w,
            height: h * .765,
            decoration:  BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35),
                    bottomLeft: Radius.circular(35),
                    bottomRight: Radius.circular(35)
                )

            ),
            child: GetBuilder<RequestsController>(
              init: RequestsController(),
              builder: (controller) {
                return controller.loading==true?Center(child: CircularProgressIndicator(color: redCheck,)):controller.requests.isEmpty?

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/requests.png",
                        scale: 1.5,
                        ),
                        SizedBox(height:h*.021),
                        Text(localizations.empty,

                            style: TextStyle(

                              fontFamily: 'Roboto-Medium',

                              color: darkBlueText,

                              fontSize: (16/baseWidth)*w,

                              fontWeight: FontWeight.w500,

                              fontStyle: FontStyle.normal,





                            )

                        ),
                        SizedBox(height:h*.021),
                Text(localizations.noRequests,

                style: TextStyle(

                fontFamily: 'Roboto-Regular',

                color: ColorsPlatte().secondary.lightText8,

                fontSize: (14/baseWidth)*w,

                fontWeight: FontWeight.w400,

                fontStyle: FontStyle.normal,))
                      ],
                    )
                    :ListView.builder(
                    padding: EdgeInsets.zero,
                    itemCount: controller.requests.length,
                    itemBuilder: (context, index) {
                    final request = controller.requests[index];
                    return Column(
                      children: [
                        ListTile(
                        contentPadding: const EdgeInsets.all(0),
                        onTap: (){
                          Get.find<MessagesController>().getMessages(controller.requests[index]);
                          Get.to(Chat(person: controller.requests[index],newMask: controller.requests[index].talkingAnonymous,
                          unKnown: true,
                          ));


                        },
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0),
                        ),
                        tileColor: Colors.white,
                        leading: CircleAvatar(

                        child: Image.asset(request.image),
                        ),
                        title: Text(
                        localizations.anonymous,
                            style: TextStyle(

                              fontFamily: 'Roboto-Medium',

                              color: darkBlueText,

                              fontSize: (14/baseWidth)*w,

                              fontWeight: FontWeight.w500,

                              fontStyle: FontStyle.normal,





                            )
                        ),
                        subtitle: Text(
                        localizations.message,
                            style: TextStyle(

                              fontFamily: 'Roboto-Regular',

                              color: ColorsPlatte().secondary.lightText8,

                              fontSize: (13/baseWidth)*w,

                              fontWeight: FontWeight.w400,

                              fontStyle: FontStyle.normal,





                            )
                        ),
                        trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                        if (int.parse(request.numOfMessage) > 0)
                        Container(
                          width: 21,

                          height: 21,
                                           // padding:  EdgeInsets.symmetric(vertical: h*.01,horizontal: w*.01),
                        decoration: BoxDecoration(
                        color: ColorsPlatte().primary.req,
                        borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(
                          child: Text(
                          '${request.numOfMessage}',
                          style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          ),
                          ),
                        ),
                        ),
                        const SizedBox(width: 8.0),
                        const Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                        ),
                        ),
                        SizedBox(
                          height: h * .01,
                        ),
                        Container(
                            margin: EdgeInsets.only(right: w * .1),
                            height: 1,
                            decoration: new BoxDecoration(color: divider)),
                      ],

                    );
                    },);
              }
            ),



          )

        ],
      ),
    );
  }
}
