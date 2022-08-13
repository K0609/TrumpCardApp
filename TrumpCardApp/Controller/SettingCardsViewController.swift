//
//  SettingCardsViewController.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2022/04/09.
//
import GoogleMobileAds
import UIKit

class SettingCardsViewController: UIViewController, UIGestureRecognizerDelegate, GADBannerViewDelegate {
    
    //admobのバナー
    var bannerView: GADBannerView!
    
    var cardsList = CardsList() //cardsList

    let spade1ImageView = UIImageView(image: UIImage(named: "spade_1"))
    let spade2ImageView = UIImageView(image: UIImage(named: "spade_2"))
    let spade3ImageView = UIImageView(image: UIImage(named: "spade_3"))
    let spade4ImageView = UIImageView(image: UIImage(named: "spade_4"))
    let spade5ImageView = UIImageView(image: UIImage(named: "spade_5"))
    let spade6ImageView = UIImageView(image: UIImage(named: "spade_6"))
    let spade7ImageView = UIImageView(image: UIImage(named: "spade_7"))
    let spade8ImageView = UIImageView(image: UIImage(named: "spade_8"))
    let spade9ImageView = UIImageView(image: UIImage(named: "spade_9"))
    let spade10ImageView = UIImageView(image: UIImage(named: "spade_10"))
    let spade11ImageView = UIImageView(image: UIImage(named: "spade_11"))
    let spade12ImageView = UIImageView(image: UIImage(named: "spade_12"))
    let spade13ImageView = UIImageView(image: UIImage(named: "spade_13"))
    
    let heart1ImageView = UIImageView(image: UIImage(named: "heart_1"))
    let heart2ImageView = UIImageView(image: UIImage(named: "heart_2"))
    let heart3ImageView = UIImageView(image: UIImage(named: "heart_3"))
    let heart4ImageView = UIImageView(image: UIImage(named: "heart_4"))
    let heart5ImageView = UIImageView(image: UIImage(named: "heart_5"))
    let heart6ImageView = UIImageView(image: UIImage(named: "heart_6"))
    let heart7ImageView = UIImageView(image: UIImage(named: "heart_7"))
    let heart8ImageView = UIImageView(image: UIImage(named: "heart_8"))
    let heart9ImageView = UIImageView(image: UIImage(named: "heart_9"))
    let heart10ImageView = UIImageView(image: UIImage(named: "heart_10"))
    let heart11ImageView = UIImageView(image: UIImage(named: "heart_11"))
    let heart12ImageView = UIImageView(image: UIImage(named: "heart_12"))
    let heart13ImageView = UIImageView(image: UIImage(named: "heart_13"))
    
    let diamond1ImageView = UIImageView(image: UIImage(named: "diamond_1"))
    let diamond2ImageView = UIImageView(image: UIImage(named: "diamond_2"))
    let diamond3ImageView = UIImageView(image: UIImage(named: "diamond_3"))
    let diamond4ImageView = UIImageView(image: UIImage(named: "diamond_4"))
    let diamond5ImageView = UIImageView(image: UIImage(named: "diamond_5"))
    let diamond6ImageView = UIImageView(image: UIImage(named: "diamond_6"))
    let diamond7ImageView = UIImageView(image: UIImage(named: "diamond_7"))
    let diamond8ImageView = UIImageView(image: UIImage(named: "diamond_8"))
    let diamond9ImageView = UIImageView(image: UIImage(named: "diamond_9"))
    let diamond10ImageView = UIImageView(image: UIImage(named: "diamond_10"))
    let diamond11ImageView = UIImageView(image: UIImage(named: "diamond_11"))
    let diamond12ImageView = UIImageView(image: UIImage(named: "diamond_12"))
    let diamond13ImageView = UIImageView(image: UIImage(named: "diamond_13"))
    
