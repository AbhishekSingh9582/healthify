class Users {
  String? name;
  String? id;
  String? email;

  Users({this.name, this.email, this.id});
  Users.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    id = json['id'];
    // wishList = json['wishList'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = name;
    data['email'] = email;
    data['id'] = id;
    // data['wishList'] = wishList;
    return data;
  }
}
