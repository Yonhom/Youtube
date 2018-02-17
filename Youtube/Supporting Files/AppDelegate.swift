//
//  AppDelegate.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/2/17.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        
        let collectionLayout = UICollectionViewFlowLayout()
        window?.rootViewController =
            UINavigationController(rootViewController:
                MainViewController(collectionViewLayout: collectionLayout))
        
        window?.makeKeyAndVisible()
        
        return true
    }



}

