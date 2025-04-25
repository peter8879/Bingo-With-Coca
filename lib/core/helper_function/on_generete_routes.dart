import 'package:bingo_with_coca/features/add_client_data/presentation/views/add_client_view.dart';
import 'package:bingo_with_coca/features/auth/presentation/views/login_view.dart';
import 'package:bingo_with_coca/features/id_check/presentation/views/id_check_view.dart';
import 'package:bingo_with_coca/features/prize_select/presentation/views/select_prize.dart';
import 'package:flutter/material.dart';

import '../../features/payment_history/presentation/views/payment_history_view.dart';
import '../entites/client_entity.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings)
{
  switch(settings.name)
  {
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case IdCheckView.routeName:
      return MaterialPageRoute(builder: (_) => const IdCheckView());
    case AddClientView.routeName:
    return MaterialPageRoute(builder: (_) =>  AddClientView(
      id:  settings.arguments as String,
    ));
    case PaymentHistoryView.routeName:
      return MaterialPageRoute(builder: (_) =>  PaymentHistoryView(
        clientEntity: settings.arguments as ClientEntity,
      ));
    case SelectPrizeView.routeName:
      return MaterialPageRoute(builder: (_) =>  SelectPrizeView(
        clientEntity: settings.arguments as ClientEntity,
      ));



    default:
      return MaterialPageRoute(builder: (_) => const LoginView());
  }

}