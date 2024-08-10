import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdControlller extends GetxController{

  final isNextPageReady = true.obs;

  late BannerAd bannerAd;
  final isAdLoaded = false.obs;

  //for banner
  // var adUnitId="ca-app-pub-3940256099942544/6300978111"; //testid
  var adUnitId="ca-app-pub-4047092458524463/4562388231";

  //for InterstitialAdS
  // var intAdUnitId="ca-app-pub-3940256099942544/1033173712"; //testid
  var intAdUnitId="ca-app-pub-4047092458524463/6148084023";

  // var intAdUnitId="ca-app-pub-4047092458524463/1078740118";
  
  //for rewarded
  // var rewardedIntAdUnitId="ca-app-pub-3940256099942544/5224354917"; //testid
  var rewardedIntAdUnitId="ca-app-pub-4047092458524463/1143648285";

 
  


  initBannerAd(){
    bannerAd = BannerAd(
      size: AdSize.banner, 
      adUnitId: adUnitId, 
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isAdLoaded.value = true;
        },

        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          if (kDebugMode) {
            print(">>$error");
          }
          // bannerAd.dispose();
        },

      ), 
      request: const AdRequest()
    );

    bannerAd.load();
  }

  // initInterstitialAd(){
  //  InterstitialAd.load(
  //   adUnitId: intAdUnitId, 
  //   request: AdRequest(), 
  //   adLoadCallback: InterstitialAdLoadCallback(
  //     onAdLoaded: (ad) {
  //       interstitialAd = ad;
  //       isIntAdLoaded.value = true;

  //       interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
  //         onAdDismissedFullScreenContent: (ad) {
  //           // ad.dispose();
  //           isIntAdLoaded.value = true;
  //           Get.toNamed("/forcast_day_screen");
  //         },
  //         onAdFailedToShowFullScreenContent: (ad, error) {
  //           // ad.dispose();
  //           isIntAdLoaded.value = false;
  //           Get.toNamed("/forcast_day_screen");
  //         },

  //       );
  //     }, 
  //     onAdFailedToLoad: (error) {
  //       interstitialAd.dispose();
  //     },
  //   )
  //  );
  // }

  loadInterstitialAd_forSame(){
   
    InterstitialAd? interstitialAd;
    InterstitialAd.load(
      adUnitId: intAdUnitId, 
      request: const AdRequest(), 
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          interstitialAd!.show();
          interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: (ad, error) {
              ad.dispose();
              interstitialAd!.dispose();
              debugPrint(error.message);
            },
            onAdDismissedFullScreenContent: (ad) {
              ad.dispose();
              interstitialAd!.dispose();
            }
          );
        }, 
        onAdFailedToLoad: (error) {
          interstitialAd!.dispose();
          debugPrint(">>${error.message}");
        },
      ),
    );
  }

  void loadInterestitialAd(){
    isNextPageReady.value = true; //to remove circular progress
    InterstitialAd? interstitialAd;
    InterstitialAd.load(
      adUnitId: intAdUnitId, 
      request: const AdRequest(), 
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          interstitialAd = ad;
          interstitialAd!.show();
          interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
            onAdFailedToShowFullScreenContent: (ad, error) {
              isNextPageReady.value = true; //add not loaded so remove circular progreess
              ad.dispose();
              interstitialAd!.dispose();
              debugPrint(">>${error.message}");
            },
            onAdDismissedFullScreenContent: (ad) {
              isNextPageReady.value = true; //to remove circular progress
              ad.dispose();
              interstitialAd!.dispose();
              Get.toNamed("/forcast_day_screen");
            }
          );
        }, 
        onAdFailedToLoad: (error) {
          debugPrint(error.message);
          interstitialAd!.dispose();
          isNextPageReady.value = true; //add not loaded so remove circular progreess
          Get.toNamed("/forcast_day_screen");
        },
      ),
    );
  }

  void loadRewardAd(String pagePath)async{
    RewardedAd? rewardAd;
    RewardedAd.load(
      adUnitId: rewardedIntAdUnitId,
      request: const AdRequest(), 
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) async{
          await Future.delayed(const Duration(seconds: 1));
          isNextPageReady.value = true; //to remove circular progress
          
          rewardAd = ad;
          rewardAd!.show(onUserEarnedReward: (ad, reward) {
            debugPrint("${reward.amount}");
          },);
          rewardAd!.fullScreenContentCallback = FullScreenContentCallback(
              onAdFailedToShowFullScreenContent: (ad, error) {
                ad.dispose();
              },
              onAdDismissedFullScreenContent: (ad) {
                ad.dispose();
                Get.toNamed(pagePath);
              },
          );
        }, 
        onAdFailedToLoad: (error) {
          debugPrint(">>${error.message}");
          isNextPageReady.value = true;
          Get.toNamed(pagePath);
        },
      )
    );
  }


}