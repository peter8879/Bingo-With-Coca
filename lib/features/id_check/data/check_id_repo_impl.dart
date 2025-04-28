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
    return Left(ServerFailure(e.toString()));
  }

  }

  @override
  Future<Either<Failure, bool>> canWinMore(String id) async{
    try{
      bool isFound = await dataBaseService.ifDataExist(id: id, path: BackendEndPoints.ifClientExist);
      if(isFound)
      {
        var data=await dataBaseService.getData(id: id, path: BackendEndPoints.getClient);
        ClientModel model=ClientModel.fromJson(data);

        if(model.lastPrizeDate==null)
        {
          return const Right(true);
        }
        else
        {
         var now=DateTime.now();

          DateTime lastPrizeDate = DateTime.parse(model.lastPrizeDate!);
          var difference = now.difference(lastPrizeDate);

          if(lastPrizeDate.year == now.year && lastPrizeDate.month < now.month)
          {
            return const Right(true);
          }
          else if(lastPrizeDate.year == now.year && lastPrizeDate.month == now.month)
          {

            return const Right(false);
          }
          else
            {
              return const Right(false);
            }
        }

      }
      else
      {
        return const Right(true);
      }

    }
    catch(e){
      return Left(ServerFailure(e.toString()));
    }

  }

}