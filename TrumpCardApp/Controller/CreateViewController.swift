//
//  CreateViewController.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2022/02/19.
//
import GoogleMobileAds
import UIKit
import CropViewController

protocol CatchProtocol{
    func catchData(cardsList: CardsList)
}


class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate, UINavigationControllerDelegate, CropViewControllerDelegate, GADBannerViewDelegate {
    
    //admobのバナー
    var bannerView: GADBannerView!
    
    @IBOutlet weak var textField: UITextField! //textField
    @IBOutlet weak var cardView: UIImageView! //imageView
    @IBOutlet weak var settingOK: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    var delegate: CatchProtocol? //前の画面に値を渡すためのプロトコル
    var cardsList = CardsList() //全カード情報となるcardsListをインスタンス化
    var currentImage: UIImage! //新たに追加しようとしているUIImage
    var currentText: String = "" //新たに追加しようとしているテキスト
    
    var nowCropping = false //カード作成中かどうか（ViewDidAppearの判断用）
    
    //カメラ、アルバムを使えるようにするCheckPermissionモデルをインスタンス化
    var checkPermission = CheckPermission()
    
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

        //レイアウト設定
        cardView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        settingOK.translatesAutoresizingMaskIntoConstraints = false
        backButton.translatesAutoresizingMaskIntoConstraints = false

        //間隔を設定
        let btwButtonAndCard = -20
//        let itvBottom = -20
        let itvLeading = self.view.frame.width * 0.1
        let itvTrailing = self.view.frame.width * 0.1
        let cardAspectRatio = 1.618

        NSLayoutConstraint.activate([
            cardView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: itvLeading),
            cardView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -itvTrailing),
            cardView.heightAnchor.constraint(equalTo: cardView.widthAnchor, multiplier: cardAspectRatio),
//            cardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
//            cardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.frame.height * 0.05),
            cardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: 0),
            settingOK.trailingAnchor.constraint(equalTo: cardView.trailingAnchor),
            settingOK.bottomAnchor.constraint(equalTo: cardView.topAnchor, constant: CGFloat(btwButtonAndCard)),
            backButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor),
            backButton.centerYAnchor.constraint(equalTo: settingOK.centerYAnchor, constant: 0),
            textField.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 5),
//            textField.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: CGFloat(itvBottom)),
            textField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0),
            textField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0)
        ])
        
        //
