//
//  MainCell.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/2/17.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell {
    
    var video: Video? {
        // after a video model is assigned for each cell, populate the cell
        didSet {
            
            guard
                let thumbImageName = video?.thumbnail_image_name,
                let profileImageName = video?.channel?.profile_image_name,
                let title = video?.title,
                let numOfViews = video?.number_of_views,
                let channelName = video?.channel?.name,
                let duration = video?.duration
            else {
                return
            }
            
            // load thumb image asyncally
            UIImage.getImage(named: thumbImageName, completion: { image in
                DispatchQueue.main.async(execute: {
                    self.coverImage.image = image
                })
            })
            // load profile image asyncally
            UIImage.getImage(named: profileImageName, completion: { image in
                DispatchQueue.main.async(execute: {
                    self.userImage.image = image
                })
            })
            
            self.titleLabel.text = title
            
            let formatter = NumberFormatter()
            formatter.numberStyle = .decimal
            let numOfViewsStr = formatter.string(from: NSNumber(value: numOfViews))
            
            let infoText = "\(channelName)·\(numOfViewsStr!) views·2014-5-2"
            
            infoLabel.text = infoText
        }
    }
    
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
        imageView.image = UIImage(named: "taylor_swift_profile")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Blank Space"
        label.numberOfLines = 2
        return label
    }()
    
    let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Tayler Swift"
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 2
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
        titleLabel.rightAnchor.constraint(equalTo: coverImage.rightAnchor).isActive = true
        
        // add the info label
        addSubview(infoLabel)
        infoLabel.leftAnchor.constraint(equalTo: userImage.rightAnchor, constant: 8).isActive = true
        infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        infoLabel.rightAnchor.constraint(equalTo: coverImage.rightAnchor).isActive = true
        
        // add the separator line to the bottom of the cell
        addSubview(cellSeparator)
        cellSeparator.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        cellSeparator.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        cellSeparator.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cellSeparator.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    
}
