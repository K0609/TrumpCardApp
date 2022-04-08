//
//  SoundFile.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/10/29.
//

import Foundation
import AVFoundation


class SoundFile {
    
    var player: AVAudioPlayer?
    
    //ファイル名と拡張子を入れたらその音源を再生するメソッド
    func playSound(fileName: String, extentionName: String) {
        
        let soundURL = Bundle.main.url(forResource: fileName, withExtension: extentionName)
        
        do {
            //効果音を鳴らす
            player = try AVAudioPlayer(contentsOf: soundURL!)
            player?.play()
            
        } catch  {
            
            print("エラーです！")
            
        }
    }
}
