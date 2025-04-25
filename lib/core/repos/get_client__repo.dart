import 'package:dartz/dartz.dart';

import '../cubits/errors/faliures.dart';
import '../entites/client_entity.dart';

abstract class GetClientRepo {
 Future<Either<Failure, ClientEntity>> getClient(String clientId);
}