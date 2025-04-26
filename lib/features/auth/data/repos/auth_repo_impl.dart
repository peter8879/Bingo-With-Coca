import 'package:bingo_with_coca/core/cubits/errors/faliures.dart' show Failure, ServerFailure;
import 'package:bingo_with_coca/core/utils/backend_end_points.dart';
import 'package:bingo_with_coca/features/auth/data/models/user_model.dart';
import 'package:bingo_with_coca/features/auth/domain/auth_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/services/data_base_service.dart';

class AuthRepoImpl implements AuthRepo
{
  final DataBaseService dataBaseService;

  AuthRepoImpl({required this.dataBaseService});
  @override
  Future<Either<Failure, bool>> login({required String userId, required String branch}) async{
   try{
     bool dataExist=await dataBaseService.ifDataExist(id: userId, path: BackendEndPoints.ifUserExist);

     if(dataExist)
       {
         var data=await dataBaseService.getData(path: BackendEndPoints.getUserData,id: userId);
         UserModel user= UserModel.fromJson(data);

         if(user.branch==branch)
           {
             var branchData=await dataBaseService.getData(path: BackendEndPoints.getBranchData,id: branch);
             branch= branchData['id'];
             return const Right(true);
           }
         else
           {
             return const Right(false);
           }




       }
     else
       {
         return const Right(false);
       }
   }
   catch(e){
     return Left(
        ServerFailure(e.toString())
     );

   }
  }

}