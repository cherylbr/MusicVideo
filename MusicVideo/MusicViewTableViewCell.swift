//
//  MusicViewTableViewCell.swift
//  MusicVideo
//
//  Created by Cheryl Broder on 30/08/2016.
//  Copyright © 2016 Cheryl Broder. All rights reserved.
//

import UIKit

class MusicViewTableViewCell: UITableViewCell {

    
    var video : Videos? {
        didSet {
            updateCell()
        }
    }
    
    @IBOutlet weak var musicImage: UIImageView!
    
    @IBOutlet weak var rank: UILabel!
    
    @IBOutlet weak var musicTitle: UILabel!
    
    
    func updateCell() {
     
        musicTitle.text = video?.vName
        rank.text = ("\(video!.vRank)")
//      musicImage.image = UIImage(named: "imageNotAvail")
        
        if video!.vImageData != nil {
            print("get data from array ...")
            musicImage.image = UIImage(data: video!.vImageData!)
            
        }
        else {
            GetVideoImage(video!, imageView: musicImage)
            print("Get images in background thread")
        }
    }

    
    func GetVideoImage(video: Videos, imageView:UIImageView) {
     
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
            
            let data = NSData(contentsOfURL: NSURL(string: video.vImageURL)!)
            var image : UIImage?
            if data != nil {
                video.vImageData = data
                image = UIImage(data: data!)
            }
            dispatch_async(dispatch_get_main_queue()) {
                imageView.image = image
            }
        }
    }
}
