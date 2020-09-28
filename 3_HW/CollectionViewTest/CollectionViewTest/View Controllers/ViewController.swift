//
//  ViewController.swift
//  CollectionViewTest
//
//  Created by Роман Копылов on 15.09.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    private var items: [ItemModel] = {
        var mainText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc a sagittis metus, vitae tempor odio. Donec dolor urna, maximus nec tincidunt eu, tempus et sapien. Praesent et hendrerit dui, nec gravida eros. Nam consectetur ex vel feugiat cursus. Aenean sed nunc eu augue consequat fringilla. Ut gravida neque vitae turpis congue rutrum. Aliquam facilisis tristique erat, id varius magna dapibus eget. Maecenas blandit pellentesque nunc, id mollis massa auctor in. Fusce vestibulum metus sit amet sollicitudin luctus. Donec imperdiet accumsan felis non scelerisque. Donec eleifend nisi non enim ultrices, non lacinia erat sagittis. Praesent sit amet ligula sapien. Donec eget ullamcorper dui. Fusce viverra urna nec volutpat rutrum. FINISH!!"
        var items = [ItemModel]()
        var image = UIImage(named: String("1")) ?? UIImage()
//        items.append(Model(title: "little text", text: "little text", image: image))
         image = UIImage(named: String("1")) ?? UIImage()
                      items.append(ItemModel(title: "little text", text: "little text", image: image))
        for i in 1...3 {
            let image = UIImage(named: String(i)) ?? UIImage()
            items.append(ItemModel(title: "Title\(i+1)", text: mainText, image: image))
            mainText += "\n\(mainText)"
        }
        
        return items
    }()
    
    private var items2: [ItemModel] = {
        var mainText = "section2"
        var items = [ItemModel]()
        for i in 1...3 {
            let image = UIImage(named: String(i)) ?? UIImage()
            items.append(ItemModel(title: "Title\(i)", text: mainText, image: image))
            
            mainText += "\n\(mainText)"
        }
        
        return items
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        ItemStorage.shared.setItemsFor(section: 0, withItems: items)
        ItemStorage.shared.setItemsFor(section: 1, withItems: items2)
        // Do any additional setup after loading the view.
    //        collectionView.register(UINib(nibName: String(describing: CustomCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: CustomCollectionViewCell.cellIdentifier)
        
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
    }
    
    override func viewWillLayoutSubviews() {
        
        if !self.view.needsUpdateConstraints() {
            return
        }
        
        if let flow = collectionViewLayout as? UICollectionViewFlowLayout,
        let cv = collectionView {
            let w = cv.frame.width - 20
            flow.estimatedItemSize = CGSize(width: w, height: 1000)
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier, for: indexPath)
        print("supplementaryView frame:\(supplementaryView.frame)")
        supplementaryView.backgroundColor = .gray
        return supplementaryView
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return ItemStorage.shared.sectionsCount
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ItemStorage.shared.getItemsBy(section: section)?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCell.cellIdentifier, for: indexPath) as? CVCell,
            let item = ItemStorage.shared.getItemsBy(section: indexPath.section)?[indexPath.item] else { return UICollectionViewCell() }
        cell.configureCellWith(item: item)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        
        ItemStorage.shared.removeItemAt(section: indexPath.section, withItemIndex: indexPath.item)
        collectionView.deleteItems(at: [indexPath])
        print(indexPath)
    }
}

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: 0, height: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
