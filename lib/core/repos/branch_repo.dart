import 'package:dartz/dartz.dart';

import '../cubits/errors/faliures.dart';
import '../entites/branch_entity.dart';

abstract class BranchRepo{
Future<Either<Failure, List<BranchEntity>>> getAllBranches();
}