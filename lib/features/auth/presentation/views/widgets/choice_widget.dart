import 'package:bingo_with_coca/core/cubits/branches_cubit/branches_cubit.dart';
import 'package:bingo_with_coca/core/utils/app_text_styles.dart';
import 'package:choice/choice.dart';
import 'package:flutter/material.dart';

class ChoiceWidget extends StatelessWidget {
  const ChoiceWidget({super.key, required this.onChanged, required this.value});
  final void Function(String?) onChanged;
  final String value;

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
            'assets/images/Store ID Icon.png',
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
        value: value,
        underline: SizedBox(),
        hint: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'اختر الفرع',
            style: AppTextStyles.bold19.copyWith(
              color: Colors.grey,
            ),
          ),
        ),


        items:  BranchesCubit.get(context).branches.map((e) => e.name).toList().map((String choice) {
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
        onChanged: onChanged,


      ),
    );

  }
}
