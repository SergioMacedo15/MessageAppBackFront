//
//  MessageAllModel.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 25/06/23.
//

import Foundation


class Message {
    var message : String?
    var idUser : String?
    
    init(dicionary: [String: Any]) {
        self.message = dicionary["text"] as? String
        self.idUser = dicionary["UserId"] as? String
    }
    
}

class Conversation {
    
    var name : String?
    var lastMessage : String?
    var idDestiny : String?
    
    init(dicionary: [String: Any]) {
        self.name = dicionary["userName"] as? String
        self.lastMessage = dicionary["last_Message"] as? String
        self.idDestiny = dicionary["DestinyID"] as? String
    }
    
}

class User{
    
    var name : String?
    var email : String?
    
    init(dicionary: [String: Any]) {
        self.name = dicionary["name"] as? String
        self.email = dicionary["email"] as? String
    }
}

class Contact {
  
    var name : String?
    var id : String?
    
    init(dicionary: [String: Any]?) {
        self.name = dicionary?["name"] as? String
        self.id = dicionary?["id"] as? String
    }
    
    convenience init(id: String , name: String) {
        self.init(dicionary: nil)
        self.name = name
        self.id = id
    }
}

