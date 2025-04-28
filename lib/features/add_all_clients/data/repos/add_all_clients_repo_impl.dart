import 'package:bingo_with_coca/constants.dart';
import 'package:bingo_with_coca/core/cubits/errors/faliures.dart';
import 'package:bingo_with_coca/core/services/data_base_service.dart';
import 'package:bingo_with_coca/core/utils/backend_end_points.dart';
import 'package:bingo_with_coca/features/add_all_clients/domain/repos/add_all_clients_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:intl/intl.dart';

class AddAllClientsRepoImpl implements AddAllClientsRepo
{
  DataBaseService dataBaseService;
  AddAllClientsRepoImpl({required this.dataBaseService});
  @override
  Future<Either<Failure, void>> addAllClientsForToday(int numberOfClients) async{
    try{
      Map<String,dynamic> date={};
      if(await dataBaseService.ifDataExist(id:DateFormat('dd-MM-yyyy').format(DateTime.now()) , path: BackendEndPoints.checkDateAdded))
      {
        var getItData=await dataBaseService.getData(
          path: BackendEndPoints.getDate,
          id: DateFormat('dd-MM-yyyy').format(DateTime.now())
        );
        date=getItData as Map<String,dynamic>;
        date[branch]=numberOfClients;
      }
      else
        {
          date={
            branch:numberOfClients
          };
        }
      var result=await dataBaseService.addData(
        path: BackendEndPoints.addDate,
        data:date ,
        documentId: DateFormat('dd-MM-yyyy').format(DateTime.now())

      );
      return Right(result);

    }
    catch(e)
    {
      return Left(ServerFailure(e.toString()));

    }
  }

  @override
  Future<Either<Failure, bool>> checkIfAlreadyAdded() async{
  try{
    var result=await dataBaseService.ifDataExist(
        id: DateFormat('dd-MM-yyyy').format(DateTime.now()),
        path: BackendEndPoints.checkDateAdded
    );
    if(result)
      {
        var data=await dataBaseService.getData(path: BackendEndPoints.getDate,id:DateFormat('dd-MM-yyyy').format(DateTime.now()) );
        if(data[branch]!=null)
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
  catch(e)
    {
      return Left(ServerFailure(e.toString()));
    }
  }
  
}