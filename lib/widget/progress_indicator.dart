import 'package:flutter/material.dart';
import 'package:physic/resoure/color.dart';


class MyProgressIndicator extends StatelessWidget {
  const MyProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      //backgroundColor: Colors.white,
      color: secondaryColor,
    );
  }
}

class MyLinearIndicator extends StatelessWidget {
  const MyLinearIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Padding(padding: EdgeInsets.symmetric(horizontal: 22),
    child: LinearProgressIndicator(
      backgroundColor: Colors.white,
      color:  secondaryColor,
      ),
    );
    
  }
}