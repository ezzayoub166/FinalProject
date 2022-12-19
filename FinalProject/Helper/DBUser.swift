//
//  DBUser.swift
//  FinalProject
//
//  Created by ezz on 03/12/2022.
//

import Foundation
import RealmSwift

class DBUser : Object {
    
    @objc dynamic var UserId : String = ""
    @objc dynamic var Username : String = ""
    @objc dynamic var Location : String = ""
    @objc dynamic var Email : String = ""
    @objc dynamic var UserImage : String = ""
    @objc dynamic var Gender : String = ""
    
    override class func primaryKey() -> String? {
        return "UserId"
    }
    
}
