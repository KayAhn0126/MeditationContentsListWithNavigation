//
//  MeditationCollectionViewCell.swift
//  MeditationContentsList
//
//  Created by Kay on 2022/08/28.
//

import UIKit

class MeditationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.backgroundColor = UIColor.systemIndigo
        contentView.layer.cornerRadius = 10
    }
    
    func configure(_ meditation: Meditation) {
        titleLabel.text = meditation.title
        descriptionLabel.text = meditation.description
        weatherImageView.image = UIImage(systemName: meditation.imageName)?.withRenderingMode(.alwaysOriginal)
    }
}
