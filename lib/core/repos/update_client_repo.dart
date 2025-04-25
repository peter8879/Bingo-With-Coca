import 'package:bingo_with_coca/core/cubits/errors/faliures.dart';
import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:dartz/dartz.dart';

abstract class UpdateClientRepo
{
  Future<Either<Failure,void>> updateClient(ClientEntity clientEntity);
}