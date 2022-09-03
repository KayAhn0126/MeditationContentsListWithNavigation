//
//  QuickFocusCollectionReusableView.swift
//  MeditationContentsListWithNavigation
//
//  Created by Kay on 2022/09/03.
//

import UIKit

class QuickFocusCollectionReusableView: UICollectionReusableView {
        
    @IBOutlet weak var titleLabel: UILabel!
    
    func configure(_ title: String) {
        titleLabel.text = title
    }
}
