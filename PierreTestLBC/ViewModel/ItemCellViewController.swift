//
//  TableViewController.swift
//  PierreTestLBC
//
//  Created by Pierre Corsenac on 13/03/2022.
//

import Foundation
import UIKit

class ItemCellViewController : UITableViewCell {
    
    static let identifier = "ItemTableViewCell"
    
    override func updateConfiguration(using state: UICellConfigurationState) {
        super.updateConfiguration(using: state)
        
        var contentConfig = defaultContentConfiguration().updated(for: state)
        var backgroundConfig = backgroundConfiguration?.updated(for: state)
        
        contentConfig.text = "Hello World"
        
        if state.isHighlighted || state.isSelected {
            backgroundConfig?.backgroundColor = .green
            contentConfig.textProperties.color = .red
        }
        
        contentConfiguration = contentConfig
        backgroundConfiguration = backgroundConfig
    }
}
