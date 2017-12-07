//
//  AdPreview.swift
//  simpleUIWithStoryboard
//
//  Created by HariRamya on 30/11/17.
//  Copyright © 2017 Sunil Dutt. All rights reserved.
//

import GoogleMobileAds

class AdPreview : NSObject,GADBannerViewDelegate
{
    static let sharedInstance = AdPreview()
    var bannerView : GADBannerView!
    var isAdDisplayed = false
    func setUpAd()
    {
        bannerView = GADBannerView(adSize: kGADAdSizeBanner)
        bannerView.adUnitID = "ca-app-pub-6034271363001238/4534363426"
        bannerView.adSize = kGADAdSizeBanner
        bannerView.delegate = self
        bannerView.load(GADRequest())
    }
    /*
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }*/
    
    func askBannerObject() -> GADBannerView
    {
        return bannerView
    }
    
    func loadAd(viewC: UIViewController,banner: UIView)
    {
        bannerView.rootViewController = viewC
        bannerView.frame = banner.frame
        banner.addSubview(bannerView)
        banner.autoresizesSubviews = true
    }
    
    func unloadAd()
    {
        bannerView.removeFromSuperview()
        isAdDisplayed = false
    }
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        isAdDisplayed = true
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    
    /// Tells the delegate that a full-screen view will be presented in response
    /// to the user clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("adViewWillPresentScreen")
    }
    
    /// Tells the delegate that the full-screen view will be dismissed.
    func adViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("adViewWillDismissScreen")
    }
    
    /// Tells the delegate that the full-screen view has been dismissed.
    func adViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("adViewDidDismissScreen")
    }
    
    /// Tells the delegate that a user click will open another app (such as
    /// the App Store), backgrounding the current app.
    func adViewWillLeaveApplication(_ bannerView: GADBannerView) {
        print("adViewWillLeaveApplication")
    }
    
}
