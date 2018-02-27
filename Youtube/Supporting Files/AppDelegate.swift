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
        UINavigationBar.appearance().barTintColor = AppConstant.APP_THEME_COLOR
        // remove the line at the bottom of the navigation bar
        UINavigationBar.appearance().shadowImage = UIImage()
        
        // change the status bar's backgroundview
        let statusBackgroundView = UIView(frame: CGRect(x: 0, y: 0, width: window!.frame.width, height: 20))
        statusBackgroundView.backgroundColor = AppConstant.STATUS_BAR_BACKGROUND_COLOR
        window!.addSubview(statusBackgroundView)
        
        // change the status bar's content mode to light
        application.statusBarStyle = .lightContent
        
        return true
    }



}

