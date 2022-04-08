//
//  SettingViewController.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/10/30.
//

import UIKit

class SettingViewController: UIViewController, UIGestureRecognizerDelegate {

    //ボタン
    @IBOutlet weak var spadeButton: UIButton!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var diamondButton: UIButton!
    @IBOutlet weak var clubButton: UIButton!
    @IBOutlet weak var jokerButton: UIButton!
    @IBOutlet weak var customizeButton: UIButton!
    @IBOutlet weak var settingOK: UIButton!
    
    //ラベル
    @IBOutlet weak var spadeLabel: UILabel!
    @IBOutlet weak var heartLabel: UILabel!
    @IBOutlet weak var diamondLabel: UILabel!
    @IBOutlet weak var clubLabel: UILabel!
    @IBOutlet weak var jokerLabel: UILabel!
    @IBOutlet weak var customizeLabel: UILabel!
    
    
    var cardsList = CardsList() //cardsList
    var cardMark: String = "cardMark" //RCSettingViewにどの柄がタップされたかを知らせるための情報
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //画像をButtonサイズにfill & 角丸枠線
        for button in [spadeButton, heartButton, diamondButton, clubButton, jokerButton, customizeButton] {
            
            marukadoWakusen(button: button!)
            toScaletoFill(button: button!)
        }
        
        //レイアウト設定
        spadeButton.translatesAutoresizingMaskIntoConstraints = false
        diamondButton.translatesAutoresizingMaskIntoConstraints = false
        heartButton.translatesAutoresizingMaskIntoConstraints = false
        clubButton.translatesAutoresizingMaskIntoConstraints = false
        jokerButton.translatesAutoresizingMaskIntoConstraints = false
        customizeButton.translatesAutoresizingMaskIntoConstraints = false
        settingOK.translatesAutoresizingMaskIntoConstraints = false
        spadeLabel.translatesAutoresizingMaskIntoConstraints = false
        diamondLabel.translatesAutoresizingMaskIntoConstraints = false
        heartLabel.translatesAutoresizingMaskIntoConstraints = false
        clubLabel.translatesAutoresizingMaskIntoConstraints = false
        jokerLabel.translatesAutoresizingMaskIntoConstraints = false
        customizeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let intervalBtwCards:CGFloat = 80
        
