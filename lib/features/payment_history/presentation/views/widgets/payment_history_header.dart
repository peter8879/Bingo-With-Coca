import 'package:bingo_with_coca/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class PaymentHistoryHeader extends StatelessWidget {
  const PaymentHistoryHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsDirectional.only(start: 8,end: 8,top: 4,bottom: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,

      ),
      child: Text(
        'اختر عدد المشتريات',
        style: AppTextStyles.bold23.copyWith(
          color: const Color(0xffE4002B)
        ),
      ),
    );
  }
}
