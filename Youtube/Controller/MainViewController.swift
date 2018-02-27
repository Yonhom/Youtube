//
//  MainViewController.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/2/17.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    let menuTabBar: MenuBar = {
        let menuBar = MenuBar()
        return menuBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        setupCollectionView()
        
        setupMenuBar()
    }
    
    func setupMenuBar() {
        view.addSubview(menuTabBar)
        menuTabBar.translatesAutoresizingMaskIntoConstraints = false
        menuTabBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuTabBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuTabBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        menuTabBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    func setupCollectionView() {
        collectionView?.register(MainCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.backgroundColor = .white
        
        // set layout insets for both collectionView and scroll indicator
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    func setupNavigationBar() {
        // make the navigation bar not half-tansparent
        navigationController?.navigationBar.isTranslucent = false
        
        // make main title of the navigation bar align to the left and white
        let mainTitle = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: navigationController!.navigationBar.frame.height))
        mainTitle.text = "Main"
        mainTitle.textColor = .white
        mainTitle.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        navigationItem.titleView = mainTitle
        
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

// MARK: - item size and spacing delegate
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 240)
    }

}











