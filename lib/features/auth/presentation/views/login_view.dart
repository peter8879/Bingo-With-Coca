import 'package:bingo_with_coca/core/cubits/branches_cubit/branches_cubit.dart';
import 'package:bingo_with_coca/core/services/get_it_service.dart';
import 'package:bingo_with_coca/core/widgets/background_image.dart';
import 'package:bingo_with_coca/features/auth/domain/auth_repo.dart';
import 'package:bingo_with_coca/features/auth/presentation/cuibits/auth_cuibit/auth_cubit.dart';
import 'package:bingo_with_coca/features/auth/presentation/views/widgets/login_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String routeName = 'login_view';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(getIt.get<AuthRepo>()),
      child: BackgroundImage(
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: BlocBuilder<BranchesCubit, BranchesState>(
            builder: (context, state) {
              if (state is BranchesLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                  ),
                );
              }
              else if (state is BranchesError) {
                return Center(
                  child: Text('Error: ${state.error}'),
                );
              }
              return const LoginViewBody();
            },
          ),

        ),
      ),
    );
  }
}
