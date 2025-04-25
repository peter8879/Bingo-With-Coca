import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/repos/update_client_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';


part 'update_client_state.dart';

class UpdateClientCubit extends Cubit<UpdateClientState> {
  UpdateClientRepo updateClientRepo;
  UpdateClientCubit(this.updateClientRepo) : super(UpdateClientInitial());
  static UpdateClientCubit get(context) => BlocProvider.of(context);
  Future<void> updateClient(ClientEntity clientEntity)async
  {
    emit(UpdateClientLoading());
    var result=await updateClientRepo.updateClient(clientEntity);
    result.fold((failure) {
      emit(UpdateClientFailure(failure.message));
    }, (success) {
      emit(UpdateClientSuccess());
    });
  }

}
