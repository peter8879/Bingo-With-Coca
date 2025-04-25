import 'package:bingo_with_coca/core/repos/branch_repo.dart';
import 'package:bingo_with_coca/core/repos/branch_repo_impl.dart';
import 'package:bingo_with_coca/core/repos/get_client__repo.dart';
import 'package:bingo_with_coca/core/repos/get_client_repo_impl.dart';
import 'package:bingo_with_coca/core/services/data_base_service.dart';
import 'package:bingo_with_coca/core/services/fire_store_service.dart';
import 'package:bingo_with_coca/features/add_client_data/data/add_client_repo_impl.dart';
import 'package:bingo_with_coca/features/add_client_data/domain/repo/add_client_repo.dart';
import 'package:bingo_with_coca/features/auth/data/repos/auth_repo_impl.dart';
import 'package:bingo_with_coca/features/id_check/data/check_id_repo_impl.dart';
import 'package:bingo_with_coca/features/id_check/domain/check_id_repo.dart';
import 'package:get_it/get_it.dart';

import '../../features/auth/domain/auth_repo.dart';
import '../repos/update_client_repo.dart';
import '../repos/update_client_repo_impl.dart';

final getIt = GetIt.instance;

void setup() {
  getIt.registerSingleton<BranchRepo>(BranchRepoImpl());
  getIt.registerSingleton<DataBaseService>(FireStoreService());
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
      dataBaseService: getIt<DataBaseService>(),
  ));
  getIt.registerSingleton<CheckIdRepo>(CheckIdRepoImpl(getIt<DataBaseService>()));
  getIt.registerSingleton<AddClientRepo>(AddClientRepoImpl(dataBaseService: getIt<DataBaseService>()));
  getIt.registerSingleton<GetClientRepo>(GetClientRepoImpl(dataBaseService: getIt<DataBaseService>() ));
  getIt.registerSingleton<UpdateClientRepo>(UpdateClientRepoImpl(dataBaseService: getIt<DataBaseService>()));


}