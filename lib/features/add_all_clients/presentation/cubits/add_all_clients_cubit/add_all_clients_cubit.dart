import 'package:bingo_with_coca/features/add_all_clients/domain/repos/add_all_clients_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'add_all_clients_state.dart';

class AddAllClientsCubit extends Cubit<AddAllClientsState> {
  AddAllClientsCubit(this.addAllClientsRepo) : super(AddAllClientsInitial());
 final AddAllClientsRepo addAllClientsRepo;
  static AddAllClientsCubit get(context) => BlocProvider.of(context);
  void addAllClients(int numberOfClients)async
  {
    emit(AddAllClientsLoading());
    var result=await addAllClientsRepo.checkIfAlreadyAdded();
    result.fold((failure) {
      emit(AddAllClientsFailure("حدث خطا اثناء الاضافة"));
    }, (isAlreadyAdded) async {
      if(isAlreadyAdded)
        {
          emit(AddAllClientsFailure('تم اضافة عدد عملاء لليوم بالفعل'));
        }
      else
        {

          var data=await addAllClientsRepo.addAllClientsForToday(numberOfClients);
          data.fold(
              (l){
                emit(AddAllClientsFailure("حدث خطا اثناء الاضافة"));
              },
              (r){
                emit(AddAllClientsSuccess());
              }
          );

        }
    });

  }
}
