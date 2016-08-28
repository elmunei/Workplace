//
//  ChatViewController.swift
//  Workplace
//
//  Created by Elvis Tapfumanei on 8/11/16.
//  Copyright © 2016 Elmunei. All rights reserved.
//

import UIKit

class ChatViewController: JSQMessagesViewController {

    
    
    let ref = firebase.child("Message")
    
    var messages: [JSQMessage] = []
    var objects: [NSDictionary] = []
    var loaded: [NSDictionary] = []
    
    
    
    var withUser: BackendlessUser?
    var recent: NSDictionary?
    
    
    var chatRoomId: String!
    var  initialLoadComplete: Bool = false
    
    
    
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleBlueColor())
    
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.senderId = backendless.userService.currentUser.objectId
        self.senderDisplayName = backendless.userService.currentUser.name
        
        
        collectionView.collectionViewLayout.incomingAvatarViewSize = CGSizeZero
        collectionView.collectionViewLayout.outgoingAvatarViewSize = CGSizeZero
        
       /* if withUser?.objectId == nil {
            getWithUserFromRecent(recent!, result: { (withUser) in
                self.withUser = withUser
                self.title = withUser.name
                self.getAvatars()
            })
        } else {
            self.title = withUser!.name
            self.getAvatars()
        }*/
        
        //load firebase messages
        loadmessages()
        
        self.inputToolbar?.contentView?.textView?.placeHolder = "New Message"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: JSQMessages dataSource functions
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let data = messages[indexPath.row]
        
        if data.senderId == backendless.userService.currentUser.objectId {
           cell.textView?.textColor = UIColor.whiteColor()
        } else {
            cell.textView?.textColor = UIColor.blackColor()
        }
        
        return cell
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        
        let data = messages[indexPath.row]
        
        return data
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return messages.count
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        let data = messages[indexPath.row]
        
        if data.senderId == backendless.userService.currentUser.objectId {
            return outgoingBubble
        } else {
            return incomingBubble
        }
    }
    
    /*override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        
        if indexPath.item % 3 == 0 {
            
            let message = messages[indexPath.item]
            
            return JSQMessagesTimestampFormatter.sharedFormatter().attributedTimestampForDate(message.date)
        }
        return nil
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        if indexPath.item % 3 == 0 {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        }
        return 0.0
    }
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        
        let message = objects[indexPath.row]
        
        let status = message["status"] as! String
        
        if indexPath.row == (messages.count - 1) {
            return NSAttributedString(string: status)
        } else {
            return NSAttributedString(string: "")
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellBottomLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        
        if outgoing(objects[indexPath.row]) {
            return kJSQMessagesCollectionViewCellLabelHeightDefault
        } else {
            return 0.0
        }
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        
        let message = messages[indexPath.row]
        let avatar = avatarDictionary!.objectForKey(message.senderId) as! JSQMessageAvatarImageDataSource
        
        return avatar
    }*/
    
    
    
    //MARK: JSQMessages Delegate function
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        if text != "" {
           sendMessage(text, date: date, picture: nil, location: nil)
            
           
        }
        
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        
        /*let camera = Camera(delegate_: self)
        
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: .ActionSheet)
        
        let takePhoto = UIAlertAction(title: "Take Photo", style: .Default) { (alert: UIAlertAction!) -> Void in
            camera.PresentPhotoCamera(self, canEdit: true)
        }
        
        let sharePhoto = UIAlertAction(title: "Photo Library", style: .Default) { (alert: UIAlertAction!) -> Void in
            camera.PresentPhotoLibrary(self, canEdit: true)
        }
        
        let shareLoction = UIAlertAction(title: "Share Location", style: .Default) { (alert: UIAlertAction!) -> Void in
            
            if self.haveAccessToLocation() {
                self.sendMessage(nil, date: NSDate(), picture: nil, location: "location")
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel) { (alert : UIAlertAction!) -> Void in
            
            print("Cancel")
        }
        
        optionMenu.addAction(takePhoto)
        optionMenu.addAction(sharePhoto)
        optionMenu.addAction(shareLoction)
        optionMenu.addAction(cancelAction)
        
        self.presentViewController(optionMenu, animated: true, completion: nil)*/
        
        print("accessory button pressed")
    }
    
    
    //MARK: Send Message
    
    func sendMessage(text: String?, date: NSDate, picture: UIImage?, location: String?) {
        
        var outgoingMessage = OutgoingMessage?()
        
        //if text message
        if let text = text {
            outgoingMessage = OutgoingMessage(message: text, senderId: backendless.userService.currentUser.objectId!, senderName: backendless.userService.currentUser.name!, date: date, status: "Delivered", type: "text")
        }
        
        //send picture message
        if let pic = picture {
            
            let imageData = UIImageJPEGRepresentation(pic, 1.0)
            
            outgoingMessage = OutgoingMessage(message: "Picture", pictureData: imageData!, senderId: backendless.userService.currentUser.objectId!, senderName: backendless.userService.currentUser.name!, date: date, status: "Delivered", type: "picture")
        }
        
        /*if let _ = location {
            
            let lat: NSNumber = NSNumber(double: (appDelegate.coordinate?.latitude)!)
            let lng: NSNumber = NSNumber(double: (appDelegate.coordinate?.longitude)!)
            
            outgoingMessage = OutgoingMessage(message: "Location", latitude: lat, longitude: lng, senderId: backendless.userService.currentUser.objectId!, senderName: backendless.userService.currentUser.name!, date: date, status: "Delivered", type: "location")
        }*/
        
        //play message sent sound
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        self.finishSendingMessage()
        
        
        outgoingMessage!.sendMessage(chatRoomId, item: outgoingMessage!.messageDictionary)
    }
    
    
    //MARK: Load Messages
    
   func loadmessages() {
        
        
        ref.child(chatRoomId).observeEventType(.ChildAdded, withBlock: {
            snapshot in
            
            if snapshot.exists() {
                let item = (snapshot.value as? NSDictionary)!
                
                if self.initialLoadComplete {
                    let incoming = self.insertMessage(item)
                    
                    if incoming {
                        JSQSystemSoundPlayer.jsq_playMessageReceivedSound()
                    }
                    
                    self.finishReceivingMessageAnimated(true)
                    
                } else {
                    self.loaded.append(item)
                }
            }
        })
        
        
        ref.child(chatRoomId).observeEventType(.ChildChanged, withBlock: {
            snapshot in
            
            //updated message
        })
        
        
        ref.child(chatRoomId).observeEventType(.ChildRemoved, withBlock: {
            snapshot in
            
            //Deleted message
        })
        
        ref.child(chatRoomId).observeSingleEventOfType(.Value, withBlock:{
            snapshot in
            
            self.insertMessages()
            self.finishReceivingMessageAnimated(true)
            self.initialLoadComplete = true
        })
        
    }
    
    func insertMessages() {
        
        for item in loaded {
            //create message
            insertMessage(item)
        }
    }
    
    func insertMessage(item: NSDictionary) -> Bool {
        
        let incomingMessage = IncomingMessage(collectionView_: self.collectionView!)
        
        let message = incomingMessage.createMessage(item)
        
        objects.append(item)
        messages.append(message!)
        
        return incoming(item)
    }
    
    func incoming(item: NSDictionary) -> Bool {
        
        if backendless.userService.currentUser.objectId == item["senderId"] as! String {
            
            return false
        } else {
            return true
        }
    }
    
    func outgoing(item: NSDictionary) -> Bool {
        
        if backendless.userService.currentUser.objectId == item["senderId"] as! String {
            return true
        } else {
            return false
        }
    }
    
    
   
}