    let club1ImageView = UIImageView(image: UIImage(named: "club_1"))
    let club2ImageView = UIImageView(image: UIImage(named: "club_2"))
    let club3ImageView = UIImageView(image: UIImage(named: "club_3"))
    let club4ImageView = UIImageView(image: UIImage(named: "club_4"))
    let club5ImageView = UIImageView(image: UIImage(named: "club_5"))
    let club6ImageView = UIImageView(image: UIImage(named: "club_6"))
    let club7ImageView = UIImageView(image: UIImage(named: "club_7"))
    let club8ImageView = UIImageView(image: UIImage(named: "club_8"))
    let club9ImageView = UIImageView(image: UIImage(named: "club_9"))
    let club10ImageView = UIImageView(image: UIImage(named: "club_10"))
    let club11ImageView = UIImageView(image: UIImage(named: "club_11"))
    let club12ImageView = UIImageView(image: UIImage(named: "club_12"))
    let club13ImageView = UIImageView(image: UIImage(named: "club_13"))
    
    let joker1ImageView = UIImageView(image: UIImage(named: "joker_1"))
    let joker2ImageView = UIImageView(image: UIImage(named: "joker_2"))
    
    let customize0ImageView = UIImageView(image: UIImage(named: "customize_0"))
    
    let spacer1 = UIView()
    let spacer2 = UIView()
    let spacer3 = UIView()
    let spacer4 = UIView()
    let spacer5 = UIView()
    let spacer6 = UIView()
    
    var imageViewsdic: [String: [UIImageView]] = [:]
    var imageViewsdicWithoutCustomize: [String: [UIImageView]] = [:]
    var imageViewsList: [UIImageView] = []
    var imageViewsListWithoutCustomize: [UIImageView] = []
    var spadeImageViewsList: [UIImageView] = []
    var heartImageViewsList: [UIImageView] = []
    var diamondImageViewsList: [UIImageView] = []
    var clubImageViewsList: [UIImageView] = []
    var jokerImageViewsList: [UIImageView] = []
    var customizeImageViewsList: [UIImageView] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //バナー
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        
        //GADBannerVIewのプロバティ
//        //リリース用広告ID
//        bannerView.adUnitID = "ca-app-pub-2076115814043994/7340909484"
        //テスト用広告ID
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        
        //広告を読み込む
        bannerView.load(GADRequest())
        
        //広告イベント
        bannerView.delegate = self
        
        // ナビゲーションタイトル
        self.navigationItem.title = "Setting"
        // ナビゲーションバーのテキストを変更する
        self.navigationController?.navigationBar.titleTextAttributes = [
        // 文字の色
            .foregroundColor: UIColor.systemGray
        ]
        // Backボタンの変更
        self.navigationItem.backBarButtonItem = UIBarButtonItem(
            title: "",
            style: .plain,
            target: nil,
            action: nil
        )
        
        //spadeImageViewsListにスペードのimageViewを追加
        spadeImageViewsList.append(spade1ImageView)
        spadeImageViewsList.append(spade2ImageView)
        spadeImageViewsList.append(spade3ImageView)
        spadeImageViewsList.append(spade4ImageView)
        spadeImageViewsList.append(spade5ImageView)
        spadeImageViewsList.append(spade6ImageView)
        spadeImageViewsList.append(spade7ImageView)
        spadeImageViewsList.append(spade8ImageView)
        spadeImageViewsList.append(spade9ImageView)
        spadeImageViewsList.append(spade10ImageView)
        spadeImageViewsList.append(spade11ImageView)
        spadeImageViewsList.append(spade12ImageView)
        spadeImageViewsList.append(spade13ImageView)
        
        //heartImageViewsListにハートのimageViewを追加
        heartImageViewsList.append(heart1ImageView)
        heartImageViewsList.append(heart2ImageView)
        heartImageViewsList.append(heart3ImageView)
        heartImageViewsList.append(heart4ImageView)
        heartImageViewsList.append(heart5ImageView)
        heartImageViewsList.append(heart6ImageView)
        heartImageViewsList.append(heart7ImageView)
        heartImageViewsList.append(heart8ImageView)
        heartImageViewsList.append(heart9ImageView)
        heartImageViewsList.append(heart10ImageView)
        heartImageViewsList.append(heart11ImageView)
        heartImageViewsList.append(heart12ImageView)
        heartImageViewsList.append(heart13ImageView)

