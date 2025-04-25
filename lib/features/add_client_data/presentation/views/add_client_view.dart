import 'package:bingo_with_coca/core/services/get_it_service.dart';
import 'package:bingo_with_coca/core/widgets/background_image.dart';
import 'package:bingo_with_coca/features/add_client_data/domain/repo/add_client_repo.dart';
import 'package:bingo_with_coca/features/add_client_data/presentation/cuibits/add_client_cubit/add_client_cubit.dart';
import 'package:bingo_with_coca/features/add_client_data/presentation/views/widgets/add_client_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddClientView extends StatelessWidget {
  const AddClientView({super.key, required this.id});

  static const String routeName = 'add_client_view';
  final String id;


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddClientCubit(getIt<AddClientRepo>()),
      child: BackgroundImage(
        child: Scaffold(
          body: AddClientViewBody(id: id,),
          backgroundColor: Colors.transparent,

        ),
      ),
    );
  }
}
