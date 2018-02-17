//
//  MainCell.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/2/17.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // set up the cell
        setupCell()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        // called if this cell is defrozened from a nib file
    }
    
    let coverImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named:"taylor_swift_blank_space"))
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userImage: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .green
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .yellow
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Black Space"
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .blue
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tayler Swift"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        return label
    }()
    
    let cellSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setupCell() {
        
        // add the main video cover image
        addSubview(coverImage)
        coverImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        coverImage.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        coverImage.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        coverImage.heightAnchor.constraint(equalToConstant: 160).isActive = true
        
        // add the user profile image
        addSubview(userImage)
        userImage.leftAnchor.constraint(equalTo: leftAnchor, constant: 8).isActive = true
        userImage.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 8).isActive = true
        userImage.widthAnchor.constraint(equalToConstant: 40).isActive = true
        userImage.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        // add the title label, its size is determined by its default content size
        addSubview(titleLabel)
        titleLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: coverImage.bottomAnchor, constant: 8).isActive = true
        
        // add the info label
        addSubview(infoLabel)
        infoLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 8).isActive = true
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        
        // add the separator line to the bottom of the cell
        addSubview(cellSeparator)
        cellSeparator.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        cellSeparator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        cellSeparator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cellSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
}
