//
//  SettingsCell.swift
//  Tinder
//
//  Created by Aleksandr Avdukich on 13/09/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {

    class SettingsTextField: UITextField {
        
        override func textRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 24, dy: 0)
        }
        
        override func editingRect(forBounds bounds: CGRect) -> CGRect {
            return bounds.insetBy(dx: 24, dy: 0)
        }
        
        override var intrinsicContentSize: CGSize { //внутренний размер контента
            return .init(width: 0, height: 44)
        }
    }
    
    let textField: UITextField = {
        let tf = SettingsTextField()
        tf.placeholder = "Enter Name"
        return tf
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(textField)
        textField.fillSuperview() 
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
}
