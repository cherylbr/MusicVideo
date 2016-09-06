//
//  MusicVideoDetailVC.swift
//  MusicVideo
//
//  Created by Cheryl Broder on 31/08/2016.
//  Copyright © 2016 Cheryl Broder. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation
import LocalAuthentication


class MusicVideoDetailVC: UIViewController {

    var videos:Videos!
    
    var securitySwitch:Bool = false
    
    @IBOutlet weak var vName: UILabel!
    
    @IBOutlet weak var videoImage: UIImageView!
    
    @IBOutlet weak var vGenre: UILabel!
    
    @IBOutlet weak var vPrice: UILabel!
    
    @IBOutlet weak var vRights: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = videos.vArtist
        vName.text = videos.vName
        vPrice.text = videos.vPrice
        vRights.text = videos.vRights
        vGenre.text = videos.vGenre
        
        if videos.vImageData != nil {
            videoImage.image = UIImage(data: videos.vImageData!)
            
        }
        else {
            videoImage.image = UIImage(named: "imageNotAvail")
        }
    }
    
    @IBAction func socialMedia(sender: UIBarButtonItem) {
        
        securitySwitch = NSUserDefaults.standardUserDefaults().boolForKey("SecSetting")
        
        switch securitySwitch {
        case true:
            touchIdCheck()
        default:
            shareMedia()
        }
        
    }
    
    func touchIdCheck () {
        
        //create an alert
        let alert = UIAlertController(title: "", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "continue", style: UIAlertActionStyle.Cancel, handler: nil))
       
        //create the Local Authentication Context
        let context = LAContext()
        var touchIdError : NSError?
        let reasonString = "Touch-Id is needed to share info on Social Media"
        
        //check if we can access local device authentication
        if context.canEvaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, error: &touchIdError) {
            context.evaluatePolicy(LAPolicy.DeviceOwnerAuthenticationWithBiometrics, localizedReason:
                reasonString, reply: { (success, policyError) -> Void in
                    if success {
                        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                            self.shareMedia()
                        }
                    }
                        else {
                            alert.title = "Unsuccessful!"
                            
                            switch LAError(rawValue: policyError!.code)! {
                            case .AppCancel:
                                alert.message = "Authentification was cancelled by application"
                            case .AuthenticationFailed:
                                alert.message = "The user failed to provide valid credentials"
                            case .PasscodeNotSet:
                                alert.message = "Passcode is not set on the device"
                            case.SystemCancel:
                                alert.message = "Authentification was cancelled by the system"
                            case.TouchIDLockout:
                                alert.message = "Too many failed attempts"
                            case.UserCancel:
                                alert.message = "You cancelled the request"
                            case.UserFallback:
                                alert.message = "Password not accepted, must use Touch-Id"
                            default:
                                alert.message = "Unable to Authenticate!"
                            }
                        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
                            self.presentViewController(alert, animated: true, completion: nil)
                            
                        }
                    }
        
        
                })
        } else {
            // unable to access local authentification
            alert.title = "Error"
            
            switch LAError(rawValue: touchIdError!.code)! {
            case .TouchIDNotEnrolled:
                alert.message = "Touch Id is not enrolled"
            case .TouchIDNotAvailable:
                alert.message = "Touch Id is not available on the device"
            case.PasscodeNotSet:
                alert.message = "Passcode has not been set"
            case.InvalidContext:
                alert.message = "The context is invalid"
            default:
                alert.message = "Local Authentification not available"
            }
            
            self.presentViewController(alert, animated: true, completion: nil)

        }
    }
 
    
    
    func shareMedia() {
        let activity1 = "Have you had the opportunity to see this music video?"
        let activity2 = ("\(videos.vName) by \(videos.vArtist)")
        let activity3 = "Watch it and tell me what you think"
        let activity4 = videos.vLinkToiTunes
        let activity5 = "(Shared with the Music Video App - Step it up!)"
        
        let activityViewController : UIActivityViewController = UIActivityViewController(activityItems: [activity1, activity2, activity3, activity4, activity5], applicationActivities: nil)
        
        activityViewController.completionWithItemsHandler = {
            (activity, success, items, error) in
            
            if activity == UIActivityTypeMail {
                print("email selected")
            }
        }
        self.presentViewController(activityViewController, animated: true, completion: nil)
        
    }
    
    
    @IBAction func playVideo(sender: UIBarButtonItem) {
       let url = NSURL(string: videos.vVideoURL)!
        let player = AVPlayer(URL: url)
        let playerViewController = AVPlayerViewController()
        playerViewController.player = player
        self.presentViewController(playerViewController, animated: true) {
            playerViewController.player?.play()
        }
        
        
    }
    

}
