//
//  SettingsCell.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/3/1.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

class SettingsCell: UICollectionViewCell {
    
    var settingData: Setting? {
        didSet {
            // setting a image whose tint color can change
            settingsImageView.image = UIImage(named: (settingData?.imageName)!)?.withRenderingMode(.alwaysTemplate)
            settingsImageView.tintColor = .darkGray
            settingsTitle.text = settingData?.name
        }
    }
    
    override var isHighlighted: Bool {
        didSet {
            // observe the cell's isHighlighted state
            backgroundColor = isHighlighted ? .black : .white
            
            settingsImageView.tintColor = isHighlighted ? .white : .darkGray
            
            settingsTitle.textColor = isHighlighted ? .white : .black
        }
    }
    
    lazy var settingsImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    lazy var settingsTitle: UILabel = {
        let lbl = UILabel()
        return lbl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubViews()
    }
    
    func setupSubViews() {
        addSubview(settingsImageView)
        addSubview(settingsTitle)
        
        // layout image view
        settingsImageView.translatesAutoresizingMaskIntoConstraints = false
        settingsImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        settingsImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        settingsImageView.widthAnchor.constraint(equalToConstant: 30).isActive = true
        settingsImageView.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // layout settings label
        settingsTitle.translatesAutoresizingMaskIntoConstraints = false
        settingsTitle.leftAnchor.constraint(equalTo: settingsImageView.rightAnchor, constant: 8).isActive = true
        settingsTitle.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
