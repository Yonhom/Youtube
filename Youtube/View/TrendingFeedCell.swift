//
//  TrendingFeedCell.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/3/5.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

class TrendingFeedCell: FeedCell {
    override func fetchData() {
        let urlStr = "https://s3-us-west-2.amazonaws.com/youtubeassets/trending.json"
        
        Video.videos(from: urlStr) { videos in
            self.videos = videos
            DispatchQueue.main.async(execute: {
                self.collectionView.reloadData()
            })
        }
    }
}
