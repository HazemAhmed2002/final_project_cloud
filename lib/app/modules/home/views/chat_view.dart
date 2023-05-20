import 'package:test_project/app/modules/home/controllers/group_chat_controller.dart';
import 'package:test_project/app/modules/home/controllers/layout_controller.dart';
import 'package:test_project/app/modules/home/views/profile_view.dart';
import 'package:test_project/app/modules/home/views/register_view.dart';
import 'package:test_project/common_widget/custom_size_box.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../common_widget/custom_text.dart';

class ChatView extends GetView<LayoutController> {
  ChatView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutController>(
      init: LayoutController(),
      builder: (controller) {
        return Scaffold(
            body: Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 10),
          child: patients.length == 0
              ? Center(child: Text("لا يوجد مرضى"))
              : ListView.separated(
                  padding: EdgeInsets.zero,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              alignment: AlignmentDirectional.bottomEnd,
                              children: [
                                customCircleAvatar(28,
                                    color: Colors.white,
                                    image: "${patients[index].image}",
                                    onTap: () {
                                  GroupChatController group =
                                      GroupChatController();
                                  final groupChat =
                                      Get.lazyPut(() => GroupChatController());
                                  GroupChatController groupChatController =
                                      GroupChatController();
                                  groupChatController.getMessages(
                                      receiverId: patients[index].token);
                                  loginController.moveBetweenPages(
                                      'GroupChatView',
                                      arguments: {
                                        "token": patients[index].token,
                                        "cover": patients[index].image,
                                        "name": patients[index].name,
                                        "cover": patients[index].image
                                      });
                                }),
                                Stack(
                                  alignment: AlignmentDirectional.center,
                                  children: [
                                    customCircleAvatar(10, color: Colors.white),
                                    customCircleAvatar(7, color: Colors.green),
                                  ],
                                )
                              ],
                            ),
                            CustomSizeBox(
                              0,
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CustomText(Colors.black, 17, FontWeight.w600,
                                    "${patients[index].name}"),
                                CustomText(
                                    Colors.grey, 14, FontWeight.w400, "omar"),
                              ],
                            ),
                            const Spacer(),
                            CustomText(const Color(0xff333333), 14,
                                FontWeight.w400, "06:12")
                          ],
                        ),
                      ),
                  separatorBuilder: (context, index) => CustomSizeBox(20),
                  itemCount: patients.length),
        ));
      },
    );
  }
}