        //diamondImageViewsListにダイヤのimageViewを追加
        diamondImageViewsList.append(diamond1ImageView)
        diamondImageViewsList.append(diamond2ImageView)
        diamondImageViewsList.append(diamond3ImageView)
        diamondImageViewsList.append(diamond4ImageView)
        diamondImageViewsList.append(diamond5ImageView)
        diamondImageViewsList.append(diamond6ImageView)
        diamondImageViewsList.append(diamond7ImageView)
        diamondImageViewsList.append(diamond8ImageView)
        diamondImageViewsList.append(diamond9ImageView)
        diamondImageViewsList.append(diamond10ImageView)
        diamondImageViewsList.append(diamond11ImageView)
        diamondImageViewsList.append(diamond12ImageView)
        diamondImageViewsList.append(diamond13ImageView)

        //clubImageViewsListにクラブのimageViewを追加
        clubImageViewsList.append(club1ImageView)
        clubImageViewsList.append(club2ImageView)
        clubImageViewsList.append(club3ImageView)
        clubImageViewsList.append(club4ImageView)
        clubImageViewsList.append(club5ImageView)
        clubImageViewsList.append(club6ImageView)
        clubImageViewsList.append(club7ImageView)
        clubImageViewsList.append(club8ImageView)
        clubImageViewsList.append(club9ImageView)
        clubImageViewsList.append(club10ImageView)
        clubImageViewsList.append(club11ImageView)
        clubImageViewsList.append(club12ImageView)
        clubImageViewsList.append(club13ImageView)
        
        //jokerImageViewsListにジョーカーのimageViewを追加
        jokerImageViewsList.append(joker1ImageView)
        jokerImageViewsList.append(joker2ImageView)

        //customizeImageViewsListにカスタマイズのimageViewを追加
        customizeImageViewsList.append(customize0ImageView)
        
        //それぞれのリストをimageViewsListに追加
        imageViewsdic = ["spade": spadeImageViewsList,
                         "heart": heartImageViewsList,
                         "diamond": diamondImageViewsList,
                         "club": clubImageViewsList,
                         "joker": jokerImageViewsList,
                         "customize": customizeImageViewsList
        ]
        
        imageViewsdicWithoutCustomize = ["spade": spadeImageViewsList,
                                         "heart": heartImageViewsList,
                                         "diamond": diamondImageViewsList,
                                         "club": clubImageViewsList,
                                         "joker": jokerImageViewsList,
        ]

        imageViewsList = spadeImageViewsList + heartImageViewsList + diamondImageViewsList + clubImageViewsList + jokerImageViewsList + customizeImageViewsList
        
        imageViewsListWithoutCustomize = spadeImageViewsList + heartImageViewsList + diamondImageViewsList + clubImageViewsList + jokerImageViewsList
        
        //すべてのカードをオートレイアウト設定してviewに追加
        for (_, val) in imageViewsdic {
            for imageView in val {
                
                imageView.translatesAutoresizingMaskIntoConstraints = false
                self.view.addSubview(imageView)

            }
        }
        
        //レイアウトのためだけに使うスペーサーオブジェクトも同じことする
        let spacerList = [spacer1, spacer2, spacer3, spacer4, spacer5, spacer6]
        for spacer in spacerList {
            
            spacer.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(spacer)
            
        }
        
 
        //レイアウト設定
        //間隔を設定
        let itvTop = self.view.frame.height * 0.05
        let itvBottom = self.view.frame.height * 0.05 + 50
        let itvLeading = self.view.frame.width * 0.1
        let itvTrailing = self.view.frame.width * 0.1
        let itvBtwMarksHeight = self.view.frame.height * 0.010
//        let itvInMarkHeight = self.view.frame.height * 0.025
//        let itvInMarkWidth = self.view.frame.height * 0.01
        let cardAspectRatio = 1.618
        let ratioWithCard1 = 0.45

