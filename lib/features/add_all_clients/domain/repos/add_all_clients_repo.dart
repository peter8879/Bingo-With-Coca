import 'package:bingo_with_coca/core/cubits/errors/faliures.dart';
import 'package:dartz/dartz.dart';

abstract class AddAllClientsRepo
{
  Future<Either<Failure,void>>addAllClientsForToday(int numberOfClients);
  Future<Either<Failure,bool>>checkIfAlreadyAdded();
}