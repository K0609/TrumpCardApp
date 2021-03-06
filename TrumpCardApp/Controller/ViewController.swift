//
//  ViewController.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/10/27.
//
import GoogleMobileAds
import UIKit

class ViewController: UIViewController, GADBannerViewDelegate {

    @IBOutlet weak var cardView: UIButton!
    @IBOutlet weak var shuffleButton: UIButton!
    @IBOutlet weak var toSettingButton: UIButton!
    @IBOutlet weak var textLabel: UILabel!
    
    var cardsList = CardsList() //全カード情報となるcardsListをインスタンス化
    var useCardsList = [CardsModel]() //cardsList中のCardsModelの"use"だけを入れる箱
    
    var drawCount: Int = 0 //カードを引いた回数
    var soundFile = SoundFile() //SoundFileモデルをインスタンス化
    
    //admobのバナー
    var bannerView: GADBannerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //バナー
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        addBannerViewToView(bannerView)
        
        //GADBannerVIewのプロバティ
        //リリース用広告ID
        bannerView.adUnitID = "ca-app-pub-2076115814043994/7340909484"
//        //テスト用広告ID
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        
        //広告を読み込む
        bannerView.load(GADRequest())
        
        //広告イベント
        bannerView.delegate = self
        
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
        
        //UserDefaultsからcardsList情報を呼び出し
        if UserDefaults.standard.object(forKey: "cardsList") != nil {
            cardsList = UserDefaults.standard.object(forKey: "cardsList") as! CardsList
        }
        
//        //シャッフル
//        shuffle(cardsList: cardsList.allList)
        
        //cardViewに画像がFillするように設定
        toScaletoFill(button: cardView)
        
        //画像の角丸&枠線
        marukadoWakusen(button: cardView)
        
        
//        //textLabelの見た目を整える
//        textLabel.backgroundColor = UIColor.systemGray
        
        //レイアウト設定
        cardView.translatesAutoresizingMaskIntoConstraints = false
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        toSettingButton.translatesAutoresizingMaskIntoConstraints = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //間隔を設定
        let itvTopToButton = self.view.frame.height * 0.001
//        let itvBottom = -5
        let itvLeading = self.view.frame.width * 0.1
        let itvTrailing = self.view.frame.width * 0.1
        let cardAspectRatio = 1.618

        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: itvLeading),
            cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -itvTrailing),
            cardView.heightAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: cardAspectRatio),
//            cardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            cardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            toSettingButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            toSettingButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(itvTopToButton)),
            shuffleButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            shuffleButton.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: CGFloat(itvTopToButton)),
            textLabel.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 15),
            textLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
            textLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0)
            ])
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
        
        shuffle(cardsList: useCardsList)
    }

    //ATTの許可アラートを表示
    override func viewDidAppear(_ animated: Bool) {
        AppTrackingManager.requestAppTracking()
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
        
        let SettingCardsVC = storyboard?.instantiateViewController(withIdentifier: "SettingCardsVC") as! SettingCardsViewController //Use Storyboard IDにチェックを入れる
        
        SettingCardsVC.cardsList = self.cardsList //cardsListを渡す
        navigationController?.pushViewController(SettingCardsVC, animated: true)
    
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
        textLabel.text = ""
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
}

