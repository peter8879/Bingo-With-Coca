import 'package:bingo_with_coca/constants.dart';
import 'package:bingo_with_coca/core/cubits/branches_cubit/branches_cubit.dart';
import 'package:bingo_with_coca/core/helper_function/build_error_bar.dart';
import 'package:bingo_with_coca/core/utils/app_text_styles.dart';
import 'package:bingo_with_coca/core/widgets/custom_text_field.dart';
import 'package:bingo_with_coca/features/auth/presentation/cuibits/auth_cuibit/auth_cubit.dart';
import 'package:bingo_with_coca/features/auth/presentation/views/widgets/choice_widget.dart';
import 'package:bingo_with_coca/features/id_check/presentation/views/id_check_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocListener;

class LoginViewBody extends StatefulWidget {
  const LoginViewBody({super.key});

  @override
  State<LoginViewBody> createState() => _LoginViewBodyState();
}

class _LoginViewBodyState extends State<LoginViewBody> {
  late String value;
  late String user;
  AutovalidateMode autoValidateMode=AutovalidateMode.disabled;
  GlobalKey<FormState> globalKey=GlobalKey();
  @override
  void initState() {
    value=BranchesCubit.get(context).branches[0].name;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
  listener: (context, state) {
    if(state is AuthSuccess)
      {
        Navigator.pushReplacementNamed(context, IdCheckView.routeName);
      }
    else if(state is AuthFailure)
      {
        buildErrorBar(context, state.errorMessage);
      }
  },
  child: Center(
      child: SingleChildScrollView(
        child: Form(
          autovalidateMode: autoValidateMode,
          key: globalKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.sizeOf(context).height*0.2,
              ),
              Center(
                child: Text(
                  'بيانات الدخول',
                  style: AppTextStyles.bold40.copyWith(color: Colors.white),
                ),
          
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: CustomTextFormField(
                  hint: 'اسم المستخدم',
                  keyboardType: TextInputType.text,
                  suffixIcon: Image.asset(
                    'assets/images/User ID Icon.png',
                    width: 20,
                    height: 20,
                  ),
                  onSaved: (value)
                  {
                    user=value!;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ChoiceWidget(
                  value:value ,
                  onChanged: (value){
                    setState(() {
                      this.value = value!;
                    });
          
                  },
                ),
              ),
              GestureDetector(
                onTap: (){
                  if(globalKey.currentState!.validate()){
                    globalKey.currentState!.save();
                    String branchId='';
                    for(int i=0;i<BranchesCubit.get(context).branches.length;i++)
                      {
                        if(BranchesCubit.get(context).branches[i].name==value)
                          {
                            branchId=BranchesCubit.get(context).branches[i].id;
                            break;
                          }
                      }
                    AuthCubit.get(context).login(userId: user, branchId: branchId);
                  }
                  else
                    {
                      autoValidateMode=AutovalidateMode.always;
                    }
                  
                },
                child: Image.asset(
                  'assets/images/تسجيل الدخول.png',
                  width: 200,
                  height: 200,
                ),
              ),
          
          
            ],
          ),
        ),
      ),
    ),
);
  }
}
