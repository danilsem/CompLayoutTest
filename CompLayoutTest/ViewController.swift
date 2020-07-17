//
//  ViewController.swift
//  CompLayoutTest
//
//  Created by Admin on 03.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Int>
    @IBOutlet weak var collectionView: UICollectionView!
    
    //var collectionView: UICollectionView! = nil
    
    var dataSource: DataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.collectionView = .init(frame: view.bounds, collectionViewLayout: createLayout())
        
        self.collectionView.collectionViewLayout = createLayout()
        //self.collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //self.collectionView.backgroundColor = .systemBackground
        let bigCell = UINib(nibName: "BigMovieCell", bundle: nil)
        
        self.collectionView.register(bigCell, forCellWithReuseIdentifier: "bigCell")
        self.collectionView.register(HeaderView.self, forSupplementaryViewOfKind: "HeaderViewKind", withReuseIdentifier: HeaderView.identifier)
        self.collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: "categoryCell")
        
        self.view.addSubview(collectionView)
        
        createDataSource()
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            if sectionIndex == 0 {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(200), heightDimension: .absolute(300)), subitems: [item])
                group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
                            
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44.0)), elementKind: "HeaderViewKind", alignment: .topLeading)
                headerItem.pinToVisibleBounds = true
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [headerItem]
                section.contentInsets = .init(top: 10, leading: 20, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                
                return section
            }
            else {
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 10
                item.contentInsets.bottom = 10
                
                let verticalGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)), subitem: item, count: 3)
                
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .absolute(200), heightDimension: .fractionalHeight(0.3)), subitems: [verticalGroup])
                group.contentInsets = .init(top: 0, leading: 0, bottom: 0, trailing: 10)
                            
                let headerItem = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .estimated(44.0)), elementKind: "HeaderViewKind", alignment: .topLeading)
                headerItem.pinToVisibleBounds = true
                
                let section = NSCollectionLayoutSection(group: group)
                section.boundarySupplementaryItems = [headerItem]
                section.contentInsets = .init(top: 10, leading: 20, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
                
                return section
            }
            
            
        }
        return layout
    }
    
    func createDataSource() {
        dataSource = .init(collectionView: self.collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            if indexPath.section == 0 {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bigCell", for: indexPath) as? BigMovieCell else { fatalError("Can't dequeue cell with identifier bigCell") }
                
                return cell
            }
            else {
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as? CategoryCell else { fatalError("Can't dequeue cell with identifier categoryCell") }
                
                return cell
            }
            
            
        }
        
        dataSource.supplementaryViewProvider = { (collectionView: UICollectionView, kind: String, indexPath: IndexPath) -> UICollectionReusableView? in
            
            if kind == "HeaderViewKind" {
                if let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderView.identifier, for: indexPath) as? HeaderView {
                    
                    if indexPath.section == 0 {
                        headerView.nameLabel.text = "Популярно"
                    }
                    else {
                        headerView.nameLabel.text = "Категории"
                    }
                    
                    return headerView
                }
            }
            
            return nil
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main, .categories])
        snapshot.appendItems(Array(0...10), toSection: .main)
        snapshot.appendItems(Array(11...20), toSection: .categories)
        dataSource.apply(snapshot)
    }
}

enum Section: Int, CaseIterable {
    case main
    case categories
}
