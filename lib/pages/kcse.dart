import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../ads/ad_helper.dart';
import '../resoure/color.dart';
import 'answer.dart';
import 'paper_one.dart';
import 'paper_two.dart';


class MyKcsePage extends StatefulWidget {
  const MyKcsePage({Key? key}) : super(key: key);

  @override
  _MyKcsePageState createState() => _MyKcsePageState();
}

class _MyKcsePageState extends State<MyKcsePage> {
  int selectedIndex = 0;


  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("K.C.S.E Revision Papers"),
        centerTitle: true,
        elevation: 1,
        backgroundColor: mainColor,
      ),
    
      body: SafeArea(
        child: Column(
          children: [
            CupertinoSegmentedControl(
              groupValue: selectedIndex,
              onValueChanged: (int value) {
                setState(() {
                  selectedIndex = value;
                });
              },
              children: {
                0: Container(
                  width: 102,
                  alignment: Alignment.center,
                  child: Text(
                    "Paper 1",
                    style: TextStyle(
                        color:
                            selectedIndex == 0 ? Colors.white : Colors.black),
                  ),
                ),
                1: Container(
                  width: 102,
                  alignment: Alignment.center,
                  child: Text(
                    "Paper 2",
                    style: TextStyle(
                        color:
                            selectedIndex == 1 ? Colors.white : Colors.black),
                  ),
                ),
                2: Container(
                  width: 102,
                  alignment: Alignment.center,
                  child: Text(
                    "Answers",
                    style: TextStyle(
                        color:
                            selectedIndex == 2 ? Colors.white : Colors.black),
                  ),
                ),
              },
              selectedColor: Color.fromARGB(255, 3, 62, 110),
              unselectedColor: Colors.white,
              pressedColor: Colors.white,
              padding: const EdgeInsets.all(20),
              borderColor: Colors.black,
            ),
            returnSelectedPage(selectedIndex),
            
          ],
        ),
      ),
    );
  }
}
returnSelectedPage(int index){
  switch (index) {
    case 0:
      return const PaperOne();
    case 1:
      return const PaperTwo(); 

    case 2:
      return  const Answer();
    default:
      return const PaperOne() ;
  }
}
