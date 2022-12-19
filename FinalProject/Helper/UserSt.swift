//
//  StrUser.swift
//  FinalProject
//
//  Created by ezz on 03/12/2022.
//

import Foundation
import Firebase

class UserSt {

    var UserId        : String = ""
    var Username      : String = ""
    var Email         : String = ""
    var Location      : String = ""
    var UserImage     : String = ""
    var Gender        : String = ""


//    init(_ snapshot: DataSnapshot) {
//        let obj = snapshot.value as? [String:Any] ?? [:]
//
//        self.UserId        = obj["UserId"] as? String ?? ""
//        self.Username      = obj["Username"] as? String ?? ""
//        self.Location      = obj["Location"] as? String ?? ""
//        self.Email         = obj["Email"] as? String ?? ""
//        self.UserImage     = obj["UserImage"] as? String ?? ""
//        self.Gender        = obj["Gender"] as? String ?? ""
//    }
    
    init(_ snap: Any) {
        let snapshot = snap as? DataSnapshot
        let obj = snapshot?.value as? [String: Any] ?? [:]

        self.UserId        = obj["UserId"] as? String ?? ""
        self.Username      = obj["Username"] as? String ?? ""
        self.Location      = obj["Location"] as? String ?? ""
        self.Email         = obj["Email"] as? String ?? ""
        self.UserImage     = obj["UserImage"] as? String ?? ""
        self.Gender        = obj["Gender"] as? String ?? ""
    }
    
    init( UserId: String,
          Username: String,
          Location: String,
          Email: String,
          UserImage: String,
          Gender: String
        ){
        
        self.UserId        = UserId
        self.Username      = Username
        self.Location      = Location
        self.Email         = Email
        self.UserImage     = UserImage
        self.Gender        = Gender

    }
    
    func toDic() -> [String:Any] {
        return [ "UserId"        : self.UserId,
                 "Username"      : self.Username,
                 "Location"      : self.Location,
                 "Email"         : self.Email,
                 "UserImage"     : self.UserImage,
                 "Gender"        : self.Gender,
        ]
    }
    
    func toAnyObject() -> [String:Any] {
        return [
                     "UserId"        : self.UserId,
                     "Username"      : self.Username,
                     "Location"      : self.Location,
                     "Email"         : self.Email,
                     "UserImage"     : self.UserImage,
                     "Gender"        : self.Gender ]
    }
    
}
