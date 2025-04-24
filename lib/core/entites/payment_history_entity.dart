import 'package:bingo_with_coca/core/models/payment_history_model.dart';

class PaymentHistoryEntity{
final String packDate;
final String packBranch;

  PaymentHistoryEntity({required this.packDate, required this.packBranch});
  PaymentHistoryModel toModel(){
    return PaymentHistoryModel(
      packDate: packDate,
      packBranch: packBranch
    );
  }



}