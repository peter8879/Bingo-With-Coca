import 'package:bingo_with_coca/features/auth/presentation/views/login_view.dart';
import 'package:bingo_with_coca/features/id_check/presentation/views/id_check_view.dart';
import 'package:flutter/material.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings)
{
  switch(settings.name)
  {
    case LoginView.routeName:
      return MaterialPageRoute(builder: (_) => const LoginView());
    case IdCheckView.routeName:
      return MaterialPageRoute(builder: (_) => const IdCheckView());


    default:
      return MaterialPageRoute(builder: (_) => const LoginView());
  }

}