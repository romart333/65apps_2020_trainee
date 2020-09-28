//
//  CollectionViewController.swift
//  CollectionViewTest
//
//  Created by Роман Копылов on 15.09.2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import UIKit


//class CollectionViewController: UIViewController {
//   
//    @IBOutlet weak var collectionView: UICollectionView!
//    let items: [String] = {
//        
//         let loremIpsum = "At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere possimus, omnis voluptas assumenda est, omnis dolor repellendus. Temporibus autem quibusdam et aut officiis debitis aut rerum necessitatibus saepe eveniet ut et voluptates repudiandae sint et molestiae non recusandae. Itaque earum rerum hic tenetur a sapiente delectus, ut aut reiciendis voluptatibus maiores alias consequatur aut perferendis doloribus asperiores repellat. FINISH!!!"
//        
//        var array = [String]()
//        for i in 1..<10 {
//            array.append(loremIpsum)
//        }
//        return array
//    }()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier)
////        collectionView.register(UINib(nibName: String(describing: CustomCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: CustomCollectionViewCell.cellIdentifier)
//        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//                   let w = collectionView.frame.width - 20
//                   flow.estimatedItemSize = CGSize(width: w, height: 20)
//               }
//    }
//    
//    override func viewWillLayoutSubviews() {
//        if !self.view.needsUpdateConstraints() {
//            return
//        }
//        
//        if let flow = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
//            let w = collectionView.frame.width - 20
//            flow.estimatedItemSize = CGSize(width: w, height: 20)
//        }
//    }
//}
//
//extension CollectionViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//           let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.identifier, for: indexPath)
//           print("supplementaryView frame:\(supplementaryView.frame)")
//           supplementaryView.backgroundColor = .gray
//           return supplementaryView
//       }
//}
//
//extension CollectionViewController: UICollectionViewDataSource {
//    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return 1
//    }
//
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CVCell.cellIdentifier, for: indexPath) as? CVCell else { return UICollectionViewCell() }
//        cell.label3.text = items[indexPath.item]
//        return cell
//    }
//}
//
//extension CollectionViewController: UICollectionViewDelegateFlowLayout {
// 
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//        return CGSize(width: 0, height: 20)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 0
//    }
//}
