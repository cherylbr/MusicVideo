//
//  ViewController.swift
//  MusicVideo
//
//  Created by Cheryl Broder on 26/07/2016.
//  Copyright © 2016 Cheryl Broder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    var videos = [Videos]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // call API with callback function (completion handler)
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json",completion: didLoadData)
    }
    
//        // call API with trailing closure
//        let api = APIManager()
//        api.loadData
//    ("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
//                (result:String) in
//                print(result)
//            }

//    )
    
    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for item in videos {
            print ("name = \(item.vName)")
            
        }
        
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
    }
}