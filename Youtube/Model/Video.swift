//
//  Video.swift
//  Youtube
//
//  Created by 徐永宏 on 2018/2/27.
//  Copyright © 2018年 徐永宏. All rights reserved.
//

import Foundation

struct Video {
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: Int?
    var duration: Int?
    var channel: Channel?
}


//    [
//        "thumbnail_image_name": https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_swift_i_knew_you_were_trouble.jpg,
//        "title": Taylor Swift - I Knew You Were Trouble (Exclusive),
//        "channel": {
//            name = "Taylor Fan Forever";
//            "profile_image_name" = "https://s3-us-west-2.amazonaws.com/youtubeassets/taylor_fan_forever_profile.jpg";
//        },
//        "duration": 210,
//        "number_of_views": 319644991
//    ]
extension Video {
    // initialize the video model with json object fetched from a url
    init?(json: [String: Any]) {
        guard
            let thumbnail_image_name = json["thumbnail_image_name"] as? String,
            let title = json["title"] as? String,
            let channelJSON = json["channel"] as? [String: String],
            let name = channelJSON["name"],
            let profile_image_name = channelJSON["profile_image_name"],
            let duration = json["duration"] as? Int,
            let number_of_views = json["number_of_views"] as? Int
        else {
            return nil
        }
        
        self.thumbnail_image_name = thumbnail_image_name
        self.title = title
        self.channel = Channel()
        self.channel!.name = name
        self.channel!.profile_image_name = profile_image_name
        self.duration = duration
        self.number_of_views = number_of_views
    }
    
    /**
    * fetch video feeds from server
    */
    static func videos(from urlStr: String, completion: @escaping ([Video])-> Void) {
        let url = URL(string: urlStr)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error != nil {
                return
            }
            
            var videos: [Video] = []
            
            do {
                if let wrappedData = data, let jsonDicArray = try JSONSerialization.jsonObject(with: wrappedData, options: .mutableContainers) as? [[String:Any]] {
                    // create the video model array, if there is data
                    
                    for jsonDic in jsonDicArray {
                        print(jsonDic)
                        if let video = Video(json: jsonDic) {
                            videos.append(video)
                        }
                        
                    }
                }
                
                completion(videos)
                
            } catch let jsonError {
                print(jsonError)
            }
            
            
            }.resume()  // fire up the request
    }
}











