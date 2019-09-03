//
//  RegistrationViewModel.swift
//  Tinder
//
//  Created by Aleksandr Avdukich on 01/09/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    
//    var image: UIImage? {
//        didSet {
//            imageObserver?(image)
//        }
//    }
//
//    var imageObserver: ((UIImage?) -> ())?
    
    var fullName: String? {
        didSet {
            checkFormValidity()
        }
    }
    var email: String? { didSet { checkFormValidity() } }
    var password: String? { didSet { checkFormValidity() } }
    
    fileprivate func checkFormValidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
    var bindableIsFormValid = Bindable<Bool>()
    
    //Reactive Programming
//    var isFormValidObserver: ((Bool) -> ())?
    
}
