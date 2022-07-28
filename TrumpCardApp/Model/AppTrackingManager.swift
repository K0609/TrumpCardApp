//
//  AppTrackingManager.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2022/07/17.
//

import Foundation
import AdSupport
import AppTrackingTransparency
import GoogleMobileAds

struct AppTrackingManager {
    static func requestAppTracking() {
        if #available(iOS 14, *) {
            print("AppTracking: OVER iOS14")
            switch ATTrackingManager.trackingAuthorizationStatus {
            case .authorized:
                print("AppTracking: AUTHORIZED")
                print("AppTracking: IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            case .denied:
                print("AppTracking: DENIED")
            case .restricted:
                print("AppTracking: RESTRICTED")
            case .notDetermined:
                showRequestTrackingAuthorizationAlert()
            @unknown default:
                print("AppTracking: UNKOWN DEFAULT")
            }

        } else {
            print("AppTracking: UNDER iOS14")
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled {
                print("AppTracking: AUTHORIZED")
                print("IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
            } else {
                print("AppTracking: RESTRICTED")
            }
        }

//        UserDefaults.standard.setValue(true, forKey: UserDefaultsKey.isShowedAdTrackingPopup)
    }

    static func showRequestTrackingAuthorizationAlert() {
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization(completionHandler: { status in
                switch status {
                case .authorized:
                    //ATT許可された場合の処理
                    // Initialize the Google Mobile Ads SDK.
                    GADMobileAds.sharedInstance().start(completionHandler: nil)
                    
                    print("AppTracking: AUTHORIZED")
                    print("AppTracking: IDFA: \(ASIdentifierManager.shared().advertisingIdentifier)")
//                    FBAdSettings.setAdvertiserTrackingEnabled(true)
                case .denied, .restricted, .notDetermined:
                    //ATT拒否された場合の処理
                    GADMobileAds.sharedInstance().start(completionHandler: nil)
                    
                    print("AppTracking: NOT AUTHORIZED")
//                    FBAdSettings.setAdvertiserTrackingEnabled(false)
                @unknown default:
                    print("AppTracking: UNKOWN DEFAULT")
                }
            })
        }
    }
}