        //レイアウト設定を格納する配列を準備
        var activateList = [NSLayoutConstraint]()

        //spade1のレイアウト設定
        activateList.append(spade1ImageView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: itvTop))
        activateList.append(spade1ImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: itvLeading))
        activateList.append(spade1ImageView.widthAnchor.constraint(equalTo: spade1ImageView.heightAnchor, multiplier: 1/cardAspectRatio))

        //heart1のレイアウト設定
        activateList.append(heart1ImageView.topAnchor.constraint(equalTo: spade1ImageView.bottomAnchor, constant: itvBtwMarksHeight))
        activateList.append(heart1ImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: itvLeading))
        activateList.append(heart1ImageView.heightAnchor.constraint(equalTo: spade1ImageView.heightAnchor, multiplier: 1))
        activateList.append(heart1ImageView.widthAnchor.constraint(equalTo: heart1ImageView.heightAnchor, multiplier: 1/cardAspectRatio))

        //diamond1のレイアウト設定
        activateList.append(diamond1ImageView.topAnchor.constraint(equalTo: heart1ImageView.bottomAnchor, constant: itvBtwMarksHeight))
        activateList.append(diamond1ImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: itvLeading))
        activateList.append(diamond1ImageView.heightAnchor.constraint(equalTo: spade1ImageView.heightAnchor, multiplier: 1))
        activateList.append(diamond1ImageView.widthAnchor.constraint(equalTo: diamond1ImageView.heightAnchor, multiplier: 1/cardAspectRatio))

        //club1のレイアウト設定
        activateList.append(club1ImageView.topAnchor.constraint(equalTo: diamond1ImageView.bottomAnchor, constant: itvBtwMarksHeight))
        activateList.append(club1ImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: itvLeading))
        activateList.append(diamond1ImageView.heightAnchor.constraint(equalTo: spade1ImageView.heightAnchor, multiplier: 1))
        activateList.append(club1ImageView.widthAnchor.constraint(equalTo: club1ImageView.heightAnchor, multiplier: 1/cardAspectRatio))
        
        //joker1のレイアウト設定
        activateList.append(joker1ImageView.topAnchor.constraint(equalTo: club1ImageView.bottomAnchor, constant: itvBtwMarksHeight))
        activateList.append(joker1ImageView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -itvBottom))
        activateList.append(joker1ImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: itvLeading))
        activateList.append(joker1ImageView.heightAnchor.constraint(equalTo: spade1ImageView.heightAnchor, multiplier: 1))
        activateList.append(joker1ImageView.widthAnchor.constraint(equalTo: joker1ImageView.heightAnchor, multiplier: 1/cardAspectRatio))

        //joker2のレイアウト設定
        activateList.append(joker2ImageView.topAnchor.constraint(equalTo: joker1ImageView.topAnchor, constant: 0))
        activateList.append(joker2ImageView.leadingAnchor.constraint(equalTo: spacerList[0].trailingAnchor, constant: 0))
        activateList.append(joker2ImageView.heightAnchor.constraint(equalTo: spade1ImageView.heightAnchor, multiplier: 1))
        activateList.append(joker2ImageView.widthAnchor.constraint(equalTo: joker2ImageView.heightAnchor, multiplier: 1/cardAspectRatio))
        
        //customize0のレイアウト設定
        activateList.append(customize0ImageView.topAnchor.constraint(equalTo: joker1ImageView.topAnchor, constant: 0))
        activateList.append(customize0ImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -itvTrailing))
        activateList.append(customize0ImageView.heightAnchor.constraint(equalTo: spade1ImageView.heightAnchor, multiplier: 1))
        activateList.append(customize0ImageView.widthAnchor.constraint(equalTo: customize0ImageView.heightAnchor, multiplier: 1/cardAspectRatio))
        
        //spacerのレイアウト設定
        activateList.append(spacer1.leadingAnchor.constraint(equalTo: spade1ImageView.trailingAnchor, constant: 0))
        activateList.append(spacer2.leadingAnchor.constraint(equalTo: spade13ImageView.trailingAnchor, constant: 0))
        activateList.append(spacer3.leadingAnchor.constraint(equalTo: spade12ImageView.trailingAnchor, constant: 0))
        activateList.append(spacer4.leadingAnchor.constraint(equalTo: spade11ImageView.trailingAnchor, constant: 0))
        activateList.append(spacer5.leadingAnchor.constraint(equalTo: spade10ImageView.trailingAnchor, constant: 0))
        activateList.append(spacer6.leadingAnchor.constraint(equalTo: spade9ImageView.trailingAnchor, constant: 0))
        for i in (1...5) {
            activateList.append(spacerList[i].widthAnchor.constraint(equalTo: spacer1.widthAnchor, multiplier: 1))
        }

        
        //各カードのwidthはheightから決まるので、横に等間隔に配置する記述に変更
        //各柄2~kingのレイアウト設定
        for (key, _) in imageViewsdic {
            
            let egara = ["spade", "heart", "diamond", "club"]
            if egara.contains(key) {
                
                for j in 1..<imageViewsdic[key]!.count {
                    
                    //縦横サイズをエースのratioWithCard1倍に設定
                    activateList.append(imageViewsdic[key]![j].widthAnchor.constraint(equalTo: imageViewsdic[key]![0].widthAnchor, multiplier: ratioWithCard1))
                    activateList.append(imageViewsdic[key]![j].heightAnchor.constraint(equalTo: imageViewsdic[key]![0].heightAnchor, multiplier: ratioWithCard1))
                    
                    //2~13(king)のカードナンバーを取得
                    let cardNumber = j + 1
                    
                    //上段のカードはエースの上揃え
                    if cardNumber >= 8 {
                        activateList.append(imageViewsdic[key]![j].topAnchor.constraint(equalTo: imageViewsdic[key]![0].topAnchor))
                    }
                    
                    //下段のカードはエースの上揃え
                    if cardNumber <= 7 {
                        activateList.append(imageViewsdic[key]![j].bottomAnchor.constraint(equalTo: imageViewsdic[key]![0].bottomAnchor))
                    }
                    
                    //
                    switch cardNumber {
                    case 13:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[0].trailingAnchor, constant: 0))
                    case 12:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[1].trailingAnchor, constant: 0))
                    case 11:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[2].trailingAnchor, constant: 0))
                    case 10:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[3].trailingAnchor, constant: 0))
                    case 9:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[4].trailingAnchor, constant: 0))
                    case 8:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[5].trailingAnchor, constant: 0))
                        activateList.append(imageViewsdic[key]![j].trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -itvTrailing))
                    case 7:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[0].trailingAnchor, constant: 0))
                    case 6:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[1].trailingAnchor, constant: 0))
                    case 5:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[2].trailingAnchor, constant: 0))
                    case 4:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[3].trailingAnchor, constant: 0))
                    case 3:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[4].trailingAnchor, constant: 0))
                    case 2:
                        activateList.append(imageViewsdic[key]![j].leadingAnchor.constraint(equalTo: spacerList[5].trailingAnchor, constant: 0))
                        activateList.append(imageViewsdic[key]![j].trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -itvTrailing))
                        
                    default:
                        print("default")
                    }
                }
            }
        }
    
        //上記レイアウト設定を有効化
        NSLayoutConstraint.activate(activateList)
        
        
        //各カードのscaleToFill & 丸角枠線 & tapgesture設定
        //【spade~jokerの設定】spade1から順に、tagを0から設定
        for i in 0..<imageViewsListWithoutCustomize.count {
            
            let tag = i
            let imageView = imageViewsListWithoutCustomize[i]
            
            //scaleToFillにして丸角と枠線をつける設定
            imageView.contentMode = .scaleToFill
            marukadoWakusen(image: imageView)
            
            //tapgesture設定
            imageView.tag = tag
            imageView.isUserInteractionEnabled = true
            
            //まずすべてにtapの設定
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(
                target: self,
                action: #selector(SettingCardsViewController.tapAction(_:)))
            tapGesture.delegate = self
            imageView.addGestureRecognizer(tapGesture)
            
            //longTapも設定
            let longPressGesture = UILongPressGestureRecognizer(
                target: self,
                action: #selector(SettingCardsViewController.longPressAction(_:)))
            longPressGesture.delegate = self
            imageView.addGestureRecognizer(longPressGesture)
            
        }
        
        //全カードの透明度表示設定（ゲームに使用or不使用の表示設定）
        for i in 0..<(imageViewsListWithoutCustomize.count - 1) {
            
            switchAlpha(tag: i)
        
        }
        
        
        //customize0ImageViewの設定
        //scaleToFillにして丸角と枠線をつける設定
        let imageView = customize0ImageView
        imageView.contentMode = .scaleToFill
        
        //tapgesture設定
        imageView.tag = 54
        imageView.isUserInteractionEnabled = true
        
        //tapの設定
        let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(SettingCardsViewController.customize0TapAction(_:)))
        tapGesture.delegate = self
        imageView.addGestureRecognizer(tapGesture)
        
        //longTapも設定
        let longPressGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(SettingCardsViewController.customize0LongPressAction(_:)))
        longPressGesture.delegate = self
        imageView.addGestureRecognizer(longPressGesture)
        
    
    //viewDidLoadここまで
    }
    
    
    
    //機能：画像の角丸&枠線
    func marukadoWakusen (image: UIImageView) {
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.layer.borderWidth = 0.5
        image.layer.cornerRadius = 2
        image.layer.masksToBounds = true
    }
    
    //longPressのボタンの処理
    @objc func longPressAction(_ sender: UILongPressGestureRecognizer){
        
        if sender.state == .began {
            //longTapが開始されたときの処理
            longPressAlert()
            
        } else if sender.state == .ended {
            //longTapが終わったときの処理
            //処理なし
        }
    }
    
    
    //longPressが押されたときに表示するアラート
    func longPressAlert() {
        
        //アラートの作成
        let alert = UIAlertController(title: "Card Setting", message: "使う？使わない？", preferredStyle: .alert)
        
        //SelectAllボタンを作成
        let sellectAll = UIAlertAction(title: "Sellect all", style: .default, handler: { (action) -> Void in
            //すべてのカードのuseをtrueにする
            for i in 0..<self.imageViewsListWithoutCustomize.count {
                self.imageViewsListWithoutCustomize[i].alpha = 1
                self.cardsList.allList[i].use = true
//            for i in 0..<self.imageViewsdic[key]!.count {
//                self.imageViewsdic[key]![i].alpha = 1
//                self.cardsList.allList[tag + i].use = true
            }
        })
        
        //ClearAllボタンを作成
        let clearAll = UIAlertAction(title: "Clear all", style: .default, handler: { (action) -> Void in
            //すべてのカードのuseをfalseにする
            for i in 0..<self.imageViewsListWithoutCustomize.count {
                self.imageViewsListWithoutCustomize[i].alpha = 0.2
                self.cardsList.allList[i].use = false
//            for i in 0..<self.imageViewsdic[key]!.count {
//                self.imageViewsdic[key]![i].alpha = 0.2
//                self.cardsList.allList[tag + i].use = false
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
    
    
    //tapの処理
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {

            //どのカードがタップされたかを判断して,
            let tag = (sender as AnyObject).view.tag
            if tag < 54 {
                //もともとuseがtrueならfalseへ、falseならtrueへ
                if cardsList.allList[tag].use == true {
                    cardsList.allList[tag].use = false
                } else {
                    cardsList.allList[tag].use = true
                }
                //viewを更新
                switchAlpha(tag: tag)
            }
        }
    }
    
    
    //機能:ImageViewにカードを表示
    func switchAlpha(tag: Int) {
        
        var key: String = ""
        var i: Int = 0
        
        switch tag {
        case 0...12:
            key = "spade"
            i = tag
        case 13...25:
            key = "heart"
            i = tag - 13
        case 26...38:
            key = "diamond"
            i = tag - 26
        case 39...51:
            key = "club"
            i = tag - 39
        case 52...53:
            key = "joker"
            i = tag - 52
        case 54:
            key = "customize"
            i = tag - 54
        default:
            print("default")
        }
        
        //ImageViewのリスト中から表示場所のviewを選択
        let cardImageView: UIImageView = imageViewsdic[key]![i]
        //カードリストの中から表示させるカードモデルを選択
        let displayCardModel: CardsModel = cardsList.allList[tag]
        
        //画像のセット
        cardImageView.image = displayCardModel.cardImage
        //trueかfalseかでAlpha値の設定
        if displayCardModel.use == true {
            cardImageView.alpha = 1
        } else {
            cardImageView.alpha = 0.2
        }
    }
    

    //customize0LongPressのボタンの処理
    @objc func customize0LongPressAction(_ sender: UILongPressGestureRecognizer){
        
        if sender.state == .began {
            //longTapが開始されたときの処理
            customize0LongPressAlert()
            
        } else if sender.state == .ended {
            //longTapが終わったときの処理
            //処理なし
        }
    }
    
    //customize0LongPressが押されたときに表示するアラート
    func customize0LongPressAlert() {
        
        //アラートの作成
        let alert = UIAlertController(title: "Card Setting", message: "使う？使わない？", preferredStyle: .alert)
        
        //SelectAllボタンを作成
        let sellectAll = UIAlertAction(title: "Sellect all", style: .default, handler: { (action) -> Void in
//            カスタマイズカードをすべてオンにする処理
//            //すべてのカードのuseをtrueにする
//            for i in 0..<self.imageViewsListWithoutCustomize.count {
//                self.imageViewsListWithoutCustomize[i].alpha = 1
//                self.cardsList.allList[i].use = true
//            }
        })
        
        //ClearAllボタンを作成
        let clearAll = UIAlertAction(title: "Clear all", style: .default, handler: { (action) -> Void in
//            カスタマイズカードをすべてオフにする処理
//            //すべてのカードのuseをfalseにする
//            for i in 0..<self.imageViewsListWithoutCustomize.count {
//                self.imageViewsListWithoutCustomize[i].alpha = 0.2
//                self.cardsList.allList[i].use = false
//            }
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
        
    //tapの処理
    @objc func customize0TapAction(_ sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {

            //どのカードがタップされたかを判断して,
            let tag = (sender as AnyObject).view.tag
            if tag == 54 {
                let CustomizeSettingVC = storyboard?.instantiateViewController(withIdentifier: "CustomizeSettingVC") as! CustomizeSettingViewController
                CustomizeSettingVC.cardsList = cardsList
                navigationController?.pushViewController(CustomizeSettingVC, animated: true)
            }
        }
    }
    
    //バナー
    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        NSLayoutConstraint.activate([
            bannerView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: 0),
            bannerView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        ])
    
    }

    
    //各種バナー広告イベントの実装
    
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        //広告が取得されるまで、ビュー階層に GADBannerView を追加するのを遅らせたい場合
        addBannerViewToView(bannerView)
        
        //バナー広告をアニメーション表示
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
          bannerView.alpha = 1
        })

//      print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
//      print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
//      print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
//      print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
//      print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
//      print("bannerViewDidDismissScreen")
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

