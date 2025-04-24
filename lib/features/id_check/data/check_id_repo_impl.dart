import 'package:bingo_with_coca/core/cubits/errors/faliures.dart';
import 'package:bingo_with_coca/core/models/client_model.dart';
import 'package:bingo_with_coca/core/services/data_base_service.dart';
import 'package:bingo_with_coca/core/utils/backend_end_points.dart';
import 'package:bingo_with_coca/features/id_check/domain/check_id_repo.dart';
import 'package:dartz/dartz.dart';

class CheckIdRepoImpl implements CheckIdRepo{
  DataBaseService dataBaseService;
  CheckIdRepoImpl(this.dataBaseService);
  @override
  Future<Either<Failure, bool>> isIdFound(String id) async{
    try{
      bool isFound=await dataBaseService.ifDataExist(id: id, path: BackendEndPoints.ifClientExist);
      return Right(isFound);
    }
    catch(e){
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, bool>> isWin(String id) async{
  try{
    bool isFound = await dataBaseService.ifDataExist(id: id, path: BackendEndPoints.ifClientExist);
    if(isFound)
      {
        var data=await dataBaseService.getData(id: id, path: BackendEndPoints.getClient);
        ClientModel model=ClientModel.fromJson(data);
        if(model.paymentHistory!.length==3)
          {
            return Right(true);
          }
        else
          {
            return Right(false);
          }

      }
    else
      {
        return Right(false);
      }

  }
  catch(e){
    return Left(ServerFailure(e.toString()));
  }

  }

}