//
//  MenuCell.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/2/27.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.tintColor = AppConstant.MENU_BAR_CELL_TINT_COLOR
        return iv
    }()
    
    override var isSelected: Bool {
        didSet {
            imageView.tintColor = isSelected ? .white : AppConstant.MENU_BAR_CELL_TINT_COLOR
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = AppConstant.APP_THEME_COLOR
        
        setupImageView()
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
