//
//  UIImage+Web.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/2/28.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import UIKit

// for caching images
let imageCache = NSCache<AnyObject, AnyObject>()

extension UIImage {
    static func getImage(named name: String, completion: @escaping (UIImage) -> Void) {
        
        // validate image url
        guard let url = URL(string: name) else {
            print("image url doesn't exist!")
            return
        }
        
        // check cache before request
        if let image = imageCache.object(forKey: name as AnyObject) as? UIImage {
            completion(image)
            return
        }
        
        // fire up a image url request
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print("error occurred while fetching image data!")
                return
            }
            
            if let image = UIImage(data: data!) {
                // store the image in the image cache first
                imageCache.setObject(image, forKey: name as AnyObject)
                completion(image)
            }
            
        }.resume() // fire it up!
        
    }
}
