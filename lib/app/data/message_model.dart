class MessageModel {
  late String senderId;
  late String receiverId;
  late String dateTime;
  late String text;
  bool? value;
  MessageModel(
      {required this.senderId,
      required this.receiverId,
      required this.dateTime,
      required this.text,
      required this.value});

  MessageModel.fromJson(Map<String, dynamic> json) {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    value = json['value'];
  }

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'dateTime': dateTime,
      'text': text,
      'value': value,
    };
  }
}
