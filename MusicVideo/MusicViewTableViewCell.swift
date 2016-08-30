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
        musicImage.image = UIImage(named: "imageNotAvail")
    }
    
}
