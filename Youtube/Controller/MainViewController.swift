//
//  MainViewController.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/2/17.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

class MainViewController: UICollectionViewController {
    
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
    
    lazy var menuTabBar: MenuBar = {
        let menuBar = MenuBar()
        menuBar.mainController = self
        return menuBar
    }()
    
    // hiding behind navigation bar, so when navigation bar is retracted from drag gesture, there wont be a gap between navigation bar and menu bar
    let maskView: UIView = {
        let view = UIView()
        view.backgroundColor = AppConstant.APP_THEME_COLOR
        return view
    }()
    
    func setupMenuBar() {
        view.addSubview(menuTabBar)
        view.addSubview(maskView)
        
        // constraints for menuBar
        menuTabBar.translatesAutoresizingMaskIntoConstraints = false
        menuTabBar.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        // view.safeAreaLayoutGuide.topAnchor: this is where the status bar's bottom anchor is 
        menuTabBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuTabBar.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        menuTabBar.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        // constraint for maskView
        maskView.translatesAutoresizingMaskIntoConstraints = false
        maskView.bottomAnchor.constraint(equalTo: menuTabBar.topAnchor).isActive = true
        maskView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        maskView.heightAnchor.constraint(equalToConstant: (navigationController?.navigationBar.frame.height)!).isActive = true
        maskView.leftAnchor.constraint(equalTo: menuTabBar.leftAnchor).isActive = true
    }
    
    let videoCellId = "videoCellId"
    let sectionCellId = "sectionCellId"
    
    func setupCollectionView() {
        // specify the collection view scroll direction
        if let cLayout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            cLayout.scrollDirection = .horizontal
        }
        
        // enable paging
        collectionView?.isPagingEnabled = true
        
//        collectionView?.register(MainCell.self, forCellWithReuseIdentifier: videoCellId)
        collectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: sectionCellId)
        collectionView?.backgroundColor = .white
        // set layout insets for both collectionView and scroll indicator
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
    }
    
    func setupNavigationBar() {
        // make the navigation bar not half-tansparent
        navigationController?.navigationBar.isTranslucent = false
        
        // make the navigation bar to retract itself when collection view scroll up
        navigationController?.hidesBarsOnSwipe = true
        
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sectionCell = collectionView.dequeueReusableCell(withReuseIdentifier: sectionCellId, for: indexPath)
        let colors: [UIColor] = [.blue, .red, .yellow, .green]
        sectionCell.backgroundColor = colors[indexPath.item]
        return sectionCell
    }
    
    
    // MARK: - scrollView delegate method
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let indicatorConstraintL = menuTabBar.indicatorLeftConstraint
        // move the menu indicator when the collection view is dragged
        indicatorConstraintL?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let scrollEndPosX = targetContentOffset.pointee.x
        let itemNum = scrollEndPosX / view.frame.width
        let indexPath = IndexPath(item: Int(itemNum), section: 0)
        // select the correspondent menu item when the dragging is about to be finished
        menuTabBar.menuCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .left)
        
    }

    // MARK: - collection view delegate & datasource
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return videos?.count ?? 0
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: videoCellId, for: indexPath) as! MainCell
//        cell.video = videos?[indexPath.item]
//        return cell
//
//    }
    
}

// MARK: - item size and spacing delegate
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width: view.frame.width, height: 270)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}











