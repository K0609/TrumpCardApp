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
            let textViewText: String
            switch number {
            case 1:
                textLabelText = "WATER FALL  滝行"
                textViewText = NSLocalizedString("罰ゲームのお題を決め、まず自分がその罰を受ける。\nその後他の全員に同じ罰を下す。", comment: "")
            case 2:
                textLabelText = "YOU  お前だったのか"
                textViewText = NSLocalizedString("誰か1人を指名し、罰を下す。", comment: "")
            case 3:
                textLabelText = "ME  私だ"
                textViewText = NSLocalizedString("罰を受ける。", comment: "")
            case 4:
                textLabelText = "GIRLs  女の子♡"
                textViewText = NSLocalizedString("女の子全員罰を受けて。", comment: "")
            case 5:
                textLabelText = "THUMB MASTER  親指マン"
                textViewText = NSLocalizedString("次の５が引かれるまでサムマスターになる。\nその間1度だけ、ゲーム中好きな時に机や床に親指を置ける。サムマスターが親指を置いたら他の人はすぐに親指を同じように置かなくてはいけない。\n最後まで気づかなかった人が罰を受ける。", comment: "")
            case 6:
                textLabelText = "BOYs  野郎共"
                textViewText = NSLocalizedString("野郎共全員罰を受けろ。", comment: "")
            case 7:
                textLabelText = "HEAVEN  天国"
                textViewText = NSLocalizedString("みんな両手を上げて天に祈りを捧げる。\n一番遅かった不届き者が罰を受ける。", comment: "")
            case 8:
                textLabelText = "MATE  運命共同体"
                textViewText = NSLocalizedString("自分のメイトとなる誰か1人指名し、運命共同体を結成する。\n今後ゲーム中にメイトが罰を受ける時、もう一方のメイトも罰を受ける。\n次の運命共同体が結成されたら解消。", comment: "")
            case 9:
                textLabelText = "RHYTHM  ○○♪から♪始♪まる♪"
                textViewText = NSLocalizedString("全員でリズム4ゲームを行う。\n \n ▼01. まず各プレイヤーの呼び名(2音)を確認する。\n ▼02. 全員で『{親の呼び名}、から、はじ、まる、リズ、ムに、合わ、せて（8拍）』の掛け声でゲームスタート（この時、手を使って4拍子のリズムを取る。1拍目:両手で机を叩く/2拍目:手拍手/3拍目:右手を握る/4拍目:左手を握る）。 \n ▼03. 親は次の4拍中で、3拍目に他プレイヤーの呼び名、4拍目に1~4の数字をコールする。 \n ▼04. 呼ばれたプレイヤーは、次の4拍のリズムに合わせて指定された回数分だけ自分の呼び名を繰り返す。ただし、指定回数が1なら4拍目に、2なら3・4拍目に、3なら2・3・4拍目に、4なら1・2・3・4拍目に言う。次の4拍中で、03.と同様に他プレイヤーと数字をコールする。 \n ▼05. 以後繰り返す。間違えたら罰を受ける。", comment: "")
            case 10:
                textLabelText = "CATEGORIES  山手線"
                textViewText = NSLocalizedString("全員で山手線ゲームを行う。\n \n親が『お題』を決め、親から時計回りにそのお題に該当する答えをテンポよく答えていく。\n答えを言えない/答えが間違っている/答えが被るetc.したら罰を受ける。\nこのとき、答えが被った場合は、答えを被せられたプレイヤーも罰を受ける。", comment: "")
            case 11:
                textLabelText = "RULE  立法"
                textViewText = NSLocalizedString("ルールを作る。\n今後ゲーム中にそのルールを破った者は罰を受ける。", comment: "")
            case 12:
                textLabelText = "QUESTION MASTER  答えろて"
                textViewText = NSLocalizedString("次のQが引かれるまでクエスチョンマスターになる。\nその間、他のプレイヤーはクエスチョンマスターの質問に答えた場合、罰を受ける。\nただし、質問は何度でも可能。", comment: "")
            case 13:
                textLabelText = "KING  王の盃"
                textViewText = NSLocalizedString("王の盃を用意する。\n1~3枚目のKを引いた場合、その盃に好きな飲み物を好きなだけ注ぐ。\n最後の4枚目のKを引いた者が王となり、前の3人が注いだ王の盃を飲み干す。\n\nゲーム終了。", comment: "")
                
            default:
                textLabelText = ""
                textViewText = ""
            }
            
            spadeList.append(CardsModel(cardImage: UIImage(named: "spade_\(number)")!,
                                        cardType: "regular",
                                        cardMark: "spade",
                                        cardNumber: number,
                                        textLabelText: textLabelText,
                                        textViewText: textViewText
                                       ))

            heartList.append(CardsModel(cardImage: UIImage(named: "heart_\(number)")!,
                                        cardType: "regular",
                                        cardMark: "heart",
                                        cardNumber: number,
                                        textLabelText: textLabelText,
                                        textViewText: textViewText
                                       ))
            
            diamondList.append(CardsModel(cardImage: UIImage(named: "diamond_\(number)")!,
                                          cardType: "regular",
                                          cardMark: "diamond",
                                          cardNumber: number,
                                          textLabelText: textLabelText,
                                          textViewText: textViewText
                                         ))

            clubList.append(CardsModel(cardImage: UIImage(named: "club_\(number)")!,
                                       cardType: "regular",
                                       cardMark: "club",
                                       cardNumber: number,
                                       textLabelText: textLabelText,
                                       textViewText: textViewText
                                      ))

        }
        
        for number in 1...2 {
            
            jokerList.append(CardsModel(cardImage: UIImage(named: "joker_\(number)")!,
                                        cardType: "regular",
                                        cardMark: "joker",
                                        cardNumber: number,
                                        textLabelText: "WHATEVER  仰せのままに",
                                        textViewText: NSLocalizedString("何をしてもおk", comment: "")
                                       ))
            
        }
        
//        for number in 0..<1 {
//
//            customizeList.append(CardsModel(cardImage: UIImage(named: "customize_\(number)")!, cardMark: "customize", cardNumber: number, textLabelText: ""))
//        }
        
        allList = spadeList + heartList + diamondList + clubList + jokerList + customizeList
        
    }


}


