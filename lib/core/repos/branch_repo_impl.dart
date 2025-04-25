import 'package:bingo_with_coca/core/cubits/errors/faliures.dart';

import 'package:bingo_with_coca/core/entites/branch_entity.dart';
import 'package:bingo_with_coca/core/models/branch_model.dart';
import 'package:bingo_with_coca/core/utils/backend_end_points.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:dartz/dartz.dart';

import 'branch_repo.dart';

class BranchRepoImpl implements BranchRepo{

 
  @override
  Future<Either<Failure, List<BranchEntity>>> getAllBranches() async{
    try{
       var data=await FirebaseFirestore.instance.collection(BackendEndPoints.getAllBranches).get();
       List<BranchEntity> result=[];
       data.docs.forEach((e){
         BranchModel model=BranchModel(id: e.id, name: e.data()['id']);
         result.add(model.toEntity());
       });
       return Right(result);
    }
    catch(e){
      return Left(
        ServerFailure(e.toString())
      );
    }
   
  }
  
}