//
//  TopNavigationStackView.swift
//  Tinder
//
//  Created by Aleksandr Avdukich on 16/03/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit

class TopNavigationStackView: UIStackView {

  let settingsButton = UIButton(type: .system)
  let messageButton = UIButton(type: .system)
  let fireImageView = UIImageView(image: UIImage(named: "fire_icon"))
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    heightAnchor.constraint(equalToConstant: 80).isActive = true
    
    fireImageView.contentMode = .scaleAspectFit
    
    settingsButton.setImage(UIImage(named: "human_icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
    messageButton.setImage(UIImage(named: "message_icon")?.withRenderingMode(.alwaysOriginal), for: .normal)
    
    [settingsButton, UIView(), fireImageView, UIView(), messageButton].forEach { (v) in
      addArrangedSubview(v)
    }
    
    distribution = .equalCentering
    
    isLayoutMarginsRelativeArrangement = true
    layoutMargins = .init(top: 0, left: 16, bottom: 0, right: 16)
  }
  
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
