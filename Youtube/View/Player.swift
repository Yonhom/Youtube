//
//  Player.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/3/5.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit
import AVFoundation

class Player: NSObject {
    
    let window = (UIApplication.shared.delegate!.window)!!
    
    lazy var playerParentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.frame = CGRect(x: window.frame.width, y: window.frame.height, width: 0, height: 0)
        return view
    }()
    
    func playVideo() {
        // add the player parent view to the top of window
        window.addSubview(playerParentView)
        let playerView = PlayerView(frame: CGRect(x: 0, y: 0, width: window.frame.width, height: window.frame.width * 9 / 16))
        playerView.playVideo(with: "https://firebasestorage.googleapis.com/v0/b/gameofchat-1bed9.appspot.com/o/How%20I%20Trained%20My%20Cats.mp4?alt=media&token=85b7f604-c1dc-4c21-967d-0a2969210f31")
        playerParentView.addSubview(playerView)
        
        // animate the parent view to full screen
        UIView.animate(withDuration: 0.5, delay: 0, options: .curveEaseOut, animations: {
            self.playerParentView.frame = self.window.frame
        }) { completed in
            UIApplication.shared.isStatusBarHidden = true
        }
    }

}
