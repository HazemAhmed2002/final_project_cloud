class DoctorAccountModel {
  dynamic name;
  dynamic email;
  dynamic phone;
  dynamic bio;
  dynamic image;
  dynamic token;
  DoctorAccountModel(
      this.name, this.email, this.phone, this.token, this.bio, this.image);
  DoctorAccountModel.formJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    token = json['token'];
    bio = json['bio'];
    image = json['image'];
  }
  Map<String, dynamic>? toMAp() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'token': token,
      'bio': bio,
      'image': image,
    };
  }
}
