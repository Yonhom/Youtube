//
//  UIImage+Web.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/2/28.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

extension UIImage {
    static func getImage(named name: String, completion: @escaping (UIImage) -> Void) {
        
        guard let url = URL(string: name) else {
            print("image url doesn't exist!")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("error occurred while fetching image data!")
                return
            }
            
            if let image = UIImage(data: data!) {
                completion(image)
            }
            
        }.resume() // fire it up!
        
    }
}
