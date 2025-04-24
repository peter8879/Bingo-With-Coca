import 'package:bingo_with_coca/core/entites/payment_history_entity.dart';

class PaymentHistoryModel
{
  final String packDate;
  final String packBranch;

  PaymentHistoryModel({required this.packDate, required this.packBranch});
  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json){
    return PaymentHistoryModel(
      packDate: json['packDate'],
      packBranch: json['packBranch']
    );
  }
  Map<String, dynamic> toMap(){
    return {
      'packDate': packDate,
      'packBranch': packBranch
    };
  }
  factory PaymentHistoryModel.fromEntity(PaymentHistoryEntity entity){
    return PaymentHistoryModel(
      packDate: entity.packDate,
      packBranch: entity.packBranch
    );
  }



}