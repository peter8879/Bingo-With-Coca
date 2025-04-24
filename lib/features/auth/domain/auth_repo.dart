import 'package:bingo_with_coca/core/cubits/errors/faliures.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo
{
  Future<Either<Failure,bool>> login({required String userId,required String branch});
}