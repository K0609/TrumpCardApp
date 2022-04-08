//
//  RegularCardsSettingViewController.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/11/03.
//

import UIKit

class RegularCardsSettingViewController: UIViewController, UIGestureRecognizerDelegate {

    //ImageView
    @IBOutlet weak var card1: UIImageView!
    @IBOutlet weak var card2: UIImageView!
    @IBOutlet weak var card3: UIImageView!
    @IBOutlet weak var card4: UIImageView!
    @IBOutlet weak var card5: UIImageView!
    @IBOutlet weak var card6: UIImageView!
    @IBOutlet weak var card7: UIImageView!
    @IBOutlet weak var card8: UIImageView!
    @IBOutlet weak var card9: UIImageView!
    @IBOutlet weak var card10: UIImageView!
    @IBOutlet weak var card11: UIImageView!
    @IBOutlet weak var card12: UIImageView!
    @IBOutlet weak var card13: UIImageView!
    @IBOutlet var settingOK: UIButton!
    
    var cardsList = CardsList() //cardsList
    var cardMark: String = "cardMark" //RCSettingViewにどの柄がタップされたかを知らせるための情報
    var displayCardsList: [CardsModel] = [] //どの絵柄のカードリストを使うかを入れておく箱

        
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //絵柄を判断
        switch cardMark {
        case "spade":
            displayCardsList = cardsList.spadeList
        case "heart":
            displayCardsList = cardsList.heartList
        case "diamond":
            displayCardsList = cardsList.diamondList
        case "club":
            displayCardsList = cardsList.clubList
        default:
            print("default")
        }
        
        //Viewにカードを表示
        for n in 1...displayCardsList.count {
            
            showCard(n: n)
            
        }
        
        
        //各カードのscaleToFill & 丸角枠線 & レイアウト設定
        for image in [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12, card13] {
            
            image?.contentMode = .scaleToFill
            marukadoWakusen(image: image!)
            image?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let intervalBtwCards:CGFloat = 0.0125
        let heightCoefficient = 0.5
        let widthCoefficient = 1 / 1.618
        

        let card1Top = card1.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: self.view.frame.height * 0.08)
        let card13Top = card13.topAnchor.constraint(equalTo: card1.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)
        let card12Top = card12.topAnchor.constraint(equalTo: card1.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)
        let card11Top = card11.topAnchor.constraint(equalTo: card1.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)
        let card10Top = card10.topAnchor.constraint(equalTo: card12.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)
        let card9Top = card9.topAnchor.constraint(equalTo: card12.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)
        let card8Top = card8.topAnchor.constraint(equalTo: card12.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)
        let card7Top = card7.topAnchor.constraint(equalTo: card9.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)
        let card6Top = card6.topAnchor.constraint(equalTo: card9.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)
        let card5Top = card5.topAnchor.constraint(equalTo: card9.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)
        let card4Top = card4.topAnchor.constraint(equalTo: card6.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)
        let card3Top = card3.topAnchor.constraint(equalTo: card6.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)
        let card2Top = card2.topAnchor.constraint(equalTo: card6.bottomAnchor, constant: self.view.frame.height * intervalBtwCards)

