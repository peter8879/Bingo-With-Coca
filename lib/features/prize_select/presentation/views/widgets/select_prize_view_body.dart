import 'package:bingo_with_coca/constants.dart';
import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/entites/prize_entity.dart';
import 'package:bingo_with_coca/core/helper_function/build_error_bar.dart';
import 'package:bingo_with_coca/core/helper_function/build_success_bar.dart';
import 'package:bingo_with_coca/core/utils/app_text_styles.dart';
import 'package:bingo_with_coca/features/prize_select/presentation/views/widgets/prize_widget.dart';
import 'package:bingo_with_coca/features/id_check/presentation/views/id_check_view.dart';
import 'package:bingo_with_coca/features/prize_select/presentation/cuibits/add_prize_cuibit/add_prizecubit_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SelectPrizeViewBody extends StatefulWidget {
  const SelectPrizeViewBody({super.key, required this.clientEntity, });
  final ClientEntity clientEntity;

  @override
  State<SelectPrizeViewBody> createState() => _SelectPrizeViewBodyState();
}

class _SelectPrizeViewBodyState extends State<SelectPrizeViewBody> {
  String value='مكواه';
  bool isSure=false;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddPrizeCubit, AddPrizeState>(
  listener: (context, state) {
    if(state is AddPrizeSuccess)
      {
        ScaffoldMessenger.of(context).clearSnackBars();
        Navigator.pushReplacementNamed(context, IdCheckView.routeName);
        buildSuccessBar(context, 'تم اضافه الهدية بنجاح');
      }
    else if(state is AddPrizeFailure)
      {
        buildErrorBar(context, 'حدث خطا برجاء اعادة المحاولة');
      }

  },
  builder: (context, state) {
    return ModalProgressHUD(
      inAsyncCall: state is AddPrizeLoading?true:false,
      child: SingleChildScrollView(
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
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'اختار هديتك',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bold40.copyWith(color: Colors
                        .white, fontSize: 35),
                  ),
                ),
              ),

            ),
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: PrizeChoiceWidget(
                onChanged: (v){
                  this.value=v!;
                  setState(() {

                  });
                },
                value: value,
              ),
            ),
            const SizedBox(height: 20,),
            Row(
              children: [
                Checkbox(
                  value: isSure,
                  onChanged: (v){
                    isSure=!isSure;
                    setState(() {

                    });
                  },


                ),
                const SizedBox(width: 7,),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    'هل انت متاكد من اختيارك',
                    style: AppTextStyles.bold23.copyWith(color: Colors.white),
                  ),
                ),


              ],
            ),
            const SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                if(isSure==true)
                {
                  if(widget.clientEntity.prizes==null)
                  {
                    List<PrizeEntity> prizes=[];

                    PrizeEntity prize=PrizeEntity(
                      name: value,
                      date: DateTime.now().toIso8601String(),
                      prizeBranch: branch,
                      pack1Branch: widget.clientEntity.paymentHistory![0].packBranch,
                      pack1Date: widget.clientEntity.paymentHistory![0].packDate,
                      pack2Branch: widget.clientEntity.paymentHistory![1].packBranch,
                      pack2Date: widget.clientEntity.paymentHistory![1].packDate,
                      pack3Branch: widget.clientEntity.paymentHistory![2].packBranch,
                      pack3Date: widget.clientEntity.paymentHistory![2].packDate,


                    );
                    prizes.add(prize);
                    widget.clientEntity.prizes=prizes;
                    widget.clientEntity.paymentHistory=null;
                  }
                  else
                  {
                    PrizeEntity prize=PrizeEntity(
                      name: value,
                      date: DateTime.now().toIso8601String(),
                      prizeBranch: branch,
                      pack1Branch: widget.clientEntity.paymentHistory![0].packBranch,
                      pack1Date: widget.clientEntity.paymentHistory![0].packDate,
                      pack2Branch: widget.clientEntity.paymentHistory![1].packBranch,
                      pack2Date: widget.clientEntity.paymentHistory![1].packDate,
                      pack3Branch: widget.clientEntity.paymentHistory![2].packBranch,
                      pack3Date: widget.clientEntity.paymentHistory![2].packDate,


                    );
                    widget.clientEntity.prizes!.add(prize);
                    widget.clientEntity.paymentHistory=null;

                  }
                  widget.clientEntity.paymentHistory=null;
                  widget.clientEntity.lastPrizeDate=DateTime.now().toIso8601String();
                  AddPrizeCubit.get(context).addPrize(widget.clientEntity);
                }
                else
                {
                  buildErrorBar(context, 'من فضلك قم بتاكيد اختيارك');
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
    );
  },
);
  }
}
