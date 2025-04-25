import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/features/add_client_data/domain/repo/add_client_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'add_client_state.dart';

class AddClientCubit extends Cubit<AddClientState> {
  AddClientRepo addClientRepo;
  AddClientCubit(this.addClientRepo) : super(AddClientInitial());
  static AddClientCubit get(context) => BlocProvider.of(context);
  void AddClient(ClientEntity client)async
  {
    emit(AddClientLoading());
    var result=await addClientRepo.addClient(client);
    result.fold((l) {
      emit(AddClientFailure(l.message));
    }, (r) {
      emit(AddClientSuccess(clientEntity: client));
    });
  }
}
