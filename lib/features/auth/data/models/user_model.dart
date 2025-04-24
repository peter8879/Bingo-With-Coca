import '../../domain/entites/user_entity.dart';

class UserModel
{
  final String id;
  final String branch;

  UserModel({required this.id, required this.branch});
  factory UserModel.fromJson(Map<String, dynamic> json){
    return UserModel(
      id: json['id'],
      branch: json['branch']
    );
  }
  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'branch': branch
    };
  }
  factory UserModel.fromEntity(UserEntity entity){
    return UserModel(
      id: entity.id,
      branch: entity.branch
    );
  }
  UserEntity toEntity(){
    return UserEntity(
      id: id,
      branch: branch
    );
  }

}