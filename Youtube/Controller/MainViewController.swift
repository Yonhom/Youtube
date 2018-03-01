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
    
    var videos: [Video]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationBar()
        
        setupCollectionView()
        
        setupMenuBar()
        
        fetchData()
    }
    
    func fetchData() {
        // https://s3-us-west-2.amazonaws.com/youtubeassets/home.json
        let urlStr = "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json"
        
        Video.videos(from: urlStr) { videos in
            self.videos = videos
            DispatchQueue.main.async(execute: {
                self.collectionView?.reloadData()
            })
        }
    }
    
    func setupMenuBar() {
        view.addSubview(menuTabBar)
        menuTabBar.translatesAutoresizingMaskIntoConstraints = false
        menuTabBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        menuTabBar.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        menuTabBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        menuTabBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    let videoCellId = "videoCellId"
    
    func setupCollectionView() {
        collectionView?.register(MainCell.self, forCellWithReuseIdentifier: videoCellId)
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
        
        // add right bar button item
        let search = UIBarButtonItem(image: UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(searchTapped))
        let more = UIBarButtonItem(image: UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(moreTapped))
        
        navigationItem.rightBarButtonItems = [more, search]
        
    }
    
    @objc func searchTapped() {
        
    }
    
    let settings = Settings()
    
    @objc func moreTapped() {
        settings.showSettings()
    }

    // MARK: - collection view delegate & datasource
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoCellId, for: indexPath) as! MainCell
        cell.video = videos?[indexPath.item]
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // remove the padding between cells
        return 0
    }
    
}

// MARK: - item size and spacing delegate
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 270)
    }

}











