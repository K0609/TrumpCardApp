//
//  CreateCardViewController.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2021/11/19.
//

import UIKit

class CreateCardViewController: UIViewController, UIGestureRecognizerDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate  {

    
    var cardsList = CardsList()

    var checkPermission = CheckPermission()
    
    var currentImage: UIImage!
    var currentText: String = ""
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        textField.delegate = self
        
        
        let tapGesture1: UITapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(CreateCardViewController.tapAction(_:)))
        tapGesture1.delegate = self
        self.imageView.addGestureRecognizer(tapGesture1)
        
        checkPermission.showCheckPermission()
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
