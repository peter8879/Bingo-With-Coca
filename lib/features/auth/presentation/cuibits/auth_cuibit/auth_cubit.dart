import 'package:bingo_with_coca/features/auth/domain/auth_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo authRepo;
  AuthCubit(this.authRepo) : super(AuthInitial());
  static AuthCubit get(context) => BlocProvider.of(context);
  void login({required String userId,required String branchId})async{

    emit(AuthLoading());
    var result= await authRepo.login(userId:userId , branch: branchId);

    result.fold((l) {
      emit(AuthFailure(l.message));
    }, (r) {
      if(r==true)
        {
          emit(AuthSuccess());
        }
      else
        {
          emit(AuthFailure(
            'أسم مستخدم او فرع خاطئ'
          ));

        }
    });


  }
}
