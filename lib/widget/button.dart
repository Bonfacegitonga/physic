import 'package:flutter/material.dart';
import 'package:physic/resoure/color.dart';

class Buttonk extends StatelessWidget {
  final Function press;
  final String title;
  final String subtitle;
  const Buttonk({Key? key, required this.press, required this.subtitle, required this.title});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            press();
          },
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 1.2 / 10,
              width: MediaQuery.of(context).size.width * 2.1 / 5,
              decoration: BoxDecoration(
                gradient:const  LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      secondaryColor,
                      mainColor,
                    ]),
                borderRadius: BorderRadius.circular(16.0),
              ),
              
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                     Text(title, 
                          style: const TextStyle(
                          fontSize: 20.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white)),
                     Text(
                      subtitle,
                      style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade100),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
           
          
        
      ],
    );
  }
}