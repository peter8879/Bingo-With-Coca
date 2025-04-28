import 'package:bingo_with_coca/core/services/get_it_service.dart';
import 'package:bingo_with_coca/core/widgets/background_image.dart';
import 'package:bingo_with_coca/features/add_all_clients/domain/repos/add_all_clients_repo.dart';
import 'package:bingo_with_coca/features/add_all_clients/presentation/cubits/add_all_clients_cubit/add_all_clients_cubit.dart';
import 'package:bingo_with_coca/features/add_all_clients/presentation/views/widgets/add_all_clients_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddAllClientsView extends StatelessWidget {
  const AddAllClientsView({super.key});
  static const String routeName = 'addAllClientsView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddAllClientsCubit(getIt<AddAllClientsRepo>()),
      child: const BackgroundImage(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: AddAllClientsViewBody(),
        ),
      ),
    );
  }
}
