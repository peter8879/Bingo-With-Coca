import 'package:bingo_with_coca/core/cubits/errors/faliures.dart';
import 'package:dartz/dartz.dart';

abstract class CheckIdRepo{
  Future<Either<Failure,bool>> isIdFound(String id);
  Future<Either<Failure,bool>> isWin(String id);
}