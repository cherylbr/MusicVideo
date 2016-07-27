//
//  ViewController.swift
//  MusicVideo
//
//  Created by Cheryl Broder on 26/07/2016.
//  Copyright © 2016 Cheryl Broder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        // call API with callback function (completion handler)
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json",completion: didLoadData)
    }
    
//        // call API with trailing closure
//        let api = APIManager()
//        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=10/json") {
//                (result:String) in
//                print(result)
//            }

//    )
    
    func didLoadData(result: String) {
        
        let alert = UIAlertController(title: (result), message: nil, preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "OK", style: .Default) {
            action -> Void in
        }
        alert.addAction(okAction)
        self.presentViewController(alert, animated: true, completion: nil)
        
        print(result)
    }
}