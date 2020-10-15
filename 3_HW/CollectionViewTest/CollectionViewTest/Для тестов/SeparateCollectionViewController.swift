//
//  CollectionViewController.swift
//  CollectionViewTest
//
//  Created by Роман Копылов on 15.09.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import UIKit

class SeparateCollectionViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var items: [ItemModel] = {
        var mainText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc a sagittis metus, vitae tempor odio. Donec dolor urna, maximus nec tincidunt eu, tempus et sapien. Praesent et hendrerit dui, nec gravida eros. Nam consectetur ex vel feugiat cursus. Aenean sed nunc eu augue consequat fringilla. Ut g!!"
        var items = [ItemModel]()
        let item1 = ItemModel(title: "1", text: mainText, image: UIImage(named: "1") ?? UIImage())
              items.append(item1)
        let item = ItemModel(title: "1", text: "asd", image: UIImage(named: "1") ?? UIImage())
        items.append(item)
        for i in 1...10 {
            let imageNum = i % 3 + 1
            let image = UIImage(named: String(imageNum)) ?? UIImage()
            items.append(ItemModel(title: "Title\(i)", text: mainText, image: image))
            mainText = "\(mainText)"
        }
        
        return items
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
        collectionView.register(UINib(nibName: String(describing: CustomCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: CustomCollectionViewCell.cellIdentifier)
        
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let w = collectionView.frame.width - 20
            flow.estimatedItemSize = CGSize(width: w, height: 300)
        }
    }
    
    override func viewDidLayoutSubviews() {
        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            let w = collectionView.frame.width - 20
            flow.estimatedItemSize = CGSize(width: w, height: 300)
        }
    }
}

extension SeparateCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier, for: indexPath)
        supplementaryView.backgroundColor = .gray
        return supplementaryView
    }
}

extension SeparateCollectionViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.cellIdentifier, for: indexPath) as? CustomCollectionViewCell else { return CustomCollectionViewCell() }
//        cell.configureCellWith(item: items[indexPath.row])
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCell.cellIdentifier, for: indexPath) as? CVCell else { return CVCell() }
        cell.configureCellWith(item: items[indexPath.row])
        return cell
    }
}

extension SeparateCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
