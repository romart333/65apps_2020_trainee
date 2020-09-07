//
//  ViewController.swift
//  CollectionView
//
//  Created by Роман Копылов on 28.08.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    
    let cellIdentifier = "CollectionViewCell"
    
    private var items: [Model] = {
        let m1 = Model(firstText: "1", secondText: "1", image: UIImage(named: "1")!)
        let m2 = Model(firstText: "2", secondText: "2", image: UIImage(named: "2")!)
        let m3 = Model(firstText: "3", secondText: "3", image: UIImage(named: "3")!)
        return [m1,m2,m3,m1]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(UINib(nibName: "CollectionViewCell", bundle: nil), forCellWithReuseIdentifier: CollectionViewCell.cellIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension ViewController: UICollectionViewDelegate {
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? CollectionViewCell {
            cell.configureCellWith(model: items[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}

extension ViewController: UICollectionViewDataSource {
    
     func numberOfSections(in collectionView: UICollectionView) -> Int {
         return 2
     }
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         items.count
     }
     
}



