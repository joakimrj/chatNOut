//
//  ChatViewController.swift
//  ChatNout
//
//  Created by Joakim Jorde on 9/28/18.
//  Copyright © 2018 Joakim Jorde. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {
    
    var messages : [PFObject] = []
    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.rowHeight = UITableView.automaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
        

         fetchMessages()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell
        
        cell.messageLabel.text = messages[indexPath.row]["text"] as? String
        if let user = messages[indexPath.row]["user"] as? PFUser {
            // User found! update username label with username
            cell.usernameLabel.text = user.username
        } else {
            // No user found, set default username
            cell.usernameLabel.text = "Anonymous"
        }
        
        return cell
    }
    
    @objc func onTimer() {
        fetchMessages()
    }
    
    func fetchMessages(){
        let query = Message.query()
        query?.includeKey("user")
        query?.addDescendingOrder("createdAt")
        query?.limit = 20
        
        query?.findObjectsInBackground{ (messages: [PFObject]?,error: Error?) -> Void in
            if let messages = messages{
                self.messages = messages
                self.tableView.reloadData()
                print(messages)
            }
            else{
            }
        }
    }
    

 
   
    @IBAction func sendMessage(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }

    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
