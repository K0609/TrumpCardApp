//
//  CustomizeSettingViewController.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/11/19.
//
import GoogleMobileAds
import UIKit

class CustomizeSettingViewController: UIViewController, UINavigationControllerDelegate, CatchProtocol, GADBannerViewDelegate {
    
    //admobのバナー
    var bannerView: GADBannerView!
    
    @IBOutlet weak var collectionView: UICollectionView! //collentionView
    
    var addCardButton: UIBarButtonItem!
    
    var cardsList = CardsList() //全カード情報となるcardsListをインスタンス化
    var displayCardsList: [CardsModel] = [] //ここの画面で使うカードのリストの箱を用意
    var cardImagesList: [UIImage] = [] //collenctionViewに入れるUIImageの箱


    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        self.navigationItem.title = NSLocalizedString("オリジナルカード", comment: "") 
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
        //初期設定パターン① (アイコンを使うパターン)
        addCardButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCardButtonPressed(_:)))
        
        //右側に１つ追加する場合
        self.navigationItem.rightBarButtonItem = addCardButton
        
        //各Delegateの設定
        collectionView.delegate = self
        collectionView.dataSource = self
        
        //collectionViewにCustomCellを登録
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCell")
        
        // 受信先の登録（"reload"という名前の通知を受け取ると、reloadCollectionView()を呼び出す）
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView(notification:)), name: NSNotification.Name(rawValue: "reload"), object: nil)

    }
    
    // コレクションビューの更新（通知された時に呼ばれるメソッド）
    @objc func reloadCollectionView(notification: NSNotification) {
      self.collectionView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //このVCで扱うカードリストをカスタマイズリストに設定
        displayCardsList = cardsList.customizeList
        
        //データのロード
//        for card in cardsList.customizeList {
        for card in displayCardsList {
            cardImagesList.append(card.cardImage)
        }
        
        collectionView.reloadData()
    }
    
    
    //メソッド：CreateVCから値をDelegateを用いてcardsListを取得
    func catchData(cardsList: CardsList) {
        
        self.cardsList = cardsList
        
    }
    
    
//    //ボタン：設定完了（前の画面へ）
//    @IBAction func settingOK(_ sender: Any) {
//
//        let NC = self.parent as! UINavigationController
//        let SettingVC = NC.viewControllers[1] as! SettingViewController
//
//        cardsList.customizeList = displayCardsList
//        SettingVC.cardsList = self.cardsList
//        navigationController?.popViewController(animated: true)
//    }
    
    
    //ボタン：次の画面へ
    @objc func addCardButtonPressed(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "toCreateVC", sender: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        let createVC = segue.destination as! CreateViewController
        cardsList.customizeList = displayCardsList
        createVC.cardsList = cardsList
        createVC.delegate = self //デリゲートの委任の宣言
    }

}


extension CustomizeSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    //セクション数
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    //Itemの数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return displayCardsList.count

    }
    
    //各collectionの作成
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CollectionViewCell

        cell.cellImageView.image = displayCardsList[indexPath.row].cardImage
        cell.cellLabel.text = displayCardsList[indexPath.row].textLabelText
        
        let cellCard = displayCardsList[indexPath.row]
        if cellCard.use == true {
            cell.contentView.alpha = 1
        } else {
            cell.contentView.alpha = 0.2
        }
        
        return cell
    }
    
    //各collectionがtapされたときの処理
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //カードを使う使わない設定
        if let cell = collectionView.cellForItem(at: indexPath) {

            let selectCard = displayCardsList[indexPath.row]
            
            if selectCard.use == true {
                selectCard.use = false
                cell.contentView.alpha = 0.2
            } else {
                selectCard.use = true
                cell.contentView.alpha = 1
            }
        }
    }

}

extension CustomizeSettingViewController: UICollectionViewDelegateFlowLayout {
    
    //レイアウト設定：各collectionのサイズ
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let sectionInsets = UIEdgeInsets(top: 10.0, left: 2.0, bottom: 2.0, right: 2.0)
        let itemsPerRow: CGFloat = 3
        
        let paddingSpace = sectionInsets.left * (itemsPerRow + 1)
        let availableWidth = view.frame.width - paddingSpace
        let widthPerItem = availableWidth / itemsPerRow
        let heightPerItem = widthPerItem * 2

        return CGSize(width: widthPerItem, height: heightPerItem)
    }

    //レイアウト設定：collectionとセルの余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10.0, left: 2.0, bottom: 2.0, right: 2.0)
    }

    //レイアウト設定：各セル行間の余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }

    //レイアウト設定：各セル列間の余白
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
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
