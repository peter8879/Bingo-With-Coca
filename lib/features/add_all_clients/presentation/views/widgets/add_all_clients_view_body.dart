import 'package:bingo_with_coca/core/helper_function/build_error_bar.dart';
import 'package:bingo_with_coca/features/add_all_clients/presentation/cubits/add_all_clients_cubit/add_all_clients_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/helper_function/build_success_bar.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../id_check/presentation/views/id_check_view.dart';

class AddAllClientsViewBody extends StatefulWidget {
  const AddAllClientsViewBody({super.key});

  @override
  State<AddAllClientsViewBody> createState() => _AddAllClientsViewBodyState();
}

class _AddAllClientsViewBodyState extends State<AddAllClientsViewBody> {
  late String numberOfClients;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddAllClientsCubit, AddAllClientsState>(
      listener: (context, state) {
        if(state is AddAllClientsSuccess)
          {
            ScaffoldMessenger.of(context).clearSnackBars();
            Navigator.pushNamedAndRemoveUntil(context, IdCheckView.routeName,
                  (route) => false,
            );
            buildSuccessBar(context, 'تم اضافة العدد بنجاح');
          }
        else if(state is AddAllClientsFailure)
          {
            buildErrorBar(context, state.message);
          }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is AddAllClientsLoading?true:false,
          child: SingleChildScrollView(
            child: Form(
              key: globalKey,
              autovalidateMode: autoValidateMode,
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery
                        .sizeOf(context)
                        .height * 0.3,
                  ),
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Text(
                        'أضافه عدد عملاء جديد لليوم',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bold40.copyWith(color: Colors
                            .white, fontSize: 33),
                      ),
                    ),

                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      'إنتبه يمكنك تسجيل عدد العملاء مرة واحدة في اليوم!!',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.bold40.copyWith(color: Colors
                          .black, fontSize: 14),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: CustomTextFormField(
                      hint: 'عدد العملاء',
                      keyboardType: TextInputType.number,
                      suffixIcon: Image.asset(
                        'assets/images/ID Icon.png',
                        width: 20,
                        height: 20,
                      ),
                      onSaved: (value) {
                        numberOfClients = value!;
                      },

                    ),
                  ),
                  const SizedBox(height: 20,),
                  GestureDetector(
                    onTap: (){
                      if(globalKey.currentState!.validate())
                      {
                        globalKey.currentState!.save();
                        AddAllClientsCubit.get(context).addAllClients(int.parse(numberOfClients));
                      }
                      else
                      {
                        autoValidateMode=AutovalidateMode.always;

                      }

                    },
                    child: Image.asset(
                      'assets/images/تسجيل.png',
                      width: 200,
                      height: 100,
                    ),
                  )
                ],

              ),
            ),
          ),
        );
      },
    );
  }
}
