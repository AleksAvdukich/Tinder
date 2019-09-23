//
//  SwipingPhotosController.swift
//  Tinder
//
//  Created by Aleksandr Avdukich on 23/09/2019.
//  Copyright © 2019 Sanel Avdukich. All rights reserved.
//

import UIKit

class SwipingPhotosController: UIPageViewController, UIPageViewControllerDataSource {

    let controllers = [
        PhotoController(image: #imageLiteral(resourceName: "boost_icon")),
        PhotoController(image: #imageLiteral(resourceName: "refresh_icon")),
        PhotoController(image: #imageLiteral(resourceName: "like_icon")),
        PhotoController(image: #imageLiteral(resourceName: "superlike_icon")),
        PhotoController(image: #imageLiteral(resourceName: "dismiss_icon"))
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        view.backgroundColor = .white
        
        setViewControllers([controllers.first!], direction: .forward, animated: false)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == controllers.count - 1 { return nil }
        return controllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let index = self.controllers.firstIndex(where: {$0 == viewController}) ?? 0
        if index == 0 { return nil }
        return controllers[index - 1]
    }
    
    
}

class PhotoController: UIViewController {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "kelly1"))
    
    init(image: UIImage) {
        super.init(nibName: nil, bundle: nil)
        imageView.image = image
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        imageView.fillSuperview()
        imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
