import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
          image: DecorationImage(
              image: AssetImage(
                MediaQuery.sizeOf(context).width>900?"assets/images/BackgroundWeb.png":
                'assets/images/Full Background.png',
              ),
              fit: BoxFit.fill

          )
      ),
      child: child,

    );
  }
}
