//
//  ViewController.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/10/27.
//
import GoogleMobileAds
import UIKit

class ViewController: UIViewController, GADBannerViewDelegate, GADFullScreenContentDelegate {

    @IBOutlet weak var cardView: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var toSettingButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var modeButton: UIButton!
    
    @IBOutlet weak var KCModeCardViewWidth: NSLayoutConstraint!
    @IBOutlet weak var KCModeCardViewBottom: NSLayoutConstraint!
    @IBOutlet weak var NModeCardViewCenterY: NSLayoutConstraint!
    
    var cardsList = CardsList() //全カード情報となるcardsListをインスタンス化
    var useCardsList = [CardsModel]() //cardsList中のCardsModelの"use"だけを入れる箱
    
    var drawCount: Int = 0 //カードを引いた回数
    var soundFile = SoundFile() //SoundFileモデルをインスタンス化
    
    var currentCard: CardsModel!
    var currentMode: String = "NOMAL MODE"
    
    //Admobのバナー
    var bannerView: GADBannerView!
    //AdMobのインタースティシャル
    var interstitial: GADInterstitialAd?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // アプリ起動時・フォアグラウンド復帰時の通知を設定する
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(ViewController.onWillEnterForeground(_:)),
          name: UIApplication.willEnterForegroundNotification,
          object: nil
        )
        
        // バックグラウンド遷移時の通知を設定する
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(ViewController.onDidEnterBackground(_:)),
          name: UIApplication.didEnterBackgroundNotification,
          object: nil
        )
        
        //BannerViewを生成しViewにはりつける
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        
        //GADBannerViewのプロバティ
        if let id = adUnitID(key: "bannerID") {
            bannerView.adUnitID = id
            bannerView.rootViewController = self
            bannerView.load(GADRequest())
        }

        //広告イベント
        bannerView.delegate = self
        
        // インタースティシャル広告を作成し読み込む
        createAndLoadInterstitial()
        
        
        //　ナビゲーションバーの背景色
        self.navigationController?.navigationBar.barTintColor = .clear
        // ナビゲーションバーのアイテムの色　（戻る　＜　とか　読み込みゲージとか）
        self.navigationController?.navigationBar.tintColor = .systemGray
        // ナビゲーションタイトル
        self.navigationItem.title = ""
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
        
        
        //cardViewに画像がFillするように設定
        toScaletoFill(button: cardView)
        
        //画像の角丸&枠線
        marukadoWakusen(button: cardView)
        
        //textLabelの見た目を整える
        textLabel.font = UIFont(name: "Futura-Medium", size: 17)
        textLabel.backgroundColor = .clear
        textLabel.isHidden = true
        
        //textViewの見た目を整える
        textView.font = UIFont(name: "Futura-Medium", size: 16)
        textView.backgroundColor = .clear
        textView.isHidden = true
        textView.text = ""
        textView.textAlignment = NSTextAlignment.natural
        textView.layer.masksToBounds = true
        textView.layer.cornerRadius = 5.0
        textView.layer.borderWidth = 0.5
        textView.layer.borderColor = UIColor.systemGray.cgColor
        textView.isEditable = false
        
        print(currentMode)
        
        //レイアウトを設定
        layout(currentMode: currentMode)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        //useCardsListから"use"のカードだけを抽出
