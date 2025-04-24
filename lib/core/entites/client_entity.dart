import 'package:bingo_with_coca/core/entites/prize_entity.dart';

import 'payment_history_entity.dart';

class ClientEntity
{
  final String id;
  final String name;
  final String? lastPrizeDate;
  List<PrizeEntity> ?prizes;
  List<PaymentHistoryEntity> ?paymentHistory;

  ClientEntity({required this.id, required this.name,  this.lastPrizeDate,this.paymentHistory,this.prizes});


}