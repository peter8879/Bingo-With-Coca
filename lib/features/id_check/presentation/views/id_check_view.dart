import 'package:bingo_with_coca/core/repos/get_client__repo.dart';
import 'package:bingo_with_coca/core/services/get_it_service.dart';
import 'package:bingo_with_coca/core/widgets/background_image.dart';
import 'package:bingo_with_coca/features/id_check/domain/check_id_repo.dart';
import 'package:bingo_with_coca/features/id_check/presentation/cubits/check_id_cubit/check_id_cubit.dart';
import 'package:bingo_with_coca/features/id_check/presentation/views/widgets/id_check_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class IdCheckView extends StatelessWidget {
  const IdCheckView({super.key});

  static const String routeName = 'id-check';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CheckIdCubit(getIt.get<CheckIdRepo>(),getIt<GetClientRepo>()),
      child: const BackgroundImage(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: IdCheckViewBody(),

        ),
      ),
    );
  }
}
