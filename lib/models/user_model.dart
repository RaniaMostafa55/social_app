class UserModel {
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  String? cover;
  String? bio;
  bool? isEmailVerified;
  UserModel(
      {this.name,
      this.email,
      this.phone,
      this.uId,
      this.isEmailVerified,
      this.image,
      this.bio,
      this.cover});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    bio = json['bio'];
    cover = json['cover'];
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'uId': uId,
      'isEmailVerified': isEmailVerified,
      'image': image,
      'bio': bio,
      'cover': cover
    };
  }
}
