import 'package:bingo_with_coca/core/repos/branch_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../entites/branch_entity.dart';

part 'branches_state.dart';

class BranchesCubit extends Cubit<BranchesState> {
  BranchesCubit(this.branchRepo) : super(BranchesInitial());
  final BranchRepo branchRepo;
  List<BranchEntity> branches = [];
  static BranchesCubit get(context) => BlocProvider.of(context);
  Future getAllBranches()async
  {

    emit(BranchesLoading());
    final result=await branchRepo.getAllBranches();
    result.fold((l) {
      emit(BranchesError(l.message));
    }, (r) async{
      branches = r;
      emit(BranchesLoaded());
    });
  }
}
