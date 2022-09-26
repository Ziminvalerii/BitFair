//
//  AdManager.swift
//  BitFair
//
//  Created by Tanya Koldunova on 20.09.2022.
//

import UIKit
import GoogleMobileAds

typealias RewardAdsComplitionHandler = (_ reward: GADAdReward?) -> Void

class AdsManager: NSObject {
    var rewardedInterstitial : GADRewardedInterstitialAd?
    var interstitial: GADInterstitialAd?
    private var rewardAdsComplitionHandler: RewardAdsComplitionHandler?
    var reward : GADAdReward?
    
    override init() {
        super.init()
        prepareRewardInterstitial()
        prepareInterstitital()
    }
    
    func prepareRewardInterstitial(complition: (() -> Void)? = nil) {
        GADRewardedInterstitialAd.load(withAdUnitID:"ca-app-pub-3940256099942544/6978759866",
                                       request: GADRequest()) { ad, error in
            if let error = error {
                return print("Failed to load rewarded interstitial ad with error: \(error.localizedDescription)")
            }
            self.rewardedInterstitial = ad
            self.rewardedInterstitial?.fullScreenContentDelegate = self
            complition?()
        }
    }
    
    func showRewardedAds(at vc: UIViewController, complition : @escaping RewardAdsComplitionHandler) {
        if rewardedInterstitial != nil {
            rewardedInterstitial?.present(fromRootViewController: vc) {
                self.reward = self.rewardedInterstitial?.adReward
                self.rewardAdsComplitionHandler = complition
            }
        } else {
            return
        }
    }
        
    func prepareInterstitital() {
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-5944077600830875/3259218745",
                               request: request,
                               completionHandler: { [self] ad, error in
            if let error = error {
                print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                return
            }
            interstitial = ad
        }
        )
    }
    
    func showInterstitial(from vc: UIViewController) {
        if self.interstitial != nil {
         //   if let vc = UIApplication.getTopViewController() {
                self.interstitial!.present(fromRootViewController: vc)
                prepareInterstitital()
           // }
        }
    }
    
   
    
}

extension AdsManager: GADFullScreenContentDelegate {
    
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("ad will present full screen")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print ("ad did dissmissed ")
        rewardAdsComplitionHandler?(reward)
        reward = nil
        prepareRewardInterstitial()
    }
}
