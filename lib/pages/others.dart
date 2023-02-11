
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:physic/pages/viewer_pdf.dart';
import 'package:physic/widget/progress_indicator.dart';

import '../ads/ad_helper.dart';
import '../ads/interstitial_ad.dart';
import '../api/fire.dart';
import '../model/file_name.dart';
import '../model/firebaseFile.dart';
import '../resoure/animated_route.dart';
import '../resoure/color.dart';



class Others extends StatefulWidget {
  const Others({Key? key}) : super(key: key);

  @override
  State<Others> createState() => _OthersState();
}

class _OthersState extends State<Others> {
  late Future<List<FirebaseFile>> ansFiles;
  final List<Otherss> names = Otherss.filePath();
  MyAds myAds = MyAds();
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState(){
    super.initState();
    ansFiles = FirebaseApi.listAll('physic/others/');
    myAds.createInterstitialAd();
    _bannerAd = BannerAd(adUnitId: AdHelper.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_){
          setState(() {
            _isBannerAdReady = true;
          });
        },onAdFailedToLoad: (ad, err){
          _isBannerAdReady = false;
          ad.dispose();
        }
      )
      );
      _bannerAd.load();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        shadowColor: Colors.black12,
        backgroundColor: mainColor,
        title: const Text("Other Learning Resources"),
        centerTitle: true,
      ),
      bottomNavigationBar: _isBannerAdReady?
        Container(
          width: _bannerAd.size.width.toDouble(),
          height: _bannerAd.size.height.toDouble(),
          child: AdWidget(ad: _bannerAd),
        ):null,
      body:  FutureBuilder<List<FirebaseFile>>(
      future: ansFiles,
      builder: (context, snapshot){
        switch(snapshot.connectionState){
          case ConnectionState.waiting:
            return const Center(
              
              child: MyProgressIndicator(),);
          default:
            if(snapshot.hasError){
              return const Center(child: Text("Sorry! error occured.."),);
            }else{
              final othersPapers = snapshot.data!.toList();
              return 
             ListView.builder(
            itemCount: othersPapers.length,
            itemBuilder: (BuildContext context, index) {
              final othersPaper = othersPapers[index];
              
              return Column(
                children: [
                  ListTile(
                    style: ListTileStyle.list,
                    onTap: () {
                        
                        Navigator.push(
                              context,
                              CustomRoute(
                                page: ViewerPdf(
                                pdffile: othersPaper, title: othersPaper.name.split(RegExp(r"(\.+)"))[0],
                              ))).then((_){
                                myAds.showInterstitialAd();
                              });
                    },
                    title: Text(
                      othersPaper.name.split(RegExp(r"(\.+)"))[0]
                    ),
                    
                  ),
                  const Divider(),
                ],
              );
            });
      
            }
        }
      }),
    );
   
  }
}