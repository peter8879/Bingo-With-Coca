import 'package:dartz/dartz.dart';

import '../cubits/errors/faliures.dart';


abstract class UploadImageRepo
{
  Future<Either<Failure,String>>uploadImage(dynamic image);
}