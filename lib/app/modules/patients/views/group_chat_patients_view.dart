import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/views/group_chat_view.dart';
import 'package:test_project/app/modules/home/views/profile_view.dart';
import 'package:test_project/app/modules/patients/controllers/group_chat_patients_controller.dart';
import 'package:test_project/app/modules/patients/controllers/layout_patients_app_controller.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:test_project/common_widget/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

class GroupChatPatientsView extends GetView<GroupChatPatientsController> {
  GroupChatPatientsView({Key? key}) : super(key: key);
  var argument = Get.arguments;
  var messageController = TextEditingController();
  LoginController loginController = LoginController();
  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        return GetBuilder<GroupChatPatientsController>(
          init: GroupChatPatientsController(),
          builder: (controller) {
            controller.getMessages(receiverId: argument['token']);

            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          loginController
                              .moveBetweenPages('LayoutPatientsAppView');
                        },
                        child: Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Colors.black,
                        )),
                    CustomSizeBox(
                      0,
                      width: 20,
                    ),
                    customCircleAvatar(25,
                        color: Colors.white, image: "${argument['cover']}"),
                    CustomSizeBox(
                      0,
                      width: 20,
                    ),
                    CustomText(
                        Colors.black, 20, FontWeight.w600, argument['name'])
                  ],
                ),
              ),
              body: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    controller.messages.length == 0
                        ? Center(child: Text("لم يتم التواصل من قبل"))
                        : Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                var message = controller.messages[index];
                                if (tokenOfPatients == message.senderId)
                                  return buildMyMessage(message);

                                return buildMessage(message);
                              },
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(
                                height: 15,
                              ),
                              itemCount: controller.messages.length,
                            ),
                          ),
                  ],
                ),
              ),
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.only(bottom: 20.0, left: 15, right: 15),
                child: Container(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  height: 50,
                  padding: const EdgeInsetsDirectional.only(
                    start: 15,
                    end: 0,
                  ),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey,
                      )),
                  child: TextFormField(
                    maxLines: 999,
                    controller: messageController,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Aa',
                      suffixIcon: MaterialButton(
                        height: 10,
                        padding: EdgeInsets.zero,
                        onPressed: () async {
                          controller.sendMessage(
                            receiverId: argument['token'],
                            dateTime: DateTime.now().toString(),
                            text: messageController.text,
                          );

                          messageController.clear();
                        },
                        color: Colors.green,
                        elevation: 10,
                        minWidth: 1,
                        child: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
