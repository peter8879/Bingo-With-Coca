import 'package:bingo_with_coca/constants.dart';
import 'package:bingo_with_coca/core/entites/client_entity.dart';
import 'package:bingo_with_coca/core/entites/payment_history_entity.dart';
import 'package:bingo_with_coca/core/helper_function/build_error_bar.dart';
import 'package:bingo_with_coca/core/helper_function/build_success_bar.dart';
import 'package:bingo_with_coca/features/id_check/presentation/views/id_check_view.dart';
import 'package:bingo_with_coca/features/payment_history/presentation/views/widgets/payment_history_header.dart';
import 'package:bingo_with_coca/features/prize_select/presentation/views/select_prize.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../../core/cubits/update_client_cubit/update_client_cubit.dart';
import '../../../../../core/utils/app_text_styles.dart';


class PaymentHistoryViewBody extends StatefulWidget {
  const PaymentHistoryViewBody({super.key, required this.clientEntity});

  final ClientEntity clientEntity;

  @override
  State<PaymentHistoryViewBody> createState() => _PaymentHistoryViewBodyState();
}

class _PaymentHistoryViewBodyState extends State<PaymentHistoryViewBody> {
  late bool check1;
  late bool check2;
  late bool check3;
  late bool canChange1;
  late bool canChange2;
  late bool canChange3;

  @override
  void initState() {
    if (widget.clientEntity.paymentHistory == null) {
      check1 = false;
      canChange1 = true;
      check2 = false;
      canChange2 = true;
      check3 = false;
      canChange3 = true;
    }
    else {
      if (widget.clientEntity.paymentHistory!.length == 1) {
        check1 = true;
        canChange1 = false;
        check2 = false;
        canChange2 = true;
        check3 = false;
        canChange3 = true;
      }
      else if (widget.clientEntity.paymentHistory!.length == 2) {
        check1 = true;
        canChange1 = false;
        check2 = true;
        canChange2 = false;
        check3 = false;
        canChange3 = true;
      }
      else {
        check1 = true;
        canChange1 = false;
        check2 = true;
        canChange2 = false;
        check3 = true;
        canChange3 = false;
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UpdateClientCubit, UpdateClientState>(
      listener: (context, state) {
        if(state is UpdateClientSuccess)
          {
           if(widget.clientEntity.paymentHistory!=null)
             {
               if(widget.clientEntity.paymentHistory!.length==3)
                 {
                   ScaffoldMessenger.of(context).clearSnackBars();
                   Navigator.pushReplacementNamed(context, SelectPrizeView.routeName,arguments: widget.clientEntity);
                 }
               else
                 {
                   buildSuccessBar(context, 'تم التسجيل بنجاح');
                   Navigator.pushReplacementNamed(context, IdCheckView.routeName);
                 }
             }
           else
             {
               buildSuccessBar(context, 'تم التسجيل بنجاح');
               Navigator.pushReplacementNamed(context, IdCheckView.routeName);
             }
          }
        else if(state is UpdateClientFailure)
          {
            buildErrorBar(context,'حدث خطا اثناء التسجيل');
          }

      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: state is UpdateClientLoading?true:false,
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
                        'السجل الشرائى للعميل',
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
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: const Color(0xFFcc4a4b)
                    ),
                    child: Column(
                      children: [
                        const SizedBox(height: 20,),
                        const PaymentHistoryHeader(),
                        const SizedBox(height: 30,),
                        Row(
                          children: [

                            Expanded(
                              child: Transform.rotate(

                                child: const Icon(
                                  Icons.horizontal_rule,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                angle: 1.5708,
                              ),
                            ),
                            Expanded(
                              child: Transform.rotate(

                                child: const Icon(
                                  Icons.horizontal_rule,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                angle: 1.5708,
                              ),
                            ),
                            Expanded(
                              child: Transform.rotate(

                                child: const Icon(
                                  Icons.horizontal_rule,
                                  color: Colors.white,
                                  size: 40,
                                ),
                                angle: 1.5708,
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 30,),
                        Row(
                          children: [

                            Expanded(
                              child: Checkbox(
                                value: check1,
                                onChanged: (value) {
                                  if (canChange1 == true) {
                                    check1 = !check1;
                                    setState(() {

                                    });
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: Checkbox(
                                value: check2,
                                onChanged: (value) {
                                  if (canChange2 == true) {
                                    check2 = !check2;
                                    setState(() {

                                    });
                                  }
                                },
                              ),
                            ),
                            Expanded(
                              child: Checkbox(
                                value: check3,
                                onChanged: (value) {
                                  if (canChange3 == true) {
                                    check3 = !check3;

                                    setState(() {

                                    });
                                  }
                                },
                              ),
                            )
                          ],
                        ),


                      ],
                    ),

                  ),
                ),
                const SizedBox(height: 40,),
                GestureDetector(
                  onTap: () {
                    if (widget.clientEntity.paymentHistory == null) {
                      print('lol');
                      List<PaymentHistoryEntity> paymentHistory = [];
                      if (check1 == true) {
                        paymentHistory.add(PaymentHistoryEntity(
                            packDate: DateTime.now().toIso8601String(),
                            packBranch: branch
                        ));
                      }
                      if (check2 == true) {
                        paymentHistory.add(PaymentHistoryEntity(
                            packDate: DateTime.now().toIso8601String(),
                            packBranch: branch
                        ));
                      }
                      if(check3==true)
                      {
                        paymentHistory.add(PaymentHistoryEntity(
                            packDate: DateTime.now().toIso8601String(),
                            packBranch: branch
                        ));

                      }
                      widget.clientEntity.paymentHistory = paymentHistory;
                    }
                    else
                    {

                      if(widget.clientEntity.paymentHistory!.length==1)
                      {
                        if (check2 == true) {
                          widget.clientEntity.paymentHistory!.add(PaymentHistoryEntity(
                              packDate: DateTime.now().toIso8601String(),
                              packBranch: branch
                          ));
                        }
                        if(check3==true)
                        {
                          widget.clientEntity.paymentHistory!.add(PaymentHistoryEntity(
                              packDate: DateTime.now().toIso8601String(),
                              packBranch: branch
                          ));

                        }
                      }
                      else if(widget.clientEntity.paymentHistory!.length==2)
                      {

                        if(check3==true)
                        {
                          widget.clientEntity.paymentHistory!.add(PaymentHistoryEntity(
                              packDate: DateTime.now().toIso8601String(),
                              packBranch: branch
                          ));

                        }
                      }
                    }
                    UpdateClientCubit.get(context).updateClient(widget.clientEntity);

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
