//
//  MenuBar.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/2/27.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

class MenuBar: UIView {
    
    let cellId = "cellId"
    
    lazy var menuCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MenuCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView.backgroundColor = AppConstant.APP_THEME_COLOR
        
        // select the first item by default
        let indexPath = IndexPath(item: 0, section: 0)
        collectionView.selectItem(at: indexPath, animated: false, scrollPosition: UICollectionViewScrollPosition(rawValue: 0))
        
        return collectionView
    }()
    
    lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    let menuBarImageNames = ["home", "trending", "subscriptions", "account"]

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = AppConstant.APP_THEME_COLOR
        
        setupMenuCollectionView()
        
        setupIndicatorView()
    }
    
    // the left constraint of the indicator to manipulate
    var indicatorLeftConstraint: NSLayoutConstraint?
    
    func setupIndicatorView() {
        addSubview(indicatorView)
        
        // layout
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorLeftConstraint = indicatorView.leftAnchor.constraint(equalTo: leftAnchor)
        indicatorLeftConstraint?.isActive = true
        indicatorView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        indicatorView.heightAnchor.constraint(equalToConstant: 3).isActive = true
        indicatorView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width / 4).isActive = true
    }
    
    func setupMenuCollectionView() {
        addSubview(menuCollectionView)
        menuCollectionView.translatesAutoresizingMaskIntoConstraints = false
        menuCollectionView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        menuCollectionView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        menuCollectionView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        menuCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension MenuBar: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! MenuCell
        cell.imageView.image = UIImage(named: menuBarImageNames[indexPath.item])?.withRenderingMode(.alwaysTemplate)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: frame.width / 4.0, height: frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let x = CGFloat(indexPath.row) * UIScreen.main.bounds.width / 4
        indicatorLeftConstraint?.constant = x
        // animate the constraint change
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
}
