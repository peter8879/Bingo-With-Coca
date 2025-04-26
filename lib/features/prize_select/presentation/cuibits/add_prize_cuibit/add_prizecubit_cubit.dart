import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/repos/update_client_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'add_prizecubit_state.dart';

class AddPrizeCubit extends Cubit<AddPrizeState> {
  UpdateClientRepo updateClientRepo;
  AddPrizeCubit(this.updateClientRepo) : super(AddPrizeInitial());
  static AddPrizeCubit get(context) => BlocProvider.of(context);
  Future<void> addPrize(ClientEntity clientEntity)async{
    emit(AddPrizeLoading());
    var result=await updateClientRepo.updateClient(clientEntity);
    //fold result
    result.fold((failure) {
      emit(AddPrizeFailure(failure.message));
    }, (success) {
      emit(AddPrizeSuccess());
    });
  }
}
