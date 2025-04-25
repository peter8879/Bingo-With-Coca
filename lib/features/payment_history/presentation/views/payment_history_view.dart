import 'package:bingo_with_coca/core/cubits/update_client_cubit/update_client_cubit.dart';
import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/repos/update_client_repo.dart';
import 'package:bingo_with_coca/core/services/get_it_service.dart';
import 'package:bingo_with_coca/core/widgets/background_image.dart';
import 'package:bingo_with_coca/features/payment_history/presentation/views/widgets/payment_history_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentHistoryView extends StatelessWidget {
  const PaymentHistoryView({super.key, required this.clientEntity});

  static const String routeName = 'payment_history';
  final ClientEntity clientEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateClientCubit(getIt<UpdateClientRepo>()),
      child: BackgroundImage(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: PaymentHistoryViewBody(clientEntity: clientEntity),
        ),
      ),
    );
  }
}
