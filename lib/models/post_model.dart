class PostModel {
  String? name;
  String? uid;
  String? image;
  String? dateTime;
  String? text;
  String? postImage;
  String? postId;

  PostModel(
      {this.name,
        this.image,
        this.uid,
        this.postId,
        this.dateTime,
        this.postImage,
        this.text});

  PostModel.fromjson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    uid = json['uid'];
    dateTime = json['dateTime'];
    postId = json['postId'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "uId": uid,
      "image": image,
      "postId": postId,
      "postImage": postImage,
      "text": text,
      "dateTime": dateTime
    };
  }
}
