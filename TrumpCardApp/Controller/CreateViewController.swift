//
//  CreateViewController.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2022/02/19.
//

import UIKit
import CropViewController

protocol CatchProtocol{
    func catchData(cardsList: CardsList)
}


class CreateViewController: UIViewController, UIImagePickerControllerDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate, UINavigationControllerDelegate, CropViewControllerDelegate {
    
    
    @IBOutlet weak var textField: UITextField! //textField
    @IBOutlet weak var cardView: UIImageView! //imageView
    @IBOutlet weak var settingOK: UIButton!
    
    var delegate: CatchProtocol? //前の画面に値を渡すためのプロトコル
    var cardsList = CardsList() //全カード情報となるcardsListをインスタンス化
    var currentImage: UIImage! //新たに追加しようとしているUIImage
    var currentText: String = "" //新たに追加しようとしているテキスト
    
    //カメラ、アルバムを使えるようにするCheckPermissionモデルをインスタンス化
    var checkPermission = CheckPermission()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //レイアウト設定
        cardView.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        settingOK.translatesAutoresizingMaskIntoConstraints = false
        
        let cardViewHeight = cardView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.6)
        let cardViewWidth = cardView.widthAnchor.constraint(equalTo: cardView.heightAnchor, multiplier: 1/1.618)
        let cardViewX = cardView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        let cardViewY = cardView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: self.view.frame.height * 0.05)
        
        let textFieldTop = textField.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 30)
        let textFieldLeading = textField.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 0)
        let textFieldTrailing = textField.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: 0)
        
        let settingOKX = settingOK.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0)
        let settingOKY = settingOK.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: -30)
        
        NSLayoutConstraint.activate([cardViewHeight,
                                     cardViewWidth,
                                     cardViewX,
                                     cardViewY,
                                     textFieldTop,
                                     textFieldLeading,
                                     textFieldTrailing,
                                     settingOKX,
                                     settingOKY
                                    ])
        
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
    
    //ボタン：設定完了
    @IBAction func settingOK(_ sender: Any) {
        
        //もし画像が選択されていれば、
        if currentImage != nil {
            
            //新しく作成するカードに番号をつけるために、すでにあるカード枚数を取得
            let customizeCardNumber = cardsList.customizeList.count + 1
            //新しくカードを作成
            let customizeCard = CardsModel(cardImage: currentImage,
                                           cardMark: "customize",
                                           cardNumber: customizeCardNumber,
                                           textLabelText: currentText)
            //カードリストに新しく作成したカードを追加
            cardsList.customizeList.append(customizeCard)
            
            //documentDirectoryにcurrentImageを保存
            guard let imageData = currentImage.jpegData(compressionQuality: 1.0) else {
                return
            }

            do {
                try imageData.write(to: getFileURL(fileName: "customize_\(customizeCardNumber).jpg"))
                print("Image saved.")
            } catch {
                print("Failed to save the image:", error)
            }
            
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
            
            showAlert(alertTitle: "Create card!!", alertMessage: "カード作っちゃお!!")
        
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
        if UIImagePickerController.isSourceTypeAvailable(.camera){ //.cameraや.albumを指定
            let picker = UIImagePickerController()
            picker.sourceType = sourceType //カメラなのか、アルバムなのか、何を立ち上げるかを引数から指定
            picker.delegate = self //デリゲートメソッドを設定
//            picker.allowsEditing = false //編集を許す
            self.present(picker, animated: true, completion: nil) //立ち上げ
        }
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
        textField.resignFirstResponder()
    }
    
    
    //画像ファイル名を受け取って、documentDirectory内のそのファイルのURLを返す関数
    func getFileURL(fileName: String) -> URL {
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDir.appendingPathComponent(fileName)
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
