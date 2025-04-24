import 'package:bingo_with_coca/core/helper_function/build_error_bar.dart';
import 'package:bingo_with_coca/core/widgets/custom_text_field.dart' show CustomTextFormField;
import 'package:bingo_with_coca/features/id_check/presentation/cubits/check_id_cubit/check_id_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_text_styles.dart';

class IdCheckViewBody extends StatefulWidget {
  const IdCheckViewBody({super.key});

  @override
  State<IdCheckViewBody> createState() => _IdCheckViewBodyState();
}

class _IdCheckViewBodyState extends State<IdCheckViewBody> {
  late String id;
  AutovalidateMode autoValidateMode=AutovalidateMode.disabled;
  GlobalKey<FormState> globalKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: autoValidateMode,
          key: globalKey,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height*0.1,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'البحث عن '
                        'رقم بطاقة العميل',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bold40.copyWith(color: Colors.white),
                  ),
                ),

              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomTextFormField(
                  hint: 'الرقم القومى للعميل',
                  keyboardType: TextInputType.number,
                  suffixIcon: Image.asset(
                    'assets/images/ID Check Icon.png',
                    width: 20,
                    height: 20,
                  ),
                  onSaved: (value)
                  {
                    id=value!;
                  },
                  validator: (value)
                  {
                    if(value!.isEmpty||value==null)
                    {
                      return 'هذا الحقل مطلوب';
                    }
                    else if(value.length<14)
                      {
                        return 'رقم قومي غير صالح';
                      }
                    return null;

                  },
                ),
              ),

              GestureDetector(
                onTap: ()async {
                 print(DateTime.now().toIso8601String());
                  if(globalKey.currentState!.validate())
                    {
                      globalKey.currentState!.save();
                      await CheckIdCubit.get(context).checkId(id);
                      if(CheckIdCubit.get(context).isFound)
                        {
                          await CheckIdCubit.get(context).canWinMore(id);
                          if(CheckIdCubit.get(context).canWin) {
                            await CheckIdCubit.get(context).checkWin(id);
                            if (CheckIdCubit
                                .get(context)
                                .isWin) {

                            }
                            else {

                            }
                          }
                          else
                            {
                              buildErrorBar(context, 'هذا المستخدم لا يمكنه الفوز بجوائز هذا الشهر');
                            }
                        }
                      else
                        {


                        }


                    }
                  else
                    {
                      autoValidateMode=AutovalidateMode.always;
                    }

                },
                child: Image.asset(
                  'assets/images/التحقق.png',
                  width: 200,
                  height: 200,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
