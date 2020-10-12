//
//  LanguageTableViewContoller.swift
//  First
//
//  Created by Роман Капылов on 16/08/2020.
//  Copyright © 2020 Роман Капылов. All rights reserved.
//

import UIKit

class LanguageTableViewContoller: UIViewController {
    
    private let cellIdentifier = "language cell"
    
    @IBOutlet weak var languageTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateLocalization()
    }
    
    func updateLocalization() {
        title = "Language".localizedString(comment: "Language VC title")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension LanguageTableViewContoller: UITableViewDelegate {
    
}

extension LanguageTableViewContoller: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        LocalizationManager.shared.getAllLocalizations().count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        let rowIndex = indexPath.row
        let localizations = LocalizationManager.shared.getAllLocalizations()
        let localizationCode = LocalizationManager.shared.getCurrentLocalization()
        
        if ((0...localizations.count - 1).contains(rowIndex)) {
            if localizationCode.rawValue == localizations[rowIndex].rawValue {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
            
            switch localizations[rowIndex] {
            case .english:
                cell.textLabel?.text = "English".localizedString(comment: "English language")
            case .russian:
                cell.textLabel?.text = "Russian".localizedString(comment: "Russian language")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
               
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
//        let rowIndexPath = indexPath.row
//
//        let localizations = LocalizationManager.shared.getAllLocalizations()
//        var language: Language
//
//        tableView.deselectRow(at: indexPath, animated: true)
//        if ((0...rowIndexPath).contains(rowIndexPath)) {
//            language = localizations[indexPath.row]
//            LocalizationManager.shared.setLocalization(language: language)
//
//            return
//        }
//
//        print("Incorrect language index \(rowIndexPath)")
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let rowIndexPath = indexPath.row
        let localizations = LocalizationManager.shared.getAllLocalizations()
        if let cell = tableView.cellForRow(at: indexPath), (0...localizations.count - 1).contains(rowIndexPath) {
            tableView.visibleCells.forEach { (cell) in
                cell.accessoryType = .none
            }
            LocalizationManager.shared.setCurrentLocalization(language: localizations[rowIndexPath])
            cell.accessoryType = .checkmark
            return
        }
    }
}
