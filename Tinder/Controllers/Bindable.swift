//
//  Bindable.swift
//  Tinder
//
//  Created by Aleksandr Avdukich on 03/09/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?)->())?
    
    func bind(observer: @escaping (T?) ->()) {
        self.observer = observer
    }
    
}
