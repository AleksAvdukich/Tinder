//
//  CardView.swift
//  Tinder
//
//  Created by Aleksandr Avdukich on 16/03/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit
import SDWebImage

class CardView: UIView {
    
    var cardViewModel: CardViewModel! {
        didSet {
            //доступ к индексу 0 выдаст ошибку если imageNames.count == 0
            let imageName = cardViewModel.imageNames.first ?? ""
            //imageView.image = UIImage(named: imageName)
            //загрузка нашего изображения используя url
            if let url = URL(string: imageName) {
                imageView.sd_setImage(with: url)
            }
            
            
            informationLabel.attributedText = cardViewModel.attributedString
            informationLabel.textAlignment = cardViewModel.textAlignment
            
            (0..<cardViewModel.imageNames.count).forEach { (_) in
                let barView = UIView()
                barView.backgroundColor = barDeselectedColor
                barsStackView.addArrangedSubview(barView)
            }
            barsStackView.arrangedSubviews.first?.backgroundColor = .white
            
            setupImageIndexObserver()
        }
    }
    
    fileprivate func setupImageIndexObserver() {
        cardViewModel.imageIndexObserver = { [weak self] (idx, image) in
            print("changing photo from view model")
            self?.imageView.image = image
            
            self?.barsStackView.arrangedSubviews.forEach({ (v) in
                v.backgroundColor = self?.barDeselectedColor
            })
            self?.barsStackView.arrangedSubviews[idx].backgroundColor = .white
        }
    }
    
    //инкапсуляция
    fileprivate let imageView = UIImageView(image: #imageLiteral(resourceName: "lady5c"))
    fileprivate let gradientLayer = CAGradientLayer()
    fileprivate let informationLabel = UILabel()
    
    
    //Configurations
    fileprivate let threshold: CGFloat = 80
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        addGestureRecognizer(panGesture)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
    }
    
    fileprivate let barDeselectedColor = UIColor(white: 0, alpha: 0.1)
    
    @objc fileprivate func handleTap(gesture: UITapGestureRecognizer) {
        print("Handling tap and cycling photos")
        let tapLocation = gesture.location(in: nil)
        let shouldAdvanceNextPhoto = tapLocation.x > frame.width / 2 ? true : false
        if shouldAdvanceNextPhoto {
            cardViewModel.advanceToNextPhoto()
        } else {
            cardViewModel.goToPreviousPhoto()
        }
    }
    
    fileprivate func setupLayout() {
        layer.cornerRadius = 10
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        addSubview(imageView)
        imageView.fillSuperview()
        
        setupBarsStackView()
        
        //добавляет слой градиента
        setupGradientLayer()
        
        addSubview(informationLabel)
        informationLabel.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 16, right: 16))
        
        informationLabel.textColor = .white
        informationLabel.numberOfLines = 0
    }
    
    fileprivate let barsStackView = UIStackView()
    
    fileprivate func setupBarsStackView() {
        addSubview(barsStackView)
        barsStackView.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 8, left: 8, bottom: 0, right: 8), size: .init(width: 0, height: 4))
        
        barsStackView.spacing = 4
        barsStackView.distribution = .fillEqually    }
    
    fileprivate func setupGradientLayer() {
        //рисуем градиент
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.5, 1.1]
        
        layer.addSublayer(gradientLayer)
    }
    
    override func layoutSubviews() {
        //здесь мы узнаем какая рамка у нашего CardView будет
        //self.frame это zero frame
        gradientLayer.frame = self.frame
    }
    
    @objc fileprivate func handlePan(gesture: UIPanGestureRecognizer) {
        switch gesture.state { //текущее состояние распознавателя жестов
        case .began:
            superview?.subviews.forEach({ (subview) in
                subview.layer.removeAllAnimations()
            })
        case .changed:
            handleChanged(gesture)
        case .ended:
            handleEnded(gesture: gesture)
        default:
            ()
        }
    }
    
    fileprivate func handleChanged(_ gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: nil)
        //rotation
        let degrees: CGFloat = translation.x / 20
        let angle = degrees * .pi / 180
        
        let rotationalTransformation = CGAffineTransform(rotationAngle: angle)
        self.transform = rotationalTransformation.translatedBy(x: translation.x, y: translation.y)
    }
    
    fileprivate func handleEnded(gesture: UIPanGestureRecognizer) {
        let translationDirection: CGFloat = gesture.translation(in: nil).x > 0 ? 1 : -1
        let shouldDismissCard = abs(gesture.translation(in: nil).x) > threshold
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.1, options: .curveEaseOut, animations: {
            if shouldDismissCard {
                self.frame = CGRect(x: 600 * translationDirection, y: 0, width: self.frame.width, height: self.frame.height)
            } else {
                self.transform = .identity
            }
            
        }) { (_) in
            self.transform = .identity
            if shouldDismissCard {
                self.removeFromSuperview()//удаляет карточку
            }
            //      self.frame = CGRect(x: 0, y: 0, width: self.superview!.frame.width, height: self.superview!.frame.height)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
