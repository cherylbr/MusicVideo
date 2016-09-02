//
//  SettingsTVC.swift
//  MusicVideo
//
//  Created by Cheryl on 9/2/16.
//  Copyright © 2016 Cheryl Broder. All rights reserved.
//

import UIKit

class SettingsTVC: UITableViewController {

    
    
    
    @IBOutlet weak var aboutDisplay: UILabel!
    
    
    
    @IBOutlet weak var feedback: UILabel!
    
    @IBOutlet weak var securityDisplay: UILabel!
    
    
    @IBOutlet weak var touchID: UISwitch!
    
    
    @IBOutlet weak var bestImageDisplay: UILabel!
    
    
    @IBOutlet weak var APICnt: UILabel!
    
    
    
    @IBOutlet weak var sliderCnt: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        
       tableView.alwaysBounceVertical = false

    }
    
    func preferredFontChange()  {
        aboutDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        feedback.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        securityDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        bestImageDisplay.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
        APICnt.font = UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }


}