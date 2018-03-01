//
//  Settings.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/3/1.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

class Settings: NSObject {
    
    let mainWindow = (UIApplication.shared.delegate?.window)!!
    let settingsCellId = "settingsCellId"
    let settingsCellCount: CGFloat = 6
    let settingsCellHeight: CGFloat = 50
    
    lazy var settingsData: [Setting] = {
        let data = [
            Setting(name: "Settings", imageName: "settings"),
            Setting(name: "Switch Account", imageName: "switch_account"),
            Setting(name: "Send Feedback", imageName: "feedback"),
            Setting(name: "Terms & Privacy Policy", imageName: "privacy"),
            Setting(name: "Help", imageName: "help"),
            Setting(name: "Cancel", imageName: "cancel")
        ]
        return data
    }()
    
    lazy var bg: UIView = {
        // a half-black back ground
        let bg = UIView()
        bg.backgroundColor = UIColor(white: 0, alpha: 0.5)
        bg.alpha = 0
        bg.frame = mainWindow.frame
        bg.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissSettingsForTitle)))
        
        return bg
        
    }()
    
    lazy var settingsMenu: UICollectionView = {
        let settingsRect = CGRect(x: 0, y: mainWindow.frame.height, width: mainWindow.frame.width, height: settingsCellHeight * settingsCellCount)
        let settingsView = UICollectionView(frame: settingsRect, collectionViewLayout: UICollectionViewFlowLayout())
        settingsView.backgroundColor = .white
        settingsView.register(SettingsCell.self, forCellWithReuseIdentifier: settingsCellId)
        settingsView.delegate = self
        settingsView.dataSource = self
        return settingsView
    }()
    
    func showSettings() {
        // add bg to system window
        
        mainWindow.addSubview(bg)
        // add settings to system window
        mainWindow.addSubview(settingsMenu)
        // animate the bg view to screen
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            self.bg.alpha = 1
            self.settingsMenu.frame = CGRect(x: 0, y: self.mainWindow.frame.height - self.settingsCellHeight * self.settingsCellCount, width: self.mainWindow.frame.width, height: self.settingsCellHeight * self.settingsCellCount)
        }, completion: nil)
        // animate settingsView into screen
        
    }
    
    @objc func dismissSettingsForTitle(name: AnyObject) {
        // dismiss the bg view
        UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
            // when a view's alpha is 0, it can't receive touch events
            self.bg.alpha = 0
            
            self.settingsMenu.frame = CGRect(x: 0, y: self.mainWindow.frame.height, width: self.mainWindow.frame.width, height: self.settingsCellHeight * self.settingsCellCount)
        }, completion: { _ in
            let cellTitleName = name as? String
            // if the bg view is clicked to dismiss the settings view, then the cell title name will be nil, otherwise it will be a string
            if cellTitleName != nil && cellTitleName! != "Cancel" {
                // present controller
                let vc = UIViewController()
                vc.view.backgroundColor = .white
                vc.title = name as? String
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                let rootVC = appDelegate.window?.rootViewController as! UINavigationController
                // navigationBar.barTintColor: specify the bar's color
                // navigationBar.tintColor: specify the items's color inside the bar
                rootVC.navigationBar.tintColor = .white
                // set the navigation bar's title foreground color to white
                rootVC.navigationBar.titleTextAttributes = [
                    NSAttributedStringKey.foregroundColor:UIColor.white
                ]
                rootVC.pushViewController(vc, animated: true)
            }
        })
    }
    
}

extension Settings: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(settingsCellCount)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: settingsCellId, for: indexPath) as! SettingsCell
        cell.settingData = settingsData[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: mainWindow.frame.width, height: settingsCellHeight)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! SettingsCell
        if let cellTitleStr = cell.settingsTitle.text {
            dismissSettingsForTitle(name: cellTitleStr as AnyObject)
        }
        
    }

}
