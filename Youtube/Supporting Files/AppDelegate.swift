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
        
        // change the appearance of the overall navigation bar
        UINavigationBar.appearance().barTintColor = UIColor.rgb(red: 230, green: 32, blue: 31)
        
        // change the status bar's backgroundview
        let statusBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: window!.frame.width, height: 20))
        statusBackgroundView.backgroundColor = UIColor.rgb(red: 194, green: 31, blue: 31)
        window!.addSubview(statusBackgroundView)
        
        // change the status bar's content mode to light
        application.statusBarStyle = .lightContent
        
        return true
    }



}

