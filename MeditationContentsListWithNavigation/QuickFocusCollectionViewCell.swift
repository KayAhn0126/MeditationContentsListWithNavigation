//
//  QuickFocusCollectionViewCell.swift
//  MeditationContentsListWithNavigation
//
//  Created by Kay on 2022/09/03.
//

import UIKit

class QuickFocusCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(_ data: QuickFocus) {
        thumbnailImageView.image = UIImage(named: data.imageName)
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
}
