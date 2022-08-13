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
            
            let textLabelText: String
            switch number {
            case 1:
                textLabelText = "WATER FALL  滝行"
            case 2:
                textLabelText = "YOU  お前だったのか"
            case 3:
                textLabelText = "ME  私だ"
            case 4:
                textLabelText = "GIRLs  女の子♡"
            case 5:
                textLabelText = "THUMB MASTER  親指マン"
            case 6:
                textLabelText = "BOYs  野郎共"
            case 7:
                textLabelText = "HEAVEN  天国"
            case 8:
                textLabelText = "MATE  運命共同体"
            case 9:
                textLabelText = "RHYTHM  ○○♪から♪始♪まる♪"
            case 10:
                textLabelText = "CATEGORIES  山手線"
            case 11:
                textLabelText = "RULE  立法"
            case 12:
                textLabelText = "QUESTION MASTER  答えろて"
            case 13:
                textLabelText = "KING  王の盃"
                
            default:
                textLabelText = ""
            }
            
            spadeList.append(CardsModel(cardImage: UIImage(named: "spade_\(number)")!,
                                        cardType: "regular",
                                        cardMark: "spade",
                                        cardNumber: number,
                                        textLabelText: textLabelText))

            heartList.append(CardsModel(cardImage: UIImage(named: "heart_\(number)")!,
                                        cardType: "regular",
                                        cardMark: "heart",
                                        cardNumber: number,
                                        textLabelText: textLabelText))
            
            diamondList.append(CardsModel(cardImage: UIImage(named: "diamond_\(number)")!,
                                          cardType: "regular",
                                          cardMark: "diamond",
                                          cardNumber: number,
                                          textLabelText: textLabelText))

            clubList.append(CardsModel(cardImage: UIImage(named: "club_\(number)")!,
                                       cardType: "regular",
                                       cardMark: "club",
                                       cardNumber: number,
                                       textLabelText: textLabelText))

        }
        
        for number in 1...2 {
            
            jokerList.append(CardsModel(cardImage: UIImage(named: "joker_\(number)")!,
                                        cardType: "regular",
                                        cardMark: "joker",
                                        cardNumber: number,
                                        textLabelText: "WHATEVER  仰せのままに"))
            
        }
        
//        for number in 0..<1 {
//
//            customizeList.append(CardsModel(cardImage: UIImage(named: "customize_\(number)")!, cardMark: "customize", cardNumber: number, textLabelText: ""))
//        }
        
        allList = spadeList + heartList + diamondList + clubList + jokerList + customizeList
        
    }


}