        let card1Height = card1.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.20)
        let card13Height = card13.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier: heightCoefficient)
        let card12Height = card12.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier:  heightCoefficient)
        let card11Height = card11.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier: heightCoefficient)
        let card10Height = card10.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier: heightCoefficient)
        let card9Height = card9.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier: heightCoefficient)
        let card8Height = card8.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier: heightCoefficient)
        let card7Height = card7.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier: heightCoefficient)
        let card6Height = card6.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier: heightCoefficient)
        let card5Height = card5.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier: heightCoefficient)
        let card4Height = card4.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier: heightCoefficient)
        let card3Height = card3.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier: heightCoefficient)
        let card2Height = card2.heightAnchor.constraint(equalTo: card1.heightAnchor, multiplier: heightCoefficient)
        
        let card1Width = card1.widthAnchor.constraint(equalTo: card1.heightAnchor, multiplier: widthCoefficient)
        let card13Width = card13.widthAnchor.constraint(equalTo: card13.heightAnchor, multiplier: widthCoefficient)
        let card12Width = card12.widthAnchor.constraint(equalTo: card12.heightAnchor, multiplier: widthCoefficient)
        let card11Width = card11.widthAnchor.constraint(equalTo: card11.heightAnchor, multiplier: widthCoefficient)
        let card10Width = card10.widthAnchor.constraint(equalTo: card10.heightAnchor, multiplier: widthCoefficient)
        let card9Width = card9.widthAnchor.constraint(equalTo: card9.heightAnchor, multiplier: widthCoefficient)
        let card8Width = card8.widthAnchor.constraint(equalTo: card8.heightAnchor, multiplier: widthCoefficient)
        let card7Width = card7.widthAnchor.constraint(equalTo: card7.heightAnchor, multiplier: widthCoefficient)
        let card6Width = card6.widthAnchor.constraint(equalTo: card6.heightAnchor, multiplier: widthCoefficient)
        let card5Width = card5.widthAnchor.constraint(equalTo: card5.heightAnchor, multiplier: widthCoefficient)
        let card4Width = card4.widthAnchor.constraint(equalTo: card4.heightAnchor, multiplier: widthCoefficient)
        let card3Width = card3.widthAnchor.constraint(equalTo: card3.heightAnchor, multiplier: widthCoefficient)
        let card2Width = card2.widthAnchor.constraint(equalTo: card2.heightAnchor, multiplier: widthCoefficient)

        let card1X = card1.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let card13Trailing = card13.trailingAnchor.constraint(equalTo: card1.leadingAnchor, constant: 0)
        let card12X = card12.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let card11Leading = card11.leadingAnchor.constraint(equalTo: card1.trailingAnchor, constant: 0)
        let card10Trailing = card10.trailingAnchor.constraint(equalTo: card1.leadingAnchor, constant: 0)
        let card9X = card9.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let card8Leading = card8.leadingAnchor.constraint(equalTo: card1.trailingAnchor, constant: 0)
        let card7Trailing = card7.trailingAnchor.constraint(equalTo: card1.leadingAnchor, constant: 0)
        let card6X = card6.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let card5Leading = card5.leadingAnchor.constraint(equalTo: card1.trailingAnchor, constant: 0)
        let card4Trailing = card4.trailingAnchor.constraint(equalTo: card1.leadingAnchor, constant: 0)
        let card3X = card3.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let card2Leading = card2.leadingAnchor.constraint(equalTo: card1.trailingAnchor, constant: 0)

        settingOK.translatesAutoresizingMaskIntoConstraints = false
        let settingOKX = settingOK.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let settingOKY = settingOK.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30)

        NSLayoutConstraint.activate([card1Top,
                                     card13Top,
                                     card12Top,
                                     card11Top,
                                     card10Top,
                                     card9Top,
                                     card8Top,
                                     card7Top,
                                     card6Top,
                                     card5Top,
                                     card4Top,
                                     card3Top,
                                     card2Top,
                                     card1Height,
                                     card13Height,
                                     card12Height,
                                     card11Height,
                                     card10Height,
                                     card9Height,
                                     card8Height,
                                     card7Height,
                                     card6Height,
                                     card5Height,
                                     card4Height,
                                     card3Height,
                                     card2Height,
                                     card1Width,
                                     card13Width,
                                     card12Width,
                                     card11Width,
                                     card10Width,
                                     card9Width,
                                     card8Width,
                                     card7Width,
                                     card6Width,
                                     card5Width,
                                     card4Width,
                                     card3Width,
                                     card2Width,
                                     card1X,
                                     card13Trailing,
                                     card12X,
                                     card11Leading,
                                     card10Trailing,
                                     card9X,
                                     card8Leading,
                                     card7Trailing,
                                     card6X,
                                     card5Leading,
                                     card4Trailing,
                                     card3X,
                                     card2Leading,
                                     settingOKX,
                                     settingOKY
                                    ])

        
        
        //エース用にlongTapGestureを作成
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.longPress(_:)))
        longPressGesture.delegate = self
        self.card1.addGestureRecognizer(longPressGesture)
        
        //すべてのカードのtapGestureを作成
        let tapGesture1: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture1.delegate = self
        self.card1.addGestureRecognizer(tapGesture1)
        
        let tapGesture2: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture2.delegate = self
        self.card2.addGestureRecognizer(tapGesture2)
        
        let tapGesture3: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture3.delegate = self
        self.card3.addGestureRecognizer(tapGesture3)
        
        let tapGesture4: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture4.delegate = self
        self.card4.addGestureRecognizer(tapGesture4)
        
        let tapGesture5: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture5.delegate = self
        self.card5.addGestureRecognizer(tapGesture5)
        
        let tapGesture6: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture6.delegate = self
        self.card6.addGestureRecognizer(tapGesture6)
        
        let tapGesture7: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture7.delegate = self
        self.card7.addGestureRecognizer(tapGesture7)
        
        let tapGesture8: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture8.delegate = self
        self.card8.addGestureRecognizer(tapGesture8)
        
        let tapGesture9: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture9.delegate = self
        self.card9.addGestureRecognizer(tapGesture9)
        
        let tapGesture10: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture10.delegate = self
        self.card10.addGestureRecognizer(tapGesture10)
        
        let tapGesture11: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture11.delegate = self
        self.card11.addGestureRecognizer(tapGesture11)
        
        let tapGesture12: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture12.delegate = self
        self.card12.addGestureRecognizer(tapGesture12)
        
        let tapGesture13: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.tapAction(_:)))
        tapGesture13.delegate = self
        self.card13.addGestureRecognizer(tapGesture13)
     
    }
    
    
    //ボタン：設定完了
    @IBAction func settingOk(_ sender: Any) {
        
        let NC = self.parent as! UINavigationController
        let SettingVC = NC.viewControllers[1] as! SettingViewController
        
        //絵柄を判断して
        switch cardMark {
        case "spade":
            cardsList.spadeList = displayCardsList
        case "heart":
            cardsList.heartList = displayCardsList
        case "diamond":
            cardsList.diamondList = displayCardsList
        case "club":
            cardsList.clubList = displayCardsList
        default:
            print("default")
        }
        //前の画面に情報を渡す
        SettingVC.cardsList = self.cardsList
        navigationController?.popViewController(animated: true)

    }
    
    
    //longPressのボタンの処理
    @objc func longPress(_ sender: UILongPressGestureRecognizer){
        if sender.state == .began {
            showAlert()
        } else if sender.state == .ended {
        }
    }
    

    //tapの処理
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            
            if (sender as AnyObject).view.tag > 0 {
                //どのカードがタップされたかを判断して,
                let tag = Int((sender as AnyObject).view.tag)
                //もともとuseがtrueならfalseへ、falseならtrueへ
                if displayCardsList[tag - 1].use == true {
                    displayCardsList[tag - 1].use = false
                } else {
                    displayCardsList[tag - 1].use = true
                }

                //viewを更新
                showCard(n: tag)
            }
        }
    }
    
    
    //機能:ImageViewにカードを表示
    func showCard(n: Int) {
        
        //ImageViewのリスト
        let viewsList = [card1, card2, card3, card4, card5, card6, card7, card8, card9, card10, card11, card12, card13]
        //ImageViewのリスト中から表示場所のviewを選択
        let cardView: UIImageView = viewsList[n - 1]!
        //カードリストの中から表示させるカードモデルを選択
        let displayCard: CardsModel = displayCardsList[n - 1]
        
        //画像のセット
        cardView.image = displayCard.cardImage
        //trueかfalseかでAlpha値の設定
        if displayCard.use == true {
            cardView.alpha = 1
        } else {
            cardView.alpha = 0.2
        }
    }
    
    
    //longPress用のアラートの設定
    func showAlert() {
        
        //アラートの作成
        let alert = UIAlertController(title: "Card Settting", message: "使う？使わない？", preferredStyle: .alert)
        
        //SellectAllボタンの作成
        let sellectAll = UIAlertAction(title: "Sellect all", style: .default, handler: { (action) -> Void in
            for n in 1...self.displayCardsList.count {
                self.displayCardsList[n - 1].use = true
                self.showCard(n: n)
            }
        })
        
        //ClearAllボタンの作成
        let clearAll = UIAlertAction(title: "Clear all", style: .default, handler: { (action) -> Void in
            for n in 1...self.displayCardsList.count {
                self.displayCardsList[n - 1].use = false
                self.showCard(n: n)
            }
        })
        
        //キャンセルボタンの作成
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        //アラートにボタンを追加
        alert.addAction(sellectAll);
        alert.addAction(clearAll);
        alert.addAction(cancel);
        
        //アラートの実行
        self.present(alert, animated: true, completion: nil)
    }
    
    //機能：画像の角丸&枠線
    func marukadoWakusen (image: UIImageView) {
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.layer.borderWidth = 0.5
        image.layer.cornerRadius = image.frame.width / 20
        image.layer.masksToBounds = true
    }
    
}
