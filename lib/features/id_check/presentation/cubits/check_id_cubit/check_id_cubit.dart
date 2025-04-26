import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/repos/get_client__repo.dart';
import 'package:bingo_with_coca/features/id_check/domain/check_id_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'check_id_state.dart';

class CheckIdCubit extends Cubit<CheckIdState> {
  CheckIdRepo checkIdRepo;
  GetClientRepo getClientRepo;
  bool isWin=false;
   bool? isFound;
  bool canWin=false;
  ClientEntity? clientEntity;
  CheckIdCubit(this.checkIdRepo,this.getClientRepo) : super(CheckIdInitial());
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
      emit(CheckIdFailure(l.message));

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
  Future<void> getClientData(String id)async
  {
    emit(GetClientLoading());
    var result=await getClientRepo.getClient(id);
    result.fold((l) {
      emit(GetClientFailure(l.message));
    }, (r) {
      clientEntity=r;
      emit(GetClientSuccess(r));

    });

  }
  void setFound()
  {
    isFound=true;
  }


}
