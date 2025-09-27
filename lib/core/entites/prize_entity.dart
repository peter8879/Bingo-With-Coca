import 'package:bingo_with_coca/core/models/prize_model.dart';

class PrizeEntity
{
  final String name;
  final String date;
  final String prizeBranch;
  final String pack1Date;
  final String pack1Branch;
  final String pack2Date;
  final String pack2Branch;
  final String pack3Date;
  final String pack3Branch;
   String ?image;
   String ?longitude;
   String? latitude;

  PrizeEntity( {required this.name, required this.date,required this.prizeBranch ,required this.pack1Date, required this.pack1Branch, required this.pack2Date, required this.pack2Branch, required this.pack3Date, required this.pack3Branch,this.image,this.longitude,this.latitude});

  PrizeModel toModel()
  {
    return PrizeModel(
      name: name,
      date: date,
      prizeBranch: prizeBranch,
      pack1Date: pack1Date,
      pack1Branch: pack1Branch,
      pack2Date: pack2Date,
      pack2Branch: pack2Branch,
      pack3Date: pack3Date,
      pack3Branch: pack3Branch,
      image: image,
      longitude: longitude,
      latitude: latitude,
    );
  }
}