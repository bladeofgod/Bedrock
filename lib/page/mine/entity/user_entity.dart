/*
* Author : LiJiqqi
* Date : 2020/5/18
*/

class UserEntity {
  String? nickName;
  String? id;

  UserEntity({this.nickName, this.id});

  UserEntity.fromJson(Map<String?, dynamic> json) {
    nickName = json['nick_name'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nick_name'] = this.nickName;
    data['id'] = this.id;
    return data;
  }
}



