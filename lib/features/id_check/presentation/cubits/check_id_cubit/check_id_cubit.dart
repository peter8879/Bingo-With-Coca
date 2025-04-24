import 'package:bingo_with_coca/features/id_check/domain/check_id_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'check_id_state.dart';

class CheckIdCubit extends Cubit<CheckIdState> {
  CheckIdRepo checkIdRepo;
  bool isWin=false;
  bool isFound=false;
  bool canWin=false;
  CheckIdCubit(this.checkIdRepo) : super(CheckIdInitial());
  static CheckIdCubit get(context) => BlocProvider.of(context);
  Future<void> checkId(String id) async{
    emit(CheckIdInitial());
    var result=await checkIdRepo.isIdFound(id);
    result.fold((l) {
      emit(CheckIdFailure(l.message));
    }, (r) {
      if(r){
        isFound=true;
        emit(CheckIdSuccess());


      }
      else{
        isFound=false;
        emit(CheckIdFailure('غير موجود'));

      }
    });




  }
  Future<void> checkWin(String id)async
  {
    var result=await checkIdRepo.isWin(id);
    result.fold((l) {

    }, (r) {
      if(r){
        isWin=true;

      }
      else{
        isWin=false;

      }
    });
  }
  Future<void> canWinMore(String id)async
  {
    var result=await checkIdRepo.canWinMore(id);
    result.fold((l) {
      emit(CheckIdFailure(l.message));
    }, (r) {
      if(r){
        canWin=true;

      }
      else{
        canWin=false;

      }
    });

  }


}
