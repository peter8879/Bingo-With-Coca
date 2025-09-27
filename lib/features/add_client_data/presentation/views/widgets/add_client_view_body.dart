import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/helper_function/build_error_bar.dart';
import 'package:bingo_with_coca/core/helper_function/build_success_bar.dart';
import 'package:bingo_with_coca/core/utils/app_text_styles.dart' show AppTextStyles;
import 'package:bingo_with_coca/core/widgets/custom_text_field.dart' show CustomTextFormField;
import 'package:bingo_with_coca/features/add_client_data/presentation/cuibits/add_client_cubit/add_client_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../payment_history/presentation/views/payment_history_view.dart';

class AddClientViewBody extends StatefulWidget {
  const AddClientViewBody({super.key, required this.id});
  final String id;

  @override
  State<AddClientViewBody> createState() => _AddClientViewBodyState();
}

class _AddClientViewBodyState extends State<AddClientViewBody> {
  late String name;
  late String phoneNumber;
  AutovalidateMode autoValidateMode=AutovalidateMode.disabled;
  GlobalKey<FormState> globalKey=GlobalKey();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddClientCubit, AddClientState>(
  listener: (context, state) {
   if(state is AddClientSuccess)
     {
       ScaffoldMessenger.of(context).clearSnackBars();
       Navigator.pushNamed(context, PaymentHistoryView.routeName,arguments: state.clientEntity );
       buildSuccessBar(context, 'تم اضافة العميل بنجاح');

     }
   if(state is AddClientFailure)
     {
       buildErrorBar(context, state.errorMessage);
     }
  },
  builder: (context, state) {
    return ModalProgressHUD(
      inAsyncCall: state is AddClientLoading?true:false,
      child: SingleChildScrollView(
        child:Form(
          key: globalKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height*0.3,
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Text(
                    'أضافه عميل جديد',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bold40.copyWith(color: Colors.white),
                  ),
                ),

              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomTextFormField(
                  hint: 'أسم العميل',
                  keyboardType: TextInputType.text,
                  suffixIcon: Image.asset(
                    'assets/images/ID Icon.png',
                    width: 20,
                    height: 20,
                  ),
                  onSaved: (value)
                  {
                    name=value!;

                  },

                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomTextFormField(
                  hint: 'رقم هاتف العميل',
                  keyboardType: TextInputType.phone,
                  suffixIcon: Image.asset(
                    'assets/images/ID Icon.png',
                    width: 20,
                    height: 20,
                  ),
                  onSaved: (value)
                  {
                    phoneNumber=value!;

                  },
                  validator: (value){

                    if (value!.isEmpty ) {
                      return 'هذا الحقل مطلوب';
                    }
                    if(!RegExp(r'^[0-9]+$').hasMatch(value))
                    {
                      return 'من فضلك ادخل ارقام انجليزية فقط';
                    }
                    else
                      {
                        if(!isValidEgyptianPhoneNumber(value))
                          {
                            return 'رقم هاتف غير صالح';
                          }
                      }

                    return null;
                  },

                ),
              ),
              GestureDetector(
                onTap: (){
                  if(globalKey.currentState!.validate())
                    {
                      globalKey.currentState!.save();
                      ClientEntity client=ClientEntity(
                        id: widget.id,
                        name: name,
                        phoneNumber: phoneNumber
                      );
                      AddClientCubit.get(context).AddClient(client);
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
/// Validates an 11-digit Egyptian mobile phone number.
/// Returns true if the number is valid, false otherwise.
bool isValidEgyptianPhoneNumber(String input) {
  // Regex for 11-digit Egyptian phone numbers (01xxxxxxxxx)
  final RegExp phoneRegex = RegExp(r'^01[0125]\d{8}$');

  return phoneRegex.hasMatch(input);
}

