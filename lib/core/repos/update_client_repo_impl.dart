import 'package:bingo_with_coca/core/cubits/errors/faliures.dart';
import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/models/client_model.dart';
import 'package:bingo_with_coca/core/repos/update_client_repo.dart';
import 'package:bingo_with_coca/core/services/data_base_service.dart';
import 'package:dartz/dartz.dart';

import '../utils/backend_end_points.dart';

class UpdateClientRepoImpl implements UpdateClientRepo
{
  DataBaseService dataBaseService;
  UpdateClientRepoImpl({required this.dataBaseService});
  @override
  Future<Either<Failure, void>> updateClient(ClientEntity clientEntity)async {
    try{
      var result= await dataBaseService.updateData(
        path: BackendEndPoints.updateClient,
        data: ClientModel.fromEntity(clientEntity).toMap(),
        documentId: clientEntity.id
      );
      return Right(result);

    }
    catch(e)
    {
      return Left(ServerFailure(e.toString()));

    }
  }

}