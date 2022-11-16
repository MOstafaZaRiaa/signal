class UserModel {
  String? uid;
  String? name;
  String? bio;
  String? email;
  String? phone;
  String? image;
  String? cover;
  UserModel({this.uid, this.name, this.phone, this.image,this.cover,this.bio,this.email});

  UserModel.fromjson(Map<String, dynamic> json) {
    uid = json['uid'];
    name = json['name'];
    bio = json['bio'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    cover = json['cover'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = this.uid;
    data['name'] = this.name;
    data['bio'] = this.bio;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['cover'] = this.cover;

    return data;
  }

}