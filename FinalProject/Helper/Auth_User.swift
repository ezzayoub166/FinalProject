//
//  Auth_User.swift
//  FinalProject
//
//  Created by ezz on 03/12/2022.
//

import Foundation
import UIKit
import FirebaseAuth
class Auth_User {
    
    static let shared = Auth_User()
    
    static let ud = UserDefaults.standard
    
    
    static var UserData:[String:Any] {
        get {
            let ud = UserDefaults.standard
            let data = ud.value(forKey: "UserData") as? Data ?? Data()
            do {
                guard let userData = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [String:Any] else {
                    fatalError("loadUserData - Can't get user data")
                }
                return userData
            } catch {
                fatalError("loadUserData - Can't encode data: \(error)")
            }
        }
        set (token) {
            let ud = UserDefaults.standard
            do {
                let encodedData = try NSKeyedArchiver.archivedData(withRootObject: token, requiringSecureCoding: true)
                ud.set(encodedData, forKey: "UserData")
                
            }catch {
                fatalError("loadUserData - Can't encode data: \(error)")
            }
        }
    }
    
    static var UserInfo : DBUser {
          get {
              return DBUser(value: Auth_User.UserData)
//              return UserSt(Auth_User.UserData)
          }
      }
    

    
    static var _UserInfo : DBUser? {
        get {
            return RealmFunction.tool.getUserById(UserId: _Token)
        }
    }
    
    static var _Token : String {
        get {
            return ud.value(forKey: "token") as? String ?? ""
        }
        set(token){
            ud.set(token, forKey: "token")
            ud.synchronize()
        }
    }
    
    static var _userName : String {
        get {
            return ud.value(forKey: "UserName") as? String ?? ""
        }
        set(userName) {
            ud.set(userName, forKey: "UserName")
            ud.synchronize()
        }
    }
    
    static var _Password : String {
        get {
            return ud.value(forKey: "Password") as? String ?? ""
        }
        set(password) {
            ud.set(password, forKey: "Password")
            ud.synchronize()
        }
    }
    
    static var _isLoggedIn : Bool {
        get {
            return (_Token != "")
        }
    }
    
    static func topVC() -> UIViewController? {
        if let top_vc = UIApplication.topViewController() {
            return top_vc
        }
        return nil
    }
    
    static func ShowAlert(msg: String, _ isAlert : Bool = true) {
        if isAlert {
            topVC()?.showOkAlert(title: "", message: msg)
        }else{
//            topVC()?.showToast(msg)
        }
    }
    
    static func removeUserData() {
        signOut()
        ud.removeObject(forKey: "token")
        ud.removeObject(forKey: "UserName")
        ud.removeObject(forKey: "Password")
        ud.synchronize()
    }
    
    static func signOut() {
        try? Auth.auth().signOut()
    }
    
    
}
