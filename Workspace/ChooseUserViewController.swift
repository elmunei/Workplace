//
//  ChooseUserViewController.swift
//  Workspace
//
//  Created by Elvis Tapfumanei on 8/6/16.
//  Copyright © 2016 Elmunei. All rights reserved.
//

import UIKit

protocol ChooseUserDelegate {
    func createChatroom(withUser: BackendlessUser)
}

class ChooseUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    
    @IBOutlet weak var tableView: UITableView!
    
    
    var delegate: ChooseUserDelegate!
    var users: [BackendlessUser] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UITableviewDataSorce
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        let user = users[indexPath.row] 
        
        cell.textLabel?.text = user.name
        
        return cell
    }
    
    
    //MARK: UITableviewDelegate
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let user = users[indexPath.row]
        
        delegate.createChatroom(user)
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    // MARK: IBActions
    
    @IBAction func cancelButtonPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    //MARK: Load Backendless Users
    
    func loadUsers() {
        
        let whereClause = "objectId != '\(backendless.userService.currentUser.objectId)'"
        
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        
        let dataStore = backendless.persistenceService.of(BackendlessUser.ofClass())
        dataStore.find(dataQuery, response: { (users : BackendlessCollection!) -> Void in
            
            self.users = users.data as! [BackendlessUser]
            
            self.tableView.reloadData()
            
            for user in users.data{
                let u = user as! BackendlessUser
                print(u.name)
            }
            
            
            
        }) { (fault : Fault!) -> Void in
            print("Error, couldnt retrive users: \(fault)")
        }
    }
    

    
}
