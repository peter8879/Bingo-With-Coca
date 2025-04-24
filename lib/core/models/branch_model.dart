import '../entites/branch_entity.dart';

class BranchModel
{
  final String id;
  final String name;

  BranchModel({required this.id, required this.name});
  Map<String,dynamic> toMap()
  {
    return {
      'id':id,
      'name':name,
    };
  }
  factory BranchModel.fromJson(Map<String,dynamic> json)
  {
    return BranchModel(
      id: json['id'],
      name: json['name'],
    );
  }
  factory BranchModel.fromEntity(BranchEntity entity)
  {
    return BranchModel(
      id: entity.id,
      name: entity.name,
    );
  }
  BranchEntity toEntity()
  {
    return BranchEntity(
      id: id,
      name: name,
    );
  }

}