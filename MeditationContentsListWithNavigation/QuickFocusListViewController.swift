//
//  QuickFocusViewController.swift
//  MeditationContentsListWithNavigation
//
//  Created by Kay on 2022/09/03.
//

import UIKit



class QuickFocusListViewController: UIViewController {
    
    enum Section: CaseIterable {
        case breathing
        case walking
        
        var title: String {
            switch self {
            case .breathing:
                return "Breathing exercises"
            case .walking:
                return "Mindful walks"
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    let breathingList = QuickFocus.breathing
    let walkingList = QuickFocus.walking
    
    typealias Item = QuickFocus
    var dataSource: UICollectionViewDiffableDataSource<Section, Item>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Presentation
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView, cellProvider: { collectionView, indexPath, item in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "QuickFocusCollectionViewCell", for: indexPath) as? QuickFocusCollectionViewCell else { return nil }
            cell.configure(item)
            return cell
        })
        
        // Data
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([.breathing, .walking]) // snapshot.appendSections(Section.allCases)로도 사용 가능
        snapshot.appendItems(breathingList, toSection: .breathing)
        snapshot.appendItems(walkingList, toSection: .walking)
        dataSource.apply(snapshot)
        
        // Layout
        collectionView.collectionViewLayout = layout()
        
    }
    
    private func layout() -> UICollectionViewCompositionalLayout {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .estimated(50))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(50))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
        
        let section = NSCollectionLayoutSection(group: group)
        
        let layout = UICollectionViewCompositionalLayout(section: section)
        return layout
    }

    

}
