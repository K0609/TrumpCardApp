//
//  CardsModel.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/10/28.
//

import Foundation
import UIKit


class CardsModel {
    
    let cardImage: UIImage
    let cardMark: String
    let cardNumber: Int
    var textLabelText: String = ""
    var use: Bool = true
    var drawedOrder: Int = 0
    
    init(cardImage: UIImage, cardMark: String, cardNumber: Int, textLabelText: String) {
        
        self.cardImage = cardImage
        self.cardMark = cardMark
        self.cardNumber = cardNumber
        self.textLabelText = textLabelText

    }
    
}
