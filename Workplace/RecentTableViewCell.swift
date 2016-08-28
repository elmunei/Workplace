//
//  RecentTableViewCell.swift
//  Workspace
//
//  Created by Elvis Tapfumanei on 8/6/16.
//  Copyright © 2016 Elmunei. All rights reserved.
//

import UIKit

class RecentTableViewCell: UITableViewCell {

    let backendless = Backendless.sharedInstance()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var lastMessageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var avatarImageView: UIImageView!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func bindData(recent: NSDictionary) {
    
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width/2
        avatarImageView.layer.masksToBounds = true
        
        self.avatarImageView.image = UIImage(named: "avatarPlaceholder")
        
        let withUserId = (recent.objectForKey("withUserUserId") as? String)!
        
        //get the backendless user and download avatar
        
        let whereClause = "objectId = '\(withUserId)"
        
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        
        
        let dataStore = backendless.persistenceService.of(BackendlessUser.ofClass())
        
        dataStore.find(dataQuery, response: {(users : BackendlessCollection!) -> Void in
            
            let withUser = users.data.first as! BackendlessUser
            
            /*use withUser to get avatar
            
            if let avatarURL = withUser.getProperty("Avatar") {
                getImageFromURL(avatarURL as! String, result: { (image) -> Void in
                    self.avatarImageView.image = image
                })
            }*/
            
        }) { (fault: Fault!) -> Void in
            print("error, couldnt get user avatar: \(fault)")
        }
        
        
        nameLabel.text = recent["withUserUsername"] as? String
        lastMessageLabel.text = recent["lastMessage"] as? String
        counterLabel.text = ""
        
        if (recent["counter"] as? Int)! != 0 {
            counterLabel.text = "\(recent["counter"]!) New"
        }
        
       
         let date = dateFormatter().dateFromString((recent["date"] as? String)!)
         let seconds = NSDate().timeIntervalSinceDate(date!)
         dateLabel.text = TimeElapsed(seconds)
        
    }
    func TimeElapsed(seconds: NSTimeInterval) -> String{
        let elapsed: String?
        
        if seconds < 60 {
            elapsed = "Just Now"
        } else if (seconds < 60 * 60) {
            let minutes = Int(seconds / 60)
            
            var minText = "min"
            if minutes > 1 {
                minText = "mins"
            }
            elapsed = "\(minutes) \(minText)"
            
        } else if (seconds < 24 * 60 * 60) {
            let hours = Int(seconds / (60 * 60))
            var hourText = "hour"
            if hours > 1 {
                hourText = "hours"
            }
            elapsed = "\(hours) \(hourText)"
        } else {
            let days = Int(seconds / (24 * 60 * 60))
            var dayText  = "day"
            if days > 1 {
                dayText = "days"
            }
            elapsed = "\(days) \(dayText)"
        }
        return elapsed!
    
    }

    
}
    
    

