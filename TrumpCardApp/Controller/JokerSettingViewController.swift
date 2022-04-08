//
//  JokerSettingViewController.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/11/19.
//

import UIKit

class JokerSettingViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var card1: UIImageView! //joker_1用のimageView
    @IBOutlet weak var card2: UIImageView! //joker_2用のimageView
    @IBOutlet weak var settingOK: UIButton!
    
    
    var cardsList = CardsList() //全カード情報となるcardsListをインスタンス化
    var displayCardsList: [CardsModel] = [] //ここの画面で使うカードのリストの箱を用意
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //この画面で使うカードリストはjokerList
        displayCardsList = cardsList.jokerList
        
        //jokerの数だけ表示
        for n in 1...displayCardsList.count {
            showCard(n: n) //カードを表示
        }
        
        
        for image in [card1, card2] {
            
            image?.contentMode = .scaleToFill
            marukadoWakusen(image: image!)
            image?.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let card1Trailing = card1.trailingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: -self.view.frame.width / 15)
        let card2Leading = card2.leadingAnchor.constraint(equalTo: self.view.centerXAnchor, constant: self.view.frame.width / 15)
        let card1Y = card1.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
        let card2Y = card2.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0)
        let card1Width = card1.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4)
        let card2Width = card2.widthAnchor.constraint(equalToConstant: self.view.frame.width / 4)
        let card1Height = card1.heightAnchor.constraint(equalTo: card1.widthAnchor, multiplier: 1.618)
        let card2Height = card2.heightAnchor.constraint(equalTo: card1.widthAnchor, multiplier: 1.618)

        
        settingOK.translatesAutoresizingMaskIntoConstraints = false
        let settingOKX = settingOK.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let settingOKY = settingOK.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        
        NSLayoutConstraint.activate([card1Trailing,
                                     card2Leading,
                                     card1Y,
                                     card2Y,
                                     card1Width,
                                     card2Width,
                                     card1Height,
                                     card2Height,
                                     settingOKX,
                                     settingOKY
                                    ])
        
        //tapGestureを生成：joker_1用
        let tapGesture1: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(JokerSettingViewController.tapAction(_:)))
        tapGesture1.delegate = self
        self.card1.addGestureRecognizer(tapGesture1) //card1（imageView）にtapGestureを設定
        
        //tapGestureを生成：joker_2用
        let tapGesture2: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(JokerSettingViewController.tapAction(_:)))
        self.card2.addGestureRecognizer(tapGesture2) //card2（imageView）にtapGestureを設定
        
    }
    
    
    //設定OKボタン
    @IBAction func settingOK(_ sender: Any) {
    
        let NC = self.parent as! UINavigationController //navigationController
        let SettingVC = NC.viewControllers[1] as! SettingViewController
        
        cardsList.jokerList = displayCardsList
        SettingVC.cardsList = self.cardsList
        
        navigationController?.popViewController(animated: true)
        
    }
    
    
    //tapされたときの処理
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            if (sender as AnyObject).view.tag > 0 {
            
                let tag = Int((sender as AnyObject).view.tag)

                if displayCardsList[tag - 1].use == true {
                    displayCardsList[tag - 1].use = false
                } else {
                    displayCardsList[tag - 1].use = true

                }

                showCard(n: tag)
            }
        }
    }
    
    
    //viewにカードを表示
    func showCard(n: Int) {
        
        let viewsList = [card1, card2]
        let cardView: UIImageView = viewsList[n - 1]!
        let displayCard: CardsModel = displayCardsList[n - 1]
        
        cardView.image = displayCard.cardImage
        if displayCard.use == true {
            cardView.alpha = 1
        } else {
            cardView.alpha = 0.2
        }
    }
    
    //機能：画像の角丸&枠線
    func marukadoWakusen (image: UIImageView) {
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.layer.borderWidth = 0.5
        image.layer.cornerRadius = image.frame.width / 20
        image.layer.masksToBounds = true
    }
    

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
