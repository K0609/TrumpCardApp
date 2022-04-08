//
//  CheckPermission.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/11/20.
//

import Foundation
import Photos


class CheckPermission{
    //ユーザーに許可を促すメソッド
    func showCheckPermission(){
        PHPhotoLibrary.requestAuthorization { (status) in
            switch(status){
            case .authorized:
                print("authorized")
            case .notDetermined:
                print("notDetermined")
            case .restricted:
                print("restricted")
            case .denied:
                print("denied")
            case .limited:
                print("limited")
            @unknown default:
                break
            }
        }
    }
}
