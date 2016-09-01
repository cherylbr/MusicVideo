//
//  MusicVideoTVC.swift
//  MusicVideo
//
//  Created by Cheryl Broder on 29/08/2016.
//  Copyright © 2016 Cheryl Broder. All rights reserved.
//

import UIKit

class MusicVideoTVC: UITableViewController {

    var videos = [Videos]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityStatusChanged", name: "ReachStatusChanged", object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "preferredFontChange", name: UIContentSizeCategoryDidChangeNotification, object: nil)
        
        reachabilityStatusChanged()
        

    }
    func preferredFontChange () {
        print("the preferred font has changed")
    }
    
    func didLoadData(videos: [Videos]) {
        
        print(reachabilityStatus)
        
        self.videos = videos
        
        for (index, item) in videos.enumerate() {
            print("\(index) name = \(item.vName)")
        }
        
        tableView.reloadData()
    }
    
    
    func reachabilityStatusChanged() {
        
        switch reachabilityStatus {
        case NOACCESS :
        
        dispatch_async(dispatch_get_main_queue()) {
            
        
        let alert = UIAlertController(title: "No Internet Access", message: "Please make sure you are connected to the internet", preferredStyle: .Alert)
            
        let cancelAction = UIAlertAction(title: "Cancel", style: .Default) {
            action -> () in
            print("Cancel")
            }
            
        let deleteAction = UIAlertAction(title: "Delete", style: .Destructive) {
            action -> () in
            print("Delete")
            }
            
        let okAction = UIAlertAction(title: "OK", style: .Default) {
            action -> Void in
            print("OK")
            }
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        alert.addAction(deleteAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
        }
            
            
        default:
            
            if videos.count > 0 {
                print("Do not refresh API")
            }
            else {
                runAPI()
            }
        }
    }
    
    
    func runAPI() {
        // call API with callback function (completion handler)
        let api = APIManager()
        api.loadData("https://itunes.apple.com/us/rss/topmusicvideos/limit=200/json",completion: didLoadData)
    }
    
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "ReachStatusChanged", object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIContentSizeCategoryDidChangeNotification, object: nil)
    }
    

    // MARK: - Table view data source
    
//    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
//        return 132
//    }

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return videos.count
    }

    private struct storyboard {
        static let cellReuseIdentifier = "cell"
        static let segueIdentifier = "musicDetail"
        
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(storyboard.cellReuseIdentifier, forIndexPath: indexPath) as! MusicViewTableViewCell

        cell.video = videos[indexPath.row]

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == storyboard.segueIdentifier {
            if let indexpath = tableView.indexPathForSelectedRow {
             let video = videos[indexpath.row]
                let dvc = segue.destinationViewController as! MusicVideoDetailVC
                dvc.videos = video
            }
        }
    }

    
    
}
