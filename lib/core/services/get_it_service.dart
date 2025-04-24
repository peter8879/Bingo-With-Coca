import 'package:bingo_with_coca/core/repos/branch_repo.dart';
import 'package:bingo_with_coca/core/repos/branch_repo_impl.dart';
import 'package:bingo_with_coca/core/services/data_base_service.dart';
import 'package:bingo_with_coca/core/services/fire_store_service.dart';
import 'package:bingo_with_coca/features/auth/data/repos/auth_repo_impl.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/domain/auth_repo.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<BranchRepo>(BranchRepoImpl());
  getIt.registerSingleton<DataBaseService>(FireStoreService());
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
      dataBaseService: getIt<DataBaseService>(),
  ));


}