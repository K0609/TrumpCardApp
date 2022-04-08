//
//  ViewController.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/10/27.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cardView: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var toSettingButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!

    var cardsList = CardsList() //全カード情報となるcardsListをインスタンス化
    var useCardsList = [CardsModel]() //cardsList中のCardsModelの"use"だけを入れる箱
    
    var drawCount: Int = 0 //カードを引いた回数
    var soundFile = SoundFile() //SoundFileモデルをインスタンス化
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaultsからcardsList情報を呼び出し
        if UserDefaults.standard.object(forKey: "cardsList") != nil {
            cardsList = UserDefaults.standard.object(forKey: "cardsList") as! CardsList
        }
        
        //シャッフル
        shuffle(cardsList: cardsList.allList)
        
        //cardViewに画像がFillするように設定
        toScaletoFill(button: cardView)
        
        //画像の角丸&枠線
        marukadoWakusen(button: cardView)
        
        //レイアウト設定
        cardView.translatesAutoresizingMaskIntoConstraints = false
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        toSettingButton.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let cardViewHeight = cardView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.6)
        let cardViewWidth = cardView.widthAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 1/1.618)
        let cardViewX = cardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let cardViewY = cardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.frame.height * 0.05)
        
        let toSettingLeading = toSettingButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor)
        let toSettingTop = toSettingButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.15)
        
        let shuffleTrailing = shuffleButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor)
        let shuffleTop = shuffleButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.view.frame.height * 0.15)
        
        let textLabelTop = textLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30)
        let textLabelLeading = textLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0)
        let textLabelTrailing = textLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0)

        //制約を有効化
        NSLayoutConstraint.activate([
                                     cardViewHeight,
                                     cardViewWidth,
                                     cardViewX,
                                     cardViewY,
                                     toSettingLeading,
                                     toSettingTop,
                                     shuffleTrailing,
                                     shuffleTop,
                                     textLabelTop,
                                     textLabelLeading,
                                     textLabelTrailing
                                     ])
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        //cardsListから"use"のカードだけを抽出
        useCardsList = []
        for lst in [cardsList.spadeList, cardsList.heartList, cardsList.diamondList, cardsList.clubList, cardsList.jokerList, cardsList.customizeList] {
            for card in lst {
                if card.use == true {
                    useCardsList.append(card)
                }
            }
        }
        
//        shuffle(cardsList: useCardsList)
    }


    //cardを引くときの処理
    @IBAction func drawCard(_ sender: Any) {

        //山札からカードを引いた回数を確認して、
        if drawCount < useCardsList.count {
            
            //まだカードがあるなら次のカードがあるなら次のカードを表示
            let drawCard = useCardsList[drawCount]
            let drawCardImage = drawCard.cardImage
            
            cardView.setImage(drawCardImage, for: UIControl.State.normal) //画像をセット
            textLabel.text = drawCard.textLabelText //テキストをセット
            soundFile.playSound(fileName: "draw", extentionName: "mp3") //カードを引いたときの音を鳴らす
    
            drawCount += 1 //カードを引いた回数を+1
            
        } else {
            
            //もうカードがなかったら、やり直しのアラートを表示
            showAlert(alertTitle: "Play again?",
                      alertMessage: "もう一度遊ぶ",
                      defaultTitle: "Sure!!")
        }
    }
    
    
    //リセットボタンの処理
    @IBAction func resetGame(_ sender: Any) {
        
        showAlert(alertTitle: "Reset game?",
                  alertMessage: "やり直す",
                  defaultTitle: "Yes")
        
    }
    
    
    //設定画面へ遷移
    @IBAction func toSetting(_ sender: Any) {
        
        let SettingVC = storyboard?.instantiateViewController(withIdentifier: "SettingVC") as! SettingViewController //Use Storyboard IDにチェックを入れる
        
        SettingVC.cardsList = self.cardsList //cardsListを渡す
        navigationController?.pushViewController(SettingVC, animated: true)
    
    }
    
 
    //機能：はじめから遊ぶ
    func resetGame() {
        
        cardView.setImage(UIImage(named: "ura"), for: UIControl.State.normal)
        drawCount = 0
        shuffle(cardsList: useCardsList)
        
    }
    
    
    //機能：シャッフル
    func shuffle(cardsList: [CardsModel]) {
        
        self.useCardsList.shuffle()
//        textLabel.isHidden = true
        soundFile.playSound(fileName: "shuffle", extentionName: "mp3")
        
    }
    
    
    //機能：リプレイアラート
    func showAlert(alertTitle: String, alertMessage: String, defaultTitle: String) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: defaultTitle, style: .default, handler: { (action) -> Void in
            self.resetGame()
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alert.addAction(defaultAction);
        alert.addAction(cancel);
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //機能：画像の角丸&枠線
    func marukadoWakusen (button: UIButton) {
        button.imageView!.layer.borderColor = UIColor.systemGray.cgColor
        button.imageView!.layer.borderWidth = 1
        button.imageView!.layer.cornerRadius = button.frame.width / 50
        button.imageView!.layer.masksToBounds = true
    }
    
    //機能：画像をButtonサイズにfill
    func toScaletoFill(button: UIButton) {
        button.imageView?.contentMode = .scaleAspectFill
        button.contentHorizontalAlignment = .fill
        button.contentVerticalAlignment = .fill
    }

}

