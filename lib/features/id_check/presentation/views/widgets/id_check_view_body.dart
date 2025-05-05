import 'package:bingo_with_coca/core/helper_function/build_error_bar.dart';
import 'package:bingo_with_coca/core/widgets/custom_text_field.dart'
    show CustomTextFormField;
import 'package:bingo_with_coca/features/add_all_clients/presentation/views/add_all_clients_view.dart';
import 'package:bingo_with_coca/features/add_client_data/presentation/views/add_client_view.dart';
import 'package:bingo_with_coca/features/id_check/presentation/cubits/check_id_cubit/check_id_cubit.dart';
import 'package:bingo_with_coca/features/prize_select/presentation/views/select_prize.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/app_text_styles.dart';
import '../../../../payment_history/presentation/views/payment_history_view.dart';

class IdCheckViewBody extends StatefulWidget {
  const IdCheckViewBody({super.key});

  @override
  State<IdCheckViewBody> createState() => _IdCheckViewBodyState();
}

class _IdCheckViewBodyState extends State<IdCheckViewBody> {
  late String id;
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return BlocListener<CheckIdCubit, CheckIdState>(
      listener: (context, state) {
        if(state is GetClientFailure)
          {
            buildErrorBar(context, 'حدث خطأ برجاء اعادة المحاولة');
          }
      },
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: autoValidateMode,
          key: globalKey,
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
                    'البحث عن '
                        'رقم بطاقة او هاتف العميل',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bold40.copyWith(color: Colors.white),
                  ),
                ),

              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomTextFormField(
                  onChanged: (value){
                    globalKey.currentState!.validate();
                  },
                  hint: 'الرقم القومى او رقم الهاتف للعميل',
                  keyboardType: TextInputType.number,
                  suffixIcon: Image.asset(
                    'assets/images/ID Check Icon.png',
                    width: 20,
                    height: 20,
                  ),
                  onSaved: (value) {
                    id = value!;
                  },
                  validator: (value) {
                    if (value!.isEmpty ) {
                      return 'هذا الحقل مطلوب';
                    }
                    if(!RegExp(r'^[0-9]+$').hasMatch(value))
                    {
                      return 'من فضلك ادخل ارقام انجليزية فقط';
                    }

                    else
                      {
                        if (value.length < 11) {
                          return 'قيمة غير صالحه';
                        }
                        else if(value.length==12||value.length==13)
                        {
                          return 'قيمة غير صالحه';
                        }

                        else if (value.length > 14) {
                          return 'رقم قومي غير صالح';
                        }

                      }


                    return null;
                  },

                ),
              ),
              const SizedBox(height: 40,),

              GestureDetector(
                onTap: () async {

                  if (globalKey.currentState!.validate()) {
                    globalKey.currentState!.save();
                    await CheckIdCubit.get(context).checkId(id);
                    if (CheckIdCubit
                        .get(context)
                        .isFound!=null&&CheckIdCubit.get(context).isFound==true) {
                      await CheckIdCubit.get(context).canWinMore(id);
                      await CheckIdCubit.get(context).getClientData(id);
                      if (CheckIdCubit
                          .get(context)
                          .canWin) {
                        await CheckIdCubit.get(context).checkWin(id);
                        if (CheckIdCubit
                            .get(context)
                            .isWin) {
                          CheckIdCubit.get(context).isFound=null;
                          ScaffoldMessenger.of(context).clearSnackBars();
                          Navigator.pushNamed(context, SelectPrizeView.routeName,arguments: CheckIdCubit.get(context).clientEntity!);


                        }
                        else {
                          if(CheckIdCubit.get(context).clientEntity!=null)
                            {
                              CheckIdCubit.get(context).isFound=null;
                              ScaffoldMessenger.of(context).clearSnackBars();
                              Navigator.pushNamed(context, PaymentHistoryView.routeName,arguments: CheckIdCubit.get(context).clientEntity!);
                            }


                        }
                      }
                      else {
                        buildErrorBar(context,
                            'هذا المستخدم لا يمكنه الفوز بجوائز هذا الشهر');
                      }
                    }
                    else {
                      if(CheckIdCubit.get(context).isFound==false) {
                        CheckIdCubit.get(context).isFound=null;
                        ScaffoldMessenger.of(context).clearSnackBars();
                        Navigator.pushNamed(
                            context,
                            AddClientView.routeName,
                            arguments: id
                        );

                      }
                      else if(CheckIdCubit.get(context).isFound==null)
                        {
                          buildErrorBar(context, 'حدث خطا برجاء اعادة المحاولة');
                        }
                    }
                  }
                  else {
                    autoValidateMode = AutovalidateMode.always;
                  }
                },
                child: Image.asset(
                  'assets/images/التحقق.png',
                  width: 200,
                  height: 100,
                ),
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){
                  ScaffoldMessenger.of(context).clearSnackBars();
                  Navigator.pushNamed(context, AddAllClientsView.routeName);
                },
                child: Image.asset(
                  'assets/images/احصاء عدد العملاء.png',
                  width: 200,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
