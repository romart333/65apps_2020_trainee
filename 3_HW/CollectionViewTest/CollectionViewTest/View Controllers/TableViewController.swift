//
//  TableViewController.swift
//  CollectionViewTest
//
//  Created by Роман Капылов on 18/09/2020.
//  Copyright © 2020 Роман Копылов. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UIViewController {
    
    private var items: [ItemModel] = {
        var mainText = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc a sagittis metus, vitae tempor odio. Donec dolor urna, maximus nec tincidunt eu, tempus et sapien. Praesent et hendrerit dui, nec gravida eros. Nam consectetur ex vel feugiat cursus. Aenean sed nunc eu augue consequat fringilla. Ut gravida neque vitae turpis congue rutrum. Aliquam facilisis tristique erat, id varius magna dapibus eget. Maecenas blandit pellentesque nunc, id mollis massa auctor in. Fusce vestibulum metus sit amet sollicitudin luctus. Donec imperdiet accumsan felis non scelerisque. Donec eleifend nisi non enim ultrices, non lacinia erat sagittis. Praesent sit amet ligula sapien. Donec eget ullamcorper dui. Fusce viverra urna nec volutpat rutrum. FINISH!!"
        var items = [ItemModel]()
        var image = UIImage(named: String("1")) ?? UIImage()
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
    }
}

extension TableViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ItemStorage.shared.sectionsCount
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ItemStorage.shared.getItemsBy(section: section)?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.cellIdentifier, for: indexPath) as? TableViewCell,
            let item = ItemStorage.shared.getItemsBy(section: indexPath.section)?[indexPath.row] else { return TableViewCell() }
        cell.configureCellWith(item: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            ItemStorage.shared.removeItemAt(section: indexPath.section, withItemIndex: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
}

extension TableViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        20
    }
}
