//
//  ViewController.swift
//  Kolb Test
//
//  Created by Davi Pereira Neto on 27/07/20.
//  Copyright © 2020 ExxonMobil Global Services Company. All rights reserved.
//

import UIKit

class HomeViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabs()
    }
    
    func configureTabs() {
        let photosViewController = PhotosViewController(photosObservable: DataModel.photos, title: "Photos")
        photosViewController.tabBarItem = UITabBarItem(title: "Fotos", image: UIImage(systemName: "photo.fill.on.rectangle.fill"), tag: 0)
        
        let photosNavigationController = UINavigationController(rootViewController: photosViewController)
        
        photosNavigationController.tabBarItem = UITabBarItem(title: "Fotos", image: UIImage(systemName: "photo.fill.on.rectangle.fill"), tag: 0)
        
        let albunsViewController = AlbunsViewController()
        
        let albunsNavigationController = UINavigationController(rootViewController: albunsViewController)
        
        albunsNavigationController.tabBarItem = UITabBarItem(title: "Álbuns", image: UIImage(systemName: "rectangle.stack.fill"), tag: 1)
        
        setViewControllers([photosNavigationController, albunsNavigationController], animated: false)
    }


}

