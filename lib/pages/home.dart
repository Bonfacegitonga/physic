import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:physic/pages/viewer_pdf.dart';


import '../ads/ad_helper.dart';
import '../ads/interstitial_ad.dart';
import '../api/fire.dart';
import '../model/file_name.dart';
import '../model/firebaseFile.dart';
import '../resoure/animated_route.dart';
import '../resoure/color.dart';
import '../widget/book_card.dart';
import '../widget/button.dart';
import '../widget/progress_indicator.dart';

import 'kcse.dart';
import 'others.dart';
import 'view.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<FirebaseFile>> ansFiles;
  final List<Books> items = Books.bookList();
  final stylee = const TextStyle(
      color: Colors.black, 
      fontSize: 20, 
      fontWeight: FontWeight.bold);

  final String kcseTitle = "K.C.S.E";
  final String kcseSubTitle = "Past Papers";
  final String otherTitle = "Revision";
  final String otherSubTitle = "Materials";
  MyAds myAds = MyAds();
  bool _isBannerAdReady = false;
  late BannerAd _bannerAd;

  

  @override
  void initState() {
    super.initState();
    ansFiles = FirebaseApi.listAll('physic/books/');

    myAds.createInterstitialAd();
    _bannerAd = BannerAd(
      size: AdSize.banner,
      adUnitId: AdHelper.bannerAdUnitId,
      listener: BannerAdListener(onAdLoaded: (_) {
        setState(() {
          _isBannerAdReady = true;
        });
      }, onAdFailedToLoad: (ad, err) {
        _isBannerAdReady = false;
        ad.dispose();
      }),
      request:const AdRequest(),
    );
    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: _isBannerAdReady
          ? Container(
              width: _bannerAd.size.width.toDouble(),
              height: _bannerAd.size.height.toDouble(),
              child: AdWidget(ad: _bannerAd),
            )
          : null,
      body: Stack(
        children: [
          Container(
            height: size.height * .30,
            decoration: const BoxDecoration(
              color: mainColor,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Physics",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                          color: Colors.white,
                          iconSize: 22,
                          onPressed: () {
                            showAboutDialog(
                                context: context,
                                applicationName: "Physic Revision",
                                applicationLegalese: '@2022 envyTech',
                                applicationVersion: '1.0.0');
                          },
                          icon: const Icon(Icons.info))
                    ],
                  ),
                  const Text(
                    "K.C.S.E Revision Notes  \n& Past Papers",
                    style: TextStyle(
                        color: Colors.yellow,
                        fontSize: 22,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.w400),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Revision",
                    style: stylee,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  //revision materials
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Buttonk(
                            title: kcseTitle,
                            subtitle: kcseSubTitle,
                            press: () {
                              Navigator.push(context,
                                  CustomRoute(page: const MyKcsePage()));
                            }),
                        Buttonk(
                            title: otherTitle,
                            subtitle: otherSubTitle,
                            press: () {
                              Navigator.push(
                                  context, CustomRoute(page: const Others()));
                            }),
                      ]),

                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    "Notes",
                    style: stylee,
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  //books card
                  FutureBuilder<List<FirebaseFile>>(
                      future: ansFiles,
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.waiting:
                            return const Center(
                              child: MyProgressIndicator(),
                            );
                          default:
                            if (snapshot.hasError) {
                              return const Center(
                                child: Text("Sorry! error occured.."),
                              );
                            } else {
                              final homePageBooks = snapshot.data!;
                              
                              return Expanded(
                                child: OrientationBuilder(
                                  builder: (context, orientation) {
                                    return
                                     GridView.builder(
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisCount: orientation ==
                                                      Orientation.portrait? 2: 3,
                                              childAspectRatio: .82,
                                              mainAxisSpacing: 7,
                                              crossAxisSpacing: 7),
                                      itemCount: homePageBooks.length,
                                      itemBuilder: (BuildContext, index) {
                                        final homePageBook = homePageBooks[index];                                        
                                        return CategoryCard(
                                          title: items[index].book,
                                          imagePath: items[index].image,
                                          press: () {
                                            Navigator.push(context, CustomRoute(
                                              page:
                                               ViewerPdf(
                                                 pdffile: homePageBook, 
                                                 title: items[index].book ,))).then((_) => myAds.showInterstitialAd());
                                          },
                                        );
                                      },
                                    );
                                  },
                                ),
                              );
                            }
                        }
                      }
                  )
                        
                  //book card
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
