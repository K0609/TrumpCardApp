//
//  CardsList.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/10/28.
//

import Foundation
import UIKit

class CardsList {
    
    var allList = [CardsModel]()
    var spadeList = [CardsModel]()
    var heartList = [CardsModel]()
    var diamondList = [CardsModel]()
    var clubList = [CardsModel]()
    var jokerList = [CardsModel]()
    var customizeList = [CardsModel]()
    
    init() {
                    
        for number in 1...13 {
            
            spadeList.append(CardsModel(cardImage: UIImage(named: "spade_\(number)")!, cardMark: "spade", cardNumber: number, textLabelText: ""))
            
        }
        
        for number in 1...13 {

            heartList.append(CardsModel(cardImage: UIImage(named: "heart_\(number)")!, cardMark: "heart", cardNumber: number, textLabelText: ""))

        }

        for number in 1...13 {

            diamondList.append(CardsModel(cardImage: UIImage(named: "diamond_\(number)")!, cardMark: "diamond", cardNumber: number, textLabelText: ""))

        }

        for number in 1...13 {

            clubList.append(CardsModel(cardImage: UIImage(named: "club_\(number)")!, cardMark: "club", cardNumber: number, textLabelText: ""))

        }
        
        for number in 1...2 {
            
            jokerList.append(CardsModel(cardImage: UIImage(named: "joker_\(number)")!, cardMark: "joker", cardNumber: number, textLabelText: ""))
            
        }
        
//        for number in 0..<1 {
//
//            customizeList.append(CardsModel(cardImage: UIImage(named: "customize_\(number)")!, cardMark: "customize", cardNumber: number, textLabelText: ""))
//        }
        
        allList = spadeList + heartList + diamondList + clubList + jokerList + customizeList
        
    }


}


