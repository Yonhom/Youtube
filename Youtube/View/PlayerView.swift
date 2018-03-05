//
//  PlayerView.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/3/5.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit
import AVFoundation

class PlayerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    func playVideo(with urlStr: String) {
        backgroundColor = .black
        // avplayer
        var avPlayer: AVPlayer?
        if let url = URL(string: urlStr) {
            avPlayer = AVPlayer(url: url)
            let avPlayerLayer = AVPlayerLayer(player: avPlayer)
            layer.addSublayer(avPlayerLayer)
            avPlayerLayer.frame = frame
            avPlayer?.play()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
