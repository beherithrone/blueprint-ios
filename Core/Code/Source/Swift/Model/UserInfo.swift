//
//  UserInfo.swift
//  Core
//
//  Created by Pavel Jacko on 11/11/2015.
//
//

import Foundation

public class UserInfo: AnObject {
    
    dynamic public var id : String = "";
    dynamic public var name : String?  = "";
    dynamic public var email : String? = "";
    dynamic public var token : String = "";
    
    public convenience required init(id : String, name : String?, email: String?, token: String) {
        self.init()
        self.id = id
        self.name = name
        self.email = email;
        self.token = token;
        
    }
}