//        useCardsList = cardsList.allList.filter({$0.use})
        
        useCardsList = []
        for lst in [cardsList.spadeList,
                    cardsList.heartList,
                    cardsList.diamondList,
                    cardsList.clubList,
                    cardsList.jokerList,
                    cardsList.customizeList] {
            for card in lst {
                if card.use == true {
                    useCardsList.append(card)
                }
            }
        }

        //シャッフル
        shuffle(cardsList: useCardsList)
        
    }
    

    //ATTの許可アラートを表示
    override func viewDidAppear(_ animated: Bool) {
        AppTrackingManager.requestAppTracking()
    }
    
    
    // バックグラウンド遷移時に行う処理
    @objc func onDidEnterBackground(_ notification: Notification?) {
        //UserDefaultsにModeを保存
        UserDefaults.standard.set(currentMode, forKey: "currentMode")
    }

    
    // アプリ起動時・フォアグラウンド復帰時に行う処理
    @objc func onWillEnterForeground(_ notification: Notification?) {
        // ココに処理
        //UserDefaultsからMODEを呼び出し
        if UserDefaults.standard.object(forKey: "currentMode") != nil {
            currentMode = UserDefaults.standard.object(forKey: "currentMode") as! String
        }
        
        //レイアウトを設定
        layout(currentMode: currentMode)
     }
    
    
    //cardを引くときの処理
    @IBAction func drawCard(_ sender: Any) {

        //山札からカードを引いた回数を確認して、
        if drawCount < useCardsList.count {
            
            //まだカードがあるなら次のカードがあるなら次のカードを表示
            currentCard = useCardsList[drawCount]
            let drawCardImage = currentCard.cardImage
            
            cardView.setImage(drawCardImage, for: UIControl.State.normal) //画像をセット
            
            if currentMode == "NOMAL MODE" {
                if currentCard.cardType == "regular" {
                    textLabel.isHidden = true
                } else if currentCard.cardType == "custom" {
                    textLabel.isHidden = false
                    textLabel.text = currentCard.textLabelText //テキストをセット
                }
                textView.isHidden = true

            } else if currentMode == "KING's CUP MODE"{
                textLabel.isHidden = false
                textLabel.text = currentCard.textLabelText //テキストをセット
                textView.isHidden = false
                textView.text = currentCard.textViewText //テキストをセット

            }
            
            soundFile.playSound(fileName: "draw", extentionName: "mp3") //カードを引いたときの音を鳴らす
    
            drawCount += 1 //カードを引いた回数を+1
            
        } else {
            
            //もうカードがなかったら、やり直しのアラートを表示
            showAlert(alertTitle: "Play again?",
                      alertMessage: "もう一度遊ぶ",
                      defaultTitle: NSLocalizedString("もろちん!!", comment: ""))
        }
    }
    
    //リセットボタンの処理
    @IBAction func resetGame(_ sender: Any) {
        
        showAlert(alertTitle: "Reset game?",
                  alertMessage: "やり直す",
                  defaultTitle: NSLocalizedString("そうする!", comment: ""))
        
    }
    
    
    //設定画面へ遷移
    @IBAction func toSetting(_ sender: Any) {
        
        let SettingCardsVC = storyboard?.instantiateViewController(withIdentifier: "SettingCardsVC") as! SettingCardsViewController //Use Storyboard IDにチェックを入れる
        
        SettingCardsVC.cardsList = self.cardsList //cardsListを渡す
        navigationController?.pushViewController(SettingCardsVC, animated: true)
    
    }
    
    
    //遊びMODEの変更
    @IBAction func changeMode(_ sender: Any) {
        
        //currentMODEの変更
        if currentMode == "NOMAL MODE" {
            currentMode = "KING's CUP MODE"
            modeButton.backgroundColor = UIColor.systemPink
            
            //ボタンの表示名を変更
            modeButton.setTitle(NSLocalizedString("キングスカップモード", comment: "") , for: .normal)
            
        } else if currentMode == "KING's CUP MODE" {
            currentMode = "NOMAL MODE"
            modeButton.backgroundColor = UIColor.systemGreen
            
            //ボタンの表示名を変更
            modeButton.setTitle(NSLocalizedString("ノーマルモード", comment: "") , for: .normal)

        }
        
        
        
        //textLabelの表示をcurrentMODEに対応
        if currentCard != nil {
            
            //NOMAL MODEの場合
            if currentMode == "NOMAL MODE" {
                if currentCard.cardType == "regular" {
//                    textLabel.text = ""
                    textLabel.isHidden = true
                } else if currentCard.cardType == "custom" {
                    textLabel.text = currentCard.textLabelText //テキストをセット
                }
                textView.isHidden = true

            //KINGs CUP MODEの場合
            } else if currentMode == "KING's CUP MODE" {
                textLabel.isHidden = false
                textLabel.text = currentCard.textLabelText //テキストをセット
                textView.isHidden = false
                textView.text = currentCard.textViewText //テキストをセット
            }
        }
        
        //レイアウトを変更
        layout(currentMode: currentMode)
    }
    
   
    //機能：はじめから遊ぶ
    func resetGame() {
        
        cardView.setImage(UIImage(named: "ura"), for: UIControl.State.normal)
        currentCard = nil
        textLabel.text = ""
        textLabel.isHidden = true
        textView.text = ""
        textView.isHidden = true
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
            self.displayInterStitial()
            self.resetGame()
        })
        
        let cancel = UIAlertAction(title: NSLocalizedString("やめとく", comment: ""), style: .cancel, handler: { (action) -> Void in
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
     
    
    //レイアウトを変更するメソッド
    func layout(currentMode: String) {
        
        if currentMode == "NOMAL MODE" {
            NSLayoutConstraint.deactivate([KCModeCardViewWidth, KCModeCardViewBottom])
            NSLayoutConstraint.activate([NModeCardViewCenterY])
           
        } else if currentMode == "KING's CUP MODE" {
            NSLayoutConstraint.deactivate([NModeCardViewCenterY])
            NSLayoutConstraint.activate([KCModeCardViewWidth, KCModeCardViewBottom])

        }
    }

    // info.plistから広告IDを取得して返す関数
    func adUnitID(key: String) -> String? {
        guard let adUnitIDs = Bundle.main.object(forInfoDictionaryKey: "AdUnitIDs") as? [String: String] else {
            return nil
        }
        return adUnitIDs[key]
    }
    
    //バナー
    func addBannerViewToView(_ bannerView: GADBannerView) {
        view.addSubview(bannerView)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
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
    
    
    // インタースティシャル広告を作成し読み込むメソッド
    func createAndLoadInterstitial(){
        if let id = adUnitID(key: "interstitialID") {
            GADInterstitialAd.load(withAdUnitID: id, request: GADRequest()) { [weak self] (ad, error) in
                if let error = error {
                    print(error.localizedDescription)
                }
                self?.interstitial = ad
                self?.interstitial?.fullScreenContentDelegate = self
            }
        }
    }
    
    // インタースティシャル広告の実行するメソッド
    func displayInterStitial() {
        if interstitial != nil {
            self.interstitial?.present(fromRootViewController: self)
        } else {
          print("Ad wasn't ready")
        }
    }
    
    // 各種インタースティシャル広告の設定
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
      print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad will present full screen content.
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
      print("Ad will present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        createAndLoadInterstitial()
        print("Ad did dismiss full screen content.")
    }
    
}

