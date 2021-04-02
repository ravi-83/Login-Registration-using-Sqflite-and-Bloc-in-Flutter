class UserModel{
  int id;
  String name;
  String email;
  String password;
  bool isUserExisted;

  UserModel({this.id, this.name, this.email, this.password,this.isUserExisted});

  UserModel.fromJson(Map<String,dynamic> json) {
    id=json['id'];
    name=json['name'];
    email= json['email'];
    password=json['password'];

  }

  Map<String,dynamic> toMap(){
    var map = new Map<String, dynamic>();
    map['id'] =id;
    map["name"] = name;
    map["password"] = password;
    map["email"] = email;
    return map;
  }
}