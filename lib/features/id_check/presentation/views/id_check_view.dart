import 'package:bingo_with_coca/core/widgets/background_image.dart';
import 'package:bingo_with_coca/features/id_check/presentation/views/widgets/id_check_view_body.dart';
import 'package:flutter/material.dart';

class IdCheckView extends StatelessWidget {
  const IdCheckView({super.key});
  static const String routeName = 'id-check';

  @override
  Widget build(BuildContext context) {
    return BackgroundImage(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: IdCheckViewBody(),

      ),
    );
  }
}
