 import Foundation
 import RealmSwift
 import Firebase
 
 let uiRealm = try! Realm()
 
 class RealmFunction {
    
    static var tool = RealmFunction()
    
    // User Func
    func getAllUsers() -> [DBUser] {
        return Array(uiRealm.objects(DBUser.self))
    }
    
    func getUsersByIds(ids: [String]) -> [DBUser] {
        let user_array = Array(uiRealm.objects(DBUser.self))
        let final_array = user_array.filter { (item) -> Bool in
            return ids.contains(where: {item.UserId == $0})
        }
        return final_array
    }
    
    func getAllUsersWithoutMe() -> [DBUser] {
        let predicate = NSPredicate(format: "UserId != %@",Auth_User._Token)
        return Array(uiRealm.objects(DBUser.self).filter(predicate))
    }
    
    func getUserById(UserId: String) -> DBUser? {
        let predicate = NSPredicate(format: "UserId == %@",UserId)
        if let user = uiRealm.objects(DBUser.self).filter(predicate).first {
            return user
        }else{
            return nil
        }
    }
    
    func userExist(UserId: String) -> Bool {
        let predicate = NSPredicate(format: "UserId == %@",UserId)
        return Array(uiRealm.objects(DBUser.self).filter(predicate)).count > 0 ? true : false
    }
    
    func saveUserToDatabase(snapshot:DataSnapshot) {
        
        let snapValue = snapshot.value as? [String:Any] ?? [:]
        
        let UserId        = snapValue["UserId"] as? String ?? ""
        let Username      = snapValue["Username"] as? String ?? ""
        let Location      = snapValue["Location"] as? String ?? ""
        let Email         = snapValue["Email"] as? String ?? ""
        let UserImage     = snapValue["UserImage"] as? String ?? ""
        let Gender        = snapValue["Gender"] as? String ?? ""
        
        let UserInfo = DBUser()
        
        UserInfo.UserId        = UserId
        UserInfo.Username      = Username
        UserInfo.Location      = Location
        UserInfo.Email         = Email
        UserInfo.UserImage     = UserImage
        UserInfo.Gender        = Gender

        
        try! uiRealm.write {
            uiRealm.add(UserInfo, update: .all)
        }
    }
    
 }
 
 extension RealmFunction {
    
//    func allWithoutFriends() -> [DBUser] {
//        let friend_array = getFriendsIds()
//        let user_array = getAllUsersWithoutMe()
//
//        let final_array = user_array.filter { (item) -> Bool in
//            return !friend_array.contains(where: {item.UserId == $0.UserId})
//        }
//
//        return final_array
//    }

//    func getFriends() -> [DBUser] {
//        let friend_array = Array(uiRealm.objects(DBFriend.self))
//        let user_array = getAllUsersWithoutMe()
//        let final_array = user_array.filter { (item) -> Bool in
//            return friend_array.contains(where: {item.UserId == $0.UserId})
//        }
//        return final_array
//    }
    
//    func getFriendsIds() -> [DBFriend] {
//        return Array(uiRealm.objects(DBFriend.self))
//    }
//
//    func getFriendById(UserId: String) -> DBFriend? {
//        let predicate = NSPredicate(format: "UserId == %@",UserId)
//        if let user = uiRealm.objects(DBFriend.self).filter(predicate).first {
//            return user
//        }
//        return nil
//    }
//
//    func alreadyFriend(UserId: String) -> Bool {
//        let predicate = NSPredicate(format: "UserId == %@",UserId)
//        let count = uiRealm.objects(DBFriend.self).filter(predicate).count
//        return count > 0 ? true : false
//    }
//
//    func removeFriendById(UserId: String) {
//        if let obj = getFriendById(UserId: UserId) {
//            try! uiRealm.write {
//                uiRealm.delete(obj)
//            }
//        }
//    }
    
//    func saveFriend(snapshot: DataSnapshot) {
//        let UserId = snapshot.key
//        let UserInfo = DBFriend()
//        UserInfo.UserId = UserId
//        try! uiRealm.write {
//            uiRealm.add(UserInfo, update: .all)
//        }
//    }
    
//    func removeNeededData() {
//        let friends = uiRealm.objects(DBFriend.self)
//        try! uiRealm.write() {
//            uiRealm.delete(friends)
//        }
//    }
    
 }
