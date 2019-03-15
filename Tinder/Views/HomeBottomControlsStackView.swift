//
//  HomeBottomControlsStackView.swift
//  Tinder
//
//  Created by Aleksandr Avdukich on 15/03/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit

class HomeBottomControlsStackView: UIStackView {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    distribution = .fillEqually
    heightAnchor.constraint(equalToConstant: 100).isActive = true
    
    let arrayOfIcons = [UIImage.init(named: "refresh_icon"),UIImage.init(named: "dismiss_icon"),UIImage.init(named: "superlike_icon"),UIImage.init(named: "like_icon"),UIImage.init(named: "boost_icon"),]
    
    let subviews = arrayOfIcons.map { (img) -> UIView in
      let button = UIButton(type: .system)
      button.setImage(img?.withRenderingMode(.alwaysOriginal), for: .normal)
      return button
    }
    
    subviews.forEach { (v) in
      addArrangedSubview(v)
    }
  }
  
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
