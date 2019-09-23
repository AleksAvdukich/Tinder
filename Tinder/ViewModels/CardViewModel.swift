//
//  CardViewModel.swift
//  Tinder
//
//  Created by Aleksandr Avdukich on 29/05/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

//View Model должна представлять состояние нашего представления
class CardViewModel {
    let imageUrls: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
    
    init(imageNames: [String], attributedString: NSAttributedString, textAlignment: NSTextAlignment) {
        self.imageUrls = imageNames
        self.attributedString = attributedString
        self.textAlignment = textAlignment
    }
    
    fileprivate var imageIndex = 0 {
        didSet {
            let imageUrl = imageUrls[imageIndex]
//            let image = UIImage(named: imageName)
            imageIndexObserver?(imageIndex, imageUrl)
        }
    }
    
    //Reactive Programming
    var imageIndexObserver: ((Int, String?) -> ())?
    
    //переход к след. фотографии
    func advanceToNextPhoto() {
        imageIndex = min(imageIndex + 1, imageUrls.count - 1)
    }
    
    //переход к предыдущей фотографии
    func goToPreviousPhoto() {
        imageIndex = max(0, imageIndex - 1)
    }
}



