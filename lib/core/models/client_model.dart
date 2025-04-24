import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/models/payment_history_model.dart';
import 'package:bingo_with_coca/core/models/prize_model.dart';

class ClientModel
{
  final String id;
  final String name;
  final String? lastPrizeDate;
  List<PrizeModel> ?prizes;
  List<PaymentHistoryModel> ?paymentHistory;

  ClientModel({required this.id, required this.name,  this.lastPrizeDate,this.prizes,this.paymentHistory});

  factory ClientModel.fromJson(Map<String, dynamic> json)
  {
    return ClientModel(
      id: json['id'],
      name: json['name'],
      lastPrizeDate: json['lastPrizeDate'],
      prizes: json['prizes']!=null? (json['prizes'] as List).map((e) => PrizeModel.fromJson(e)).toList():null,
      paymentHistory:json['paymentHistory']!=null? (json['paymentHistory'] as List).map((e) => PaymentHistoryModel.fromJson(e)).toList():null,
    );
  }
  Map<String, dynamic> toMap()
  {
    return {
      'id': id,
      'name': name,
      if(lastPrizeDate != null)
      'lastPrizeDate': lastPrizeDate,
      if(prizes != null)
      'prizes': prizes?.map((e) => e.toMap()).toList(),
      if(paymentHistory != null)
      'paymentHistory': paymentHistory?.map((e) => e.toMap()).toList(),
    };
  }
  factory ClientModel.fromEntity(ClientEntity entity)
  {
    return ClientModel(
      id: entity.id,
      name: entity.name,
      lastPrizeDate: entity.lastPrizeDate,
      prizes: entity.prizes!=null?entity.prizes!.map((e) => PrizeModel.fromEntity(e)).toList():null,
      paymentHistory: entity.paymentHistory!=null?entity.paymentHistory!.map((e) => PaymentHistoryModel.fromEntity(e)).toList():null,
    );
  }
}