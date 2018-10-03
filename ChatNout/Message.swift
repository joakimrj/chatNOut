//
//  Message.swift
//  ChatNout
//
//  Created by Joakim Jorde on 10/2/18.
//  Copyright © 2018 Joakim Jorde. All rights reserved.
//

import UIKit
import Parse

class Message: PFObject, PFSubclassing {
   
    @NSManaged var message: String
    @NSManaged var user: String
    
    class func parseClassName() -> String {
        return "Message"

    }
}
