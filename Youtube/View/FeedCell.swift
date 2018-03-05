//
//  FeedCell.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/3/2.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    
    var videos: [Video]?
    let cellId = "cellId"
    weak var mainController: MainViewController?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupCollectionView()
        
        fetchData()
    }
    
    func fetchData() {
        preconditionFailure("This method must be overridden!")
    }
    
    var lastY: CGFloat = 0

    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        lastY = cv.contentOffset.y
        cv.backgroundColor = .white
        cv.register(MainCell.self, forCellWithReuseIdentifier: cellId)
        cv.delegate = self
        cv.dataSource = self
        return cv
    }()
    
    func setupCollectionView() {
        addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        collectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        collectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        collectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FeedCell: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width, height: 270)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MainCell
        cell.video = videos?[indexPath.item]
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let player = Player()
        player.playVideo()
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let currentY = scrollView.contentOffset.y
//        let barHidden = currentY - lastY > 0
//        lastY = currentY
//
//        let isBarHidden = mainController?.navigationController?.isNavigationBarHidden
//
//        if isBarHidden! && barHidden {
//            return
//        }
//        if !isBarHidden! && !barHidden {
//            return
//        }
//
//        mainController?.navigationController?.setNavigationBarHidden(barHidden, animated: true)
//    }

}