//        textField.backgroundColor = UIColor.systemGray
        textField.placeholder = "ここに文字もいれられるよう"
        
        //各Delegateの設定
        textField.delegate = self
        
        //カメラ、アルバムの使用可否を表示
        checkPermission.showCheckPermission()
        
        //imageViewにtapGestureを追加
        let tapGesture1: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(CreateViewController.tapAction(_:)))
        tapGesture1.delegate = self
        self.cardView.addGestureRecognizer(tapGesture1)
        
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        if (nowCropping == false && currentImage == nil) {
            showAlert(alertTitle: "Make your original card!!", alertMessage: "カード作っちゃお!!")

        }
    }
    
    //ボタン：設定完了
    @IBAction func settingOK(_ sender: Any) {
        
        //もし画像が選択されていれば、
        if currentImage != nil {
            
            //新しく作成するカードに番号をつけるために、すでにあるカード枚数を取得
            let customizeCardNumber = cardsList.customizeList.count + 1
            //新しくカードを作成
            let customizeCard = CardsModel(cardImage: currentImage,
                                           cardType: "custom",
                                           cardMark: "customize",
                                           cardNumber: customizeCardNumber,
                                           textLabelText: currentText,
                                           textViewText: ""
                                           )
            //カードリストに新しく作成したカードを追加
            cardsList.customizeList.append(customizeCard)
            
//            //documentDirectoryにcurrentImageを保存
//            guard let imageData = currentImage.jpegData(compressionQuality: 1.0) else {
//                return
//            }
//
//            do {
//                try imageData.write(to: getFileURL(fileName: "customize_\(customizeCardNumber).jpg"))
//                print("Image saved.")
//            } catch {
//                print("Failed to save the image:", error)
//            }
            
            //collectionViewに新カードが追加されたことを通知
            NotificationCenter.default.post(name: NSNotification.Name("reload"), object: nil)

            
            //新しくカードを追加したので、
            textField.text = "" //textFieldを空にして、
            currentText = "" //currentテキストを空にして、
            cardView.image = UIImage(systemName: "photo") //imageViewをデフォルトに戻して
            currentImage = nil //currentImageを空にする
            
            //前の画面にcardsListを渡しながら遷移
            delegate?.catchData(cardsList: cardsList)
            dismiss(animated: true, completion: nil)
           
        //画像が選択されていない場合、
        } else {
            
            //アラートを表示
            showPhotoAlert()
            
        }
    }
    
    
    //前の画面に戻る
    @IBAction func back(_ sender: Any) {
        
        //前の画面にcardsListを渡しながら遷移
        delegate?.catchData(cardsList: cardsList)
        dismiss(animated: true, completion: nil)
        
    }
    
    
    
    //画像が選択されていないときに表示するアラート
    func showPhotoAlert () {
        
        let alert = UIAlertController(title: "No image selected!!", message: "画像が選択されていませんわよ！！", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alert.addAction(cancel);
        self.present(alert, animated: true, completion: nil)
        
    }
        
    
    //カードを作成するためのアラートを表示
    @objc func tapAction(_ sender: UITapGestureRecognizer) {
        
        if sender.state == .ended {
            
            showAlert(alertTitle: "Make your original card!!", alertMessage: "カード作っちゃお!!")
        
        }
    }
    
    //カメラか、アルバムを使うかのアラートの設定
    func showAlert(alertTitle: String, alertMessage: String) {
        
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        
        let camera = UIAlertAction(title: "Camera", style: .default, handler: { (action) -> Void in
            let sourceType: UIImagePickerController.SourceType = .camera //カメラ機能を立ち上げる設定
            self.createImagePicker(sourceType: sourceType) //立ち上げ
        })
        
        let album = UIAlertAction(title: "Album", style: .default, handler: { (action) -> Void in
            let sourceType: UIImagePickerController.SourceType = .photoLibrary //アルバム機能を立ち上げる設定
            self.createImagePicker(sourceType: sourceType) //立ち上げ
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alert.addAction(camera);
        alert.addAction(album);
        alert.addAction(cancel);
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    
    //カメラorアルバム機能を立ち上げるメソッド
    func createImagePicker(sourceType: UIImagePickerController.SourceType){
        //Cropping開始
        nowCropping = true
//        if UIImagePickerController.isSourceTypeAvailable(.camera){ //.cameraや.albumを指定
            let picker = UIImagePickerController()
            picker.sourceType = sourceType //カメラなのか、アルバムなのか、何を立ち上げるかを引数から指定
            picker.delegate = self //デリゲートメソッドを設定
//            picker.allowsEditing = false //編集を許す
            self.present(picker, animated: true, completion: nil) //立ち上げ
//        }
    }
    
    
    //機能が終わった場合に、データを処理し、終了するメソッド
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        guard let pickerImage = (info[UIImagePickerController.InfoKey.originalImage] as? UIImage) else { return }
        //CropViewControllerを初期化する。pickerImageを指定する。
        let cropController = CropViewController(croppingStyle: .default, image: pickerImage)
        
        //デリゲートメソッドを設定
        cropController.delegate = self
        
        //AspectRatioのサイズをcardViewのサイズに合わせる。
        cropController.customAspectRatio = cardView.frame.size
        
        //今回は使わない、余計なボタン等を非表示にする。
        cropController.aspectRatioPickerButtonHidden = true
        cropController.resetAspectRatioEnabled = false
        cropController.rotateButtonsHidden = true
        
        //cropBoxのサイズを固定する。
        cropController.cropView.cropBoxResizeEnabled = false
        
        //pickerを閉じたら、cropControllerを表示する。
        picker.dismiss(animated: true) {
            
            self.present(cropController, animated: true, completion: nil)
        }

//        //選択された画像を取得
//        if let pickerImage = info[.editedImage] as? UIImage{
//
//            currentImage = pickerImage
//            cardView.image = currentImage //imageViewに画像を設定
//
//            picker.dismiss(animated: true, completion: nil) //カメラまたはアルバムを閉じる
//        }
    }
    
    
    func cropViewController(_ cropViewController: CropViewController, didCropToImage image: UIImage, withRect cropRect: CGRect, angle: Int) {
        //トリミング編集が終えたら、呼び出される。
        updateImageViewWithImage(image, fromCropViewController: cropViewController)
    }
    
    
    func updateImageViewWithImage(_ image: UIImage, fromCropViewController cropViewController: CropViewController) {
        //トリミングした画像をimageViewのimageに代入する。
        
        self.cardView.image = image
        self.currentImage = image
        nowCropping = false //cropping終了
        cropViewController.dismiss(animated: true, completion: nil)
    }
    
    
//    //機能がキャンセルされたとき、それらを閉じるメソッド
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        picker.dismiss(animated: true, completion: nil)
//    }
    
    
    //機能：Enterキーが押されたときにキーボードを閉じる
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        currentText = textField.text!
        textField.resignFirstResponder()
        
        return true
    }
    
    //機能：どこかタッチしたときにキーボードを閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        currentText = textField.text!
        textField.resignFirstResponder()
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
    
    
//    //画像ファイル名を受け取って、documentDirectory内のそのファイルのURLを返す関数
//    func getFileURL(fileName: String) -> URL {
//        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        return docDir.appendingPathComponent(fileName)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
