import 'package:bingo_with_coca/core/cubits/errors/faliures.dart';
import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/models/client_model.dart';
import 'package:bingo_with_coca/core/services/data_base_service.dart';
import 'package:bingo_with_coca/core/utils/backend_end_points.dart';
import 'package:bingo_with_coca/features/add_client_data/domain/repo/add_client_repo.dart';
import 'package:dartz/dartz.dart';

class AddClientRepoImpl implements AddClientRepo
{
  DataBaseService dataBaseService;
  AddClientRepoImpl({required this.dataBaseService});

  @override
  Future<Either<Failure, void>> addClient(ClientEntity client) async{
    try{
      var result=await dataBaseService.addData(
          path: BackendEndPoints.addClient,
        data: ClientModel.fromEntity(client).toMap(),
        documentId: client.id
      );
      return Right(result);
    }
    catch(e)
    {
      return Left(ServerFailure(e.toString()));
    }

  }

}