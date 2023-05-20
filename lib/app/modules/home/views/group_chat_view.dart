import 'package:test_project/app/data/message_model.dart';
import 'package:test_project/app/modules/home/controllers/group_chat_controller.dart';
import 'package:test_project/app/modules/home/controllers/layout_controller.dart';
import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/views/profile_view.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common_widget/custom_size_box.dart';
import '../../../../common_widget/custom_text.dart';
import '../controllers/register_controller.dart';

class GroupChatView extends GetView<GroupChatController> {
  GroupChatView({Key? key}) : super(key: key);
  var messageController = TextEditingController();
  LoginController loginController = LoginController();
  LayoutController layoutController = LayoutController();
  var argument = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Builder(builder: (context) {
      return GetBuilder<GroupChatController>(
        init: GroupChatController(),
        builder: (controller) {
          controller.getMessages(receiverId: argument['token']);
          return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          loginController.moveBetweenPages('layout');
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
                      width: 10,
                    ),
                    CustomText(Colors.black, 20, FontWeight.w600,
                        "${argument['name']}")
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
                        ? Center(child: const Text("Never communicated before"))
                        : Expanded(
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                var message = controller.messages[index];
                                if (tokenOfDoctors == message.senderId) {
                                  return buildMyMessage(message);
                                }

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
              ));
        },
      );
    });
  }
}

Widget buildMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: const BorderRadiusDirectional.only(
            bottomEnd: Radius.circular(
              10.0,
            ),
            topStart: Radius.circular(
              10.0,
            ),
            topEnd: Radius.circular(
              10.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 10,
        ),
        child: Text(model.text),
      ),
    );

Widget buildMyMessage(MessageModel model) => Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadiusDirectional.only(
            bottomStart: Radius.circular(
              10.0,
            ),
            topStart: Radius.circular(
              10.0,
            ),
            topEnd: Radius.circular(
              10.0,
            ),
          ),
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 5.0,
          horizontal: 10.0,
        ),
        child: Text(
          model.text,
        ),
      ),
    );
Widget buildTextFormMessage() => Padding(
      padding: const EdgeInsets.only(top: 10.0),
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
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: 'Aa',
            suffixIcon: MaterialButton(
              height: 10,
              padding: EdgeInsets.zero,
              onPressed: () async {
                // c.sendMessage(
                //   receiverId: userModel.uId,
                //   dateTime: DateTime.now().toString(),
                //   text: messageController.text,
                // );
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
    );
