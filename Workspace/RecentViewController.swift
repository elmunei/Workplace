//
//  RecentViewController.swift
//  Workspace
//
//  Created by Elvis Tapfumanei on 8/6/16.
//  Copyright © 2016 Elmunei. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController,  UITableViewDataSource, UITableViewDelegate, ChooseUserDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var recents: [NSDictionary] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

       //loadRecents()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recents.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! RecentTableViewCell
        
        let recent = recents[indexPath.row]
        
        cell.bindData(recent)
        
        return cell
    }
    
    
    

     //MARK: IBActions
    
    @IBAction func startNewChatBarButtonItemPressed(sender: UIBarButtonItem) {
        performSegueWithIdentifier("recentToChooseUserVC", sender: self)
    }
    
    //MARK: Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "recentToChooseUserVC" {
            let vc = segue.destinationViewController as! ChooseUserViewController
           vc.delegate = self
        }
        
      /*  if segue.identifier == "recentToChatSeg" {
            let indexPath = sender as! NSIndexPath
            let chatVC = segue.destinationViewController as! ChatViewController
            chatVC.hidesBottomBarWhenPushed = true
            
            
            let recent = recents[indexPath.row]
            
            chatVC.recent = recent
            
            chatVC.chatRoomId = recent["chatRoomID"] as? String
        }*/
        
    }
    
    //MARK: ChooseUserDelegate
    
    func createChatroom(withUser: BackendlessUser) {
        
       /* let chatVC = ChatViewController()
        chatVC.hidesBottomBarWhenPushed = true
        
        navigationController?.pushViewController(chatVC, animated: true)
        
        chatVC.withUser = withUser
        chatVC.chatRoomId = startChat(backendless.userService.currentUser, user2: withUser)
    }*/
    
}
}