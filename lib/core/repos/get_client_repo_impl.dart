import 'package:bingo_with_coca/core/cubits/errors/faliures.dart';
import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/models/client_model.dart';
import 'package:bingo_with_coca/core/repos/get_client__repo.dart';
import 'package:bingo_with_coca/core/services/data_base_service.dart';
import 'package:bingo_with_coca/core/utils/backend_end_points.dart';
import 'package:dartz/dartz.dart';

class GetClientRepoImpl implements GetClientRepo
{
  DataBaseService dataBaseService;
  GetClientRepoImpl({required this.dataBaseService});
  @override
  Future<Either<Failure, ClientEntity>> getClient(String clientId) async{
    try{
      var result=await dataBaseService.getData(path: BackendEndPoints.getClient,id: clientId);
      ClientModel clientModel=ClientModel.fromJson(result);
      return Right(clientModel.toEntity());

    }
    catch(e)
    {
      return Left(ServerFailure(e.toString()));

    }
  }

}