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
        self.view.addSubview(collectionView)
        
        createDataSource()
    }
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let leadingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7), heightDimension: .fractionalHeight(1.0)))

            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
            
            let trailingItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(0.5)))
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)

            let trailingGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(1.0)), subitem: trailingItem, count: 2)
            
            let nestedGroup = NSCollectionLayoutGroup.horizontal(layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(0.4)), subitems: [leadingItem, trailingGroup])
            nestedGroup.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 5)
            
            let section = NSCollectionLayoutSection(group: nestedGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 5.0, leading: 5.0, bottom: 5.0, trailing: 5.0)
            section.orthogonalScrollingBehavior = .paging
            
            return section
            
        }
        return layout
    }
    
    func createDataSource() {
        dataSource = .init(collectionView: self.collectionView) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "bigCell", for: indexPath) as? BigMovieCell else { fatalError("Can't dequeue cell with identifier bigCell") }
            
            cell.layer.shadowRadius = 30
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.3
            
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0...100))
        dataSource.apply(snapshot)
    }
}

enum Section {
    case main
}