        let spadeTop = spadeButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: self.view.frame.height / 10)
        let heartTop = heartButton.topAnchor.constraint(equalTo: spadeButton.bottomAnchor, constant: self.view.frame.height / intervalBtwCards)
        let diamondTop = diamondButton.topAnchor.constraint(equalTo: heartButton.bottomAnchor, constant: self.view.frame.height / intervalBtwCards)
        let clubTop = clubButton.topAnchor.constraint(equalTo: diamondButton.bottomAnchor, constant: self.view.frame.height / intervalBtwCards)
        let jokerTop = jokerButton.topAnchor.constraint(equalTo: clubButton.bottomAnchor, constant: self.view.frame.height / intervalBtwCards)
        let customizeTop = customizeButton.topAnchor.constraint(equalTo: jokerButton.bottomAnchor, constant: self.view.frame.height / intervalBtwCards)
        let customizeBottom = customizeButton.bottomAnchor.constraint(equalTo: settingOK.topAnchor, constant: -self.view.frame.height / 10)
        
        let spadeHeight = spadeButton.heightAnchor.constraint(equalTo: heartButton.heightAnchor, multiplier: 1.0)
        let heartHeight = heartButton.heightAnchor.constraint(equalTo: diamondButton.heightAnchor, multiplier: 1.0)
        let diamondHeight = diamondButton.heightAnchor.constraint(equalTo: clubButton.heightAnchor, multiplier: 1.0)
        let clubHeight = clubButton.heightAnchor.constraint(equalTo: jokerButton.heightAnchor, multiplier: 1.0)
        let jokerHeight = jokerButton.heightAnchor.constraint(equalTo: customizeButton.heightAnchor, multiplier: 1.0)
        
        let spadeWidth = spadeButton.widthAnchor.constraint(equalTo: spadeButton.heightAnchor, multiplier: 1 / 1.618)
        let heartWidth = heartButton.widthAnchor.constraint(equalTo: heartButton.heightAnchor, multiplier: 1 / 1.618)
        let diamondWidth = diamondButton.widthAnchor.constraint(equalTo: diamondButton.heightAnchor, multiplier: 1 / 1.618)
        let clubWidth = clubButton.widthAnchor.constraint(equalTo: clubButton.heightAnchor, multiplier: 1 / 1.618)
        let jokerWidth = jokerButton.widthAnchor.constraint(equalTo: jokerButton.heightAnchor, multiplier: 1 / 1.618)
        let customizeWidth = customizeButton.widthAnchor.constraint(equalTo: customizeButton.heightAnchor, multiplier: 1 / 1.618)
     
        let spadetrailing = spadeButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let hearttrailing = heartButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let diamondtrailing = diamondButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let clubtrailing = clubButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let jokertrailing = jokerButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let customizetrailing = customizeButton.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        
        let settingOKX = settingOK.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let settingOKY = settingOK.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        
        let spadeLabelY = spadeLabel.centerYAnchor.constraint(equalTo: spadeButton.centerYAnchor, constant: 0)
        let heartLabelY = heartLabel.centerYAnchor.constraint(equalTo: heartButton.centerYAnchor, constant: 0)
        let diamondLabelY = diamondLabel.centerYAnchor.constraint(equalTo: diamondButton.centerYAnchor, constant: 0)
        let clubLabelY = clubLabel.centerYAnchor.constraint(equalTo: clubButton.centerYAnchor, constant: 0)
        let jokerLabelY = jokerLabel.centerYAnchor.constraint(equalTo: jokerButton.centerYAnchor, constant: 0)
        let customizeLabelY = customizeLabel.centerYAnchor.constraint(equalTo: customizeButton.centerYAnchor, constant: 0)
        
        let spadeLabelX = spadeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 30)
        let heartLabelX = heartLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 30)
        let diamondLabelX = diamondLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 30)
        let clubLabelX = clubLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 30)
        let jokerLabelX = jokerLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 30)
        let customizeLabelX = customizeLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 30)
        
        
        //制約を有効化
        NSLayoutConstraint.activate([spadeTop,
                                     heartTop,
                                     diamondTop,
                                     clubTop,
                                     jokerTop,
                                     customizeTop,
                                     customizeBottom,
                                     spadeHeight,
                                     heartHeight,
                                     diamondHeight,
                                     clubHeight,
                                     jokerHeight,
                                     spadeWidth,
                                     heartWidth,
                                     diamondWidth,
                                     clubWidth,
                                     jokerWidth,
                                     customizeWidth,
                                     spadetrailing,
                                     hearttrailing,
                                     diamondtrailing,
                                     clubtrailing,
                                     jokertrailing,
                                     customizetrailing,
                                     settingOKX,
                                     settingOKY,
                                     spadeLabelX,
                                     heartLabelX,
                                     diamondLabelX,
                                     clubLabelX,
                                     jokerLabelX,
                                     customizeLabelX,
                                     spadeLabelY,
                                     heartLabelY,
                                     diamondLabelY,
                                     clubLabelY,
                                     jokerLabelY,
                                     customizeLabelY
                                    ])
                
        //ラベルに使用するカードの枚数を表示
        reloadShowLabel()
        
        //使うカードを一括選択するためのlongTap機能の箱
        let longPressGesture1 = UILongPressGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.longPress(_:)))
        longPressGesture1.delegate = self
        self.spadeButton.addGestureRecognizer(longPressGesture1)
        
        let longPressGesture2 = UILongPressGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.longPress(_:)))
        longPressGesture2.delegate = self
        self.heartButton.addGestureRecognizer(longPressGesture2)

        let longPressGesture3 = UILongPressGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.longPress(_:)))
        longPressGesture3.delegate = self
        self.diamondButton.addGestureRecognizer(longPressGesture3)
        
        let longPressGesture4 = UILongPressGestureRecognizer(
            target: self,
            action: #selector(RegularCardsSettingViewController.longPress(_:)))
        longPressGesture4.delegate = self
        self.clubButton.addGestureRecognizer(longPressGesture4)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //ラベルに使用するカードの枚数を表示
        reloadShowLabel()
        
    }
    
    
    //ボタン：スペード、ハート、ダイヤ、クラブがタップされたときの処理
    @IBAction func toRCSettingButton(_ sender: Any) {
        
        let RCSettingVC = storyboard?.instantiateViewController(withIdentifier: "RCSettingVC") as! RegularCardsSettingViewController
        
        //タップされた絵柄がどれかを判断してRCSettingVCにわたす
        switch (sender as AnyObject).tag {
        case 1:
            RCSettingVC.cardMark = "spade"
        case 2:
            RCSettingVC.cardMark = "heart"
        case 3:
            RCSettingVC.cardMark = "diamond"
        case 4:
            RCSettingVC.cardMark = "club"
        default:
            print("default")
        }
        RCSettingVC.cardsList = cardsList
        navigationController?.pushViewController(RCSettingVC, animated: true)
    }
    
    
    //ボタン：ジョーカーがタップされたときの処理
    @IBAction func toJokerSettingButton(_ sender: Any) {
        
        let JokerSettingVC = storyboard?.instantiateViewController(withIdentifier: "JokerSettingVC") as! JokerSettingViewController
        JokerSettingVC.cardsList = cardsList
        navigationController?.pushViewController(JokerSettingVC, animated: true)
        
    }
    
    
    //ボタン：カスタマイズがタップされたときの処理
    @IBAction func toCustomizeSettingButton(_ sender: Any) {
        
        let CustomizeSettingVC = storyboard?.instantiateViewController(withIdentifier: "CustomizeSettingVC") as! CustomizeSettingViewController
        CustomizeSettingVC.cardsList = cardsList
        navigationController?.pushViewController(CustomizeSettingVC, animated: true)
        
    }
    
    
    //ボタン：設定完了
    @IBAction func settingOK(_ sender: Any) {
        
        let NC = self.parent as! UINavigationController
        let VC = NC.viewControllers[0] as! ViewController
        
        VC.cardsList = self.cardsList
        navigationController?.popViewController(animated: true)
        
    }
    
    
    //longTapされたときの処理
    @objc func longPress(_ sender: UILongPressGestureRecognizer){
        
        if sender.state == .began {
            //longTapが開始されたときの処理
            //どの柄がlongTapされたのかを判断して処理
            switch (sender as AnyObject).view.tag {
            case 1:
                showAlert(longTappedCardsList: cardsList.spadeList)
            case 2:
                showAlert(longTappedCardsList: cardsList.heartList)
            case 3:
                showAlert(longTappedCardsList: cardsList.diamondList)
            case 4:
                showAlert(longTappedCardsList: cardsList.clubList)
            default:
                print("default")
            }
        } else if sender.state == .ended {
            //longTapが終わったときの処理
            //処理なし
        }
    }
    
    
    //longTapが押されたときに表示するアラート
    func showAlert(longTappedCardsList: [CardsModel]) {
        
        //アラートの作成
        let alert = UIAlertController(title: "Card Setting", message: "", preferredStyle: .alert)
        
        //SelectAllボタンを作成
        let sellectAll = UIAlertAction(title: "Sellect all", style: .default, handler: { (action) -> Void in
            //すべてのカードのuseをtrueにする
            for n in 1...longTappedCardsList.count {
                longTappedCardsList[n - 1].use = true
            }
            //ラベル表示を更新
            self.reloadShowLabel()
        })
        
        //ClearAllボタンを作成
        let clearAll = UIAlertAction(title: "Clear all", style: .default, handler: { (action) -> Void in
            //すべてのカードのuseをfalseにする
            for n in 1...longTappedCardsList.count {
                longTappedCardsList[n - 1].use = false
            }
            //ラベル表示を更新
            self.reloadShowLabel()
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
    
    
    //機能：ラベルの更新
    func reloadShowLabel() {
        spadeLabel.text = showLabel(cardsList: cardsList.spadeList)
        heartLabel.text = showLabel(cardsList: cardsList.heartList)
        diamondLabel.text = showLabel(cardsList: cardsList.diamondList)
        clubLabel.text = showLabel(cardsList: cardsList.clubList)
        jokerLabel.text = showLabel(cardsList: cardsList.jokerList)
        customizeLabel.text = showLabel(cardsList: cardsList.customizeList)
    }
    
    
    //機能：ラベルに使用する設定のカード枚数を表示
    func showLabel(cardsList: [CardsModel]) -> String {
        
        //カードの中からuseのものを抽出
        var useCount = 0
        for card in cardsList {
            if card.use == true {
                useCount += 1
            }
        }
        return String("x\(useCount)")
    }


    //機能：画像の角丸&枠線
    func marukadoWakusen (button: UIButton) {
        button.imageView!.layer.borderColor = UIColor.systemGray.cgColor
        button.imageView!.layer.borderWidth = 0.5
        button.imageView!.layer.cornerRadius = button.frame.width / 20
        button.imageView!.layer.masksToBounds = true
    }
    
    //機能：画像をButtonサイズにfill
    func toScaletoFill(button: UIButton) {
        button.imageView?.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
    }
}


