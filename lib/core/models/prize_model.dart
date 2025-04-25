import 'package:bingo_with_coca/core/entites/prize_entity.dart';

class PrizeModel{
  final String name;
  final String date;
  final String pack1Date;
  final String pack1Branch;
  final String pack2Date;
  final String pack2Branch;
  final String pack3Date;
  final String pack3Branch;

  PrizeModel({required this.name, required this.date, required this.pack1Date, required this.pack1Branch, required this.pack2Date, required this.pack2Branch, required this.pack3Date, required this.pack3Branch});

  Map<String,dynamic> toMap()
  {
    return {
      'name':name,
      'date':date,
      'pack1Date':pack1Date,
      'pack1Branch':pack1Branch,
      'pack2Date':pack2Date,
      'pack2Branch':pack2Branch,
      'pack3Date':pack3Date,
      'pack3Branch':pack3Branch
    };
  }
  factory PrizeModel.fromJson(Map<String,dynamic> json)
  {
    return PrizeModel(
      name: json['name'],
      date: json['date'],
      pack1Date: json['pack1Date'],
      pack1Branch: json['pack1Branch'],
      pack2Date: json['pack2Date'],
      pack2Branch: json['pack2Branch'],
      pack3Date: json['pack3Date'],
      pack3Branch: json['pack3Branch']
    );
  }
  factory PrizeModel.fromEntity(PrizeEntity entity)
  {
    return PrizeModel(
      name: entity.name,
      date: entity.date,
      pack1Date: entity.pack1Date,
      pack1Branch: entity.pack1Branch,
      pack2Date: entity.pack2Date,
      pack2Branch: entity.pack2Branch,
      pack3Date: entity.pack3Date,
      pack3Branch: entity.pack3Branch
    );
  }
  PrizeEntity toEntity()
  {
    return PrizeEntity(
      name: name,
      date: date,
      pack1Date: pack1Date,
      pack1Branch: pack1Branch,
      pack2Date: pack2Date,
      pack2Branch: pack2Branch,
      pack3Date: pack3Date,
      pack3Branch: pack3Branch
    );
  }
}