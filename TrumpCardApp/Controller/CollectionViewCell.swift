//
//  CollectionViewCell.swift
//  TrumpCardApp
//
//  Created by Misawa Kazushi on 2022/02/02.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
//        backgroundColor = .systemGray
        

        
        //レイアウト設定
        cellImageView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.translatesAutoresizingMaskIntoConstraints = false

        
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: trailingAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            cellImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            cellImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            cellImageView.heightAnchor.constraint(equalTo: cellImageView.widthAnchor, multiplier: 1.618),
//            cellImageView.heightAnchor.constraint(equalToConstant: cellImageView.frame.width * 2),
            cellLabel.topAnchor.constraint(equalTo: cellImageView.bottomAnchor, constant: 5),
            cellLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            cellLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            cellLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10)
        ])
        
        //文字サイズを可変に
        cellLabel.textAlignment = NSTextAlignment.center
        cellLabel.numberOfLines = 0
        cellLabel.adjustsFontSizeToFitWidth = true

        
        marukadoWakusen(image: cellImageView)

    }
    
    //機能：画像の角丸&枠線
    func marukadoWakusen (image: UIImageView) {
        image.layer.borderColor = UIColor.systemGray.cgColor
        image.layer.borderWidth = 0.5
        image.layer.cornerRadius = image.frame.width / 20
        image.layer.masksToBounds = true
    }

}

