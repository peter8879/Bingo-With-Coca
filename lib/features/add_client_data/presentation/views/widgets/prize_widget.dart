import 'package:bingo_with_coca/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class PrizeChoiceWidget extends StatefulWidget {
  const PrizeChoiceWidget({super.key, required this.onChanged, required this.value});
  final void Function(String?) onChanged;
  final String value;

  @override
  State<PrizeChoiceWidget> createState() => _PrizeChoiceWidgetState();
}

class _PrizeChoiceWidgetState extends State<PrizeChoiceWidget> {
  List<String> prizes=[
    'مكواه',
    'ايس بوكس',
    'خلاط',
    'كبه',
    'مروحة',
    'بوتجاز مسطح',
  ];
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFFcc4a4b),
        borderRadius: BorderRadius.circular(16),

      ),
      child: DropdownButton(
        icon: Padding(
          padding: const EdgeInsetsDirectional.only(
              top: 10,
              bottom: 10
          ),
          child: Image.asset(
            'assets/images/Givaway.png',
            width: 50,
            height: 50,
          ),
        ),
        style: AppTextStyles.bold19.copyWith(color: Colors.white),
        borderRadius: BorderRadius.circular(16),
        focusColor: Color(0xFFcc4a4b),
        elevation: 0,
        autofocus: true,
        isExpanded: true,
        padding: EdgeInsets.symmetric(horizontal: 12),
        value: widget.value,
        underline: SizedBox(),
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'اختار الهديه',
            style: AppTextStyles.bold19.copyWith(
              color: Colors.grey,
            ),
          ),
        ),


        items:  prizes.map((String choice) {
          return DropdownMenuItem(
            value: choice,
            child: Text(
              choice,
              style: AppTextStyles.bold19.copyWith(
                color: Colors.grey,
              ),
            ),
          );
        }).toList(),
        onChanged: widget.onChanged,


      ),
    );
  }
}
