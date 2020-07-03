//
//  CollectionViewCell.swift
//  CompLayoutTest
//
//  Created by Admin on 03.07.2020.
//  Copyright © 2020 Admin. All rights reserved.
//

import UIKit

class NestedGroupsViewController: UIViewController {
    
    enum Section {
        case main
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Int>! = nil
    var collectionView: UICollectionView! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Nested Groups"
        configureHierarchy()
        configureDataSource()
    }
    
    //   +---------------------------------------------------+
    //   | +-----------------------------------------------+ |
    //   | |                                               | |
    //   | |                                               | |
    //   | |                       0                       | |
    //   | |                                               | |
    //   | |                                               | |
    //   | +-----------------------------------------------+ |
    //   | +---------------------------------+ +-----------+ |
    //   | |                                 | |           | |
    //   | |                                 | |           | |
    //   | |                                 | |     2     | |
    //   | |                                 | |           | |
    //   | |                                 | |           | |
    //   | |                                 | +-----------+ |
    //   | |               1                 |               |
    //   | |                                 | +-----------+ |
    //   | |                                 | |           | |
    //   | |                                 | |           | |
    //   | |                                 | |     3     | |
    //   | |                                 | |           | |
    //   | |                                 | |           | |
    //   | +---------------------------------+ +-----------+ |
    //   +-----------------------------------------------------+
    
    func createLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout {
            (sectionIndex: Int, layoutEnvironment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            let leadingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.7),
                                                   heightDimension: .fractionalHeight(1.0)))
            leadingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let trailingItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.3)))
            trailingItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            let trailingGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
                                                   heightDimension: .fractionalHeight(1.0)),
                subitem: trailingItem, count: 2)
            
            let bottomNestedGroup = NSCollectionLayoutGroup.horizontal(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.6)),
                subitems: [leadingItem, trailingGroup])
            
            let topItem = NSCollectionLayoutItem(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.3)))
            topItem.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
            
            let nestedGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                   heightDimension: .fractionalHeight(0.4)),
                subitems: [topItem, bottomNestedGroup])
            let section = NSCollectionLayoutSection(group: nestedGroup)
            // section.orthogonalScrollingBehavior = .continuous
            return section
            
        }
        return layout
    }
    
    private func configureHierarchy() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.backgroundColor = .systemBackground
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "mainCell")
        view.addSubview(collectionView)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, identifier: Int) -> UICollectionViewCell? in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mainCell", for: indexPath) as? UICollectionViewCell else { fatalError("Cannot create the cell") }
            
            cell.backgroundColor = .blue
            
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(0..<100))
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
