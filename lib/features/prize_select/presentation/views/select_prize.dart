import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/services/get_it_service.dart';
import 'package:bingo_with_coca/core/widgets/background_image.dart';
import 'package:bingo_with_coca/features/prize_select/presentation/views/widgets/select_prize_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/repos/update_client_repo.dart';
import '../cuibits/add_prize_cuibit/add_prizecubit_cubit.dart';

class SelectPrizeView extends StatelessWidget {
  const SelectPrizeView({super.key, required this.clientEntity});

  static const String routeName = 'selectPrize';
  final ClientEntity clientEntity;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddPrizeCubit(getIt<UpdateClientRepo>()),
      child: BackgroundImage(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SelectPrizeViewBody(
            clientEntity: clientEntity,
          ),

        ),
      ),
    );
  }
}
