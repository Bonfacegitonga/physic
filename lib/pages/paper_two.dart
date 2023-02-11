import 'package:flutter/material.dart';

import '../ads/interstitial_ad.dart';
import '../api/fire.dart';
import '../model/firebaseFile.dart';
import '../resoure/animated_route.dart';
import '../widget/progress_indicator.dart';
import 'view.dart';


class PaperTwo extends StatefulWidget {
  const PaperTwo({Key? key}) : super(key: key);

  @override
  State<PaperTwo> createState() => _PaperTwoState();
}

class _PaperTwoState extends State<PaperTwo> {
  late Future<List<FirebaseFile>> pp2Files;  
  MyAds myAds = MyAds();
  @override
  void initState(){
    super.initState();
    pp2Files = FirebaseApi.listAll('physic/pp2/');
    myAds.createInterstitialAd();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FirebaseFile>>(
      future: pp2Files,
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return const MyLinearIndicator();
          default:
            if(snapshot.hasError){
              return const Center(child: Text("Sorry! error occured.."),);
            }else{
              final paperTwoPapers = snapshot.data!.reversed.toList();
              return Expanded(
            child: ListView.builder(
            itemCount: paperTwoPapers.length,
            itemBuilder: (BuildContext context, int index) {
              final paperTwoPaper = paperTwoPapers[index];
              
              return Column(
                children: [
                  ListTile(
                    style: ListTileStyle.list,
                    onTap: () {
                        
                        Navigator.push(
                              context,
                              CustomRoute(
                                page: ViewPdf(
                                pdffile: paperTwoPaper, 
                                title: "${paperTwoPaper.name.split(".")[0]} K.C.S.E Past paper 2" ,
                              ))).then((_) => myAds.showInterstitialAd());
                    },
                    title: Text(
                     paperTwoPaper.name.split(".")[0]
                    ),
                    subtitle: const Text("K.C.S.E Physics Paper 2"),
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