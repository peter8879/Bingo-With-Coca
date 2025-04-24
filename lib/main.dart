

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/cubits/branches_cubit/branches_cubit.dart';
import 'core/helper_function/on_generete_routes.dart';
import 'core/repos/branch_repo.dart';
import 'core/services/get_it_service.dart';
import 'firebase_options.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setup();
  runApp(const BingoWithCoca());
}

class BingoWithCoca extends StatelessWidget {
  const BingoWithCoca({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BranchesCubit(getIt.get<BranchRepo>())..getAllBranches(),
      child: MaterialApp(

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Arb',
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffE4002B)),
        ),
        locale: const Locale('ar'),
        localizationsDelegates:  const [
          S.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        onGenerateRoute: onGenerateRoute,


      ),
    );
  }
}

