import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_project/app/data/message_model.dart';
import 'package:test_project/app/modules/home/controllers/layout_controller.dart';
import 'package:test_project/app/modules/home/controllers/login_controller.dart';
import 'package:test_project/app/modules/home/controllers/register_controller.dart';
import 'package:get/get.dart';

bool valueOfChat = false;

class GroupChatController extends GetxController {
  //TODO: Implement GroupChatController
  LoginController loginController = LoginController();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void changevalueOChat(value) {
    valueOfChat = value;
    print('valueOfHome is $valueOfChat');
    update();
  }

  void sendMessage({
    required String receiverId,
    required var dateTime,
    required String text,
  }) {
    MessageModel model = MessageModel(
      text: text,
      senderId: tokenOfDoctors,
      receiverId: receiverId,
      dateTime: dateTime,
      value: false,
    );

    // set my chats

    FirebaseFirestore.instance
        .collection('patients')
        .doc("$receiverId")
        .collection('doctors')
        .doc("$tokenOfDoctors")
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      getMessages(receiverId: receiverId);
      update();
    }).catchError((error) {});

    // set receiver chats

    FirebaseFirestore.instance
        .collection('doctors')
        .doc("$tokenOfDoctors")
        .collection('patients')
        .doc("$receiverId")
        .collection('messages')
        .add(model.toMap())
        .then((value) {
      getMessages(receiverId: receiverId);
      update();
    }).catchError((error) {});
    update();
  }

  List<MessageModel> messages = [];
  LayoutController layoutController = LayoutController();
  void getMessages({
    required String receiverId,
  }) {
    FirebaseFirestore.instance
        .collection('doctors')
        .doc(tokenOfDoctors)
        .collection('patients')
        .doc("$receiverId")
        .collection('messages')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      messages = [];

      event.docs.forEach((element) {
        messages.add(MessageModel.fromJson(element.data()));

        update();
      });
    });
    update();
  }

  Future<void> changeValueOfIndex(value) async {
    Get.put(LayoutController());
    LayoutController layoutController = Get.find();

    index = value;
    layoutController.getAllAccountPatients().then((value) {
      loginController.moveBetweenPages('layout');
    });

    update();
  }
}
