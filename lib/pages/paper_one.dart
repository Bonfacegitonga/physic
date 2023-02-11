
import 'package:flutter/material.dart';
import 'package:physic/widget/progress_indicator.dart';
import '../ads/interstitial_ad.dart';
import '../api/fire.dart';
import '../model/firebaseFile.dart';
import '../resoure/animated_route.dart';

import 'view.dart';


class PaperOne extends StatefulWidget {
  const PaperOne({Key? key}) : super(key: key);

  @override
  State<PaperOne> createState() => _PaperOneState();
}

class _PaperOneState extends State<PaperOne> {
  late Future<List<FirebaseFile>> pp1Files;  
  MyAds myAds = MyAds();
 
  @override
  void initState(){
    super.initState();
    pp1Files = FirebaseApi.listAll('physic/pp1/');
    myAds.createInterstitialAd();

    
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FirebaseFile>>(
      future: pp1Files,
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return const MyLinearIndicator();
          default:
            if(snapshot.hasError){
              return const Center(child: Text("Sorry! error occured.."),);
            }else{
              final paperOnePapers = snapshot.data!.reversed.toList();
              return Expanded(
            child: ListView.builder(
            itemCount: paperOnePapers.length,
            itemBuilder: (BuildContext context, index) {
              final paperOnePaper = paperOnePapers[index];
              
              return Column(
                children: [
                  ListTile(
                    style: ListTileStyle.list,
                    onTap: () {
                        
                        Navigator.push(
                              context,
                              CustomRoute(
                                page: ViewPdf(
                                pdffile: paperOnePaper, 
                                title: "${paperOnePaper.name.split(".")[0]} K.C.S.E Past paper 1",
                              ))).then((_) => myAds.showInterstitialAd());
                    },
                    title: Text(
                      paperOnePaper.name.split(".")[0]
                    ),
                    subtitle: const Text("K.C.S.E Physics Paper 1"),
                  ),
                  const Divider(),
                ],
              );
            }),
      );
            }
        }
      });
    
  }
}