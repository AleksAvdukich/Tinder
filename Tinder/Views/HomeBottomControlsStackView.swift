//
//  HomeBottomControlsStackView.swift
//  Tinder
//
//  Created by Aleksandr Avdukich on 15/03/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
    
    static func createButton(image: UIImage) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        button.imageView?.contentMode = .scaleAspectFill
        return button
    }
    
    let refreshButton = createButton(image: UIImage(named: "refresh_icon")!)
    let dislikeButton = createButton(image: UIImage(named: "dismiss_icon")!)
    let superLikeButton = createButton(image: UIImage(named: "superlike_icon")!)
    let likeButton = createButton(image: UIImage(named: "like_icon")!)
    let specialButton = createButton(image: UIImage(named: "boost_icon")!)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        distribution = .fillEqually
        heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        [refreshButton, dislikeButton, superLikeButton, likeButton, specialButton].forEach { (button) in
            self.addArrangedSubview(button)
        }
    }
    
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
