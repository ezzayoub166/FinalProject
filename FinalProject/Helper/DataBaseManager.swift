//
//  Request.swift
//  FinalProject
//
//  Created by ezz on 03/12/2022.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore
import FirebaseAuth
//import FirebaseDatabaseSwift


final class DataBaseManager {
    
    
    public static let shared = DataBaseManager()
    
    private let database = Database.database().reference()
    
    private let db = Firestore.firestore()
    
    private init() {}
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }
    
    public func sendVerificationMail() {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                // Notify the user that the mail has sent or couldn't because of an error.
            })
        }
        else {
            // Either the user is not available, or the user is already verified.
        }
    }
    
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _ in
            if error == nil {
                completion(true)
                return
            } else {
                completion(false)
                return
            }
        }
    }
    public func addOrder(with token : String , order : Order , completion : @escaping (Bool) -> Void) {
        
        Constants.users_path.child(token).child("Orders").childByAutoId().updateChildValues(order.toDic()) { error, dataResult in
            if error != nil {
                Auth_User.ShowAlert(msg: error!.localizedDescription)
                completion(false)
            }
            else {
                Auth_User.ShowAlert(msg: "Done Sucess...")
                completion(true)
            }
        }
    }
    
    public func updateUserPic(_ imageURL : String ,completion : @escaping (Bool) -> Void) {
        let userID = Auth_User._Token
        let parms : [String:Any] = ["UserImage" : imageURL]
        database.child("users").child(userID).updateChildValues(parms) { error, snapshot in
            if error != nil {
                Auth_User.ShowAlert(msg: error!.localizedDescription)
                completion(false)
            }
            else {
                Auth_User.ShowAlert(msg: "Done Sucess")
                completion(true)
            }
            
        }
    }
    
    public func updateUser(param: [String:Any] ,completion : @escaping (Bool) -> Void) {
        let userId = Auth_User._Token
        
        db.collection("users").document(userId).updateData(param) { error in
            guard error == nil else {
                completion(false)
                return
            }
            completion(true)
        }
    }

    
    public func getOrderByToken(with token : String , completion : @escaping(Result<[Order],Error>) -> Void){
        Constants.users_path.child(token).child("Orders").getData { error, Datasnapshot in
            guard let snapshot = Datasnapshot , error != nil else   {
                completion(.failure(error as! Error))
                return
            }
//            else {
                var orders : [Order] = []
            print(snapshot.value as? NSDictionary)
          }
        }
    
//    public func getUserData(with token : String , completion : @escaping(Result<UserSt,Error>) -> Void){
//        Constants.users_path.child(token).observe(.value, with: { snapshot  in
//            if snapshot.value is NSNull {
//                print("- - - Data was not found - - -")
//                completion(.failure(DatabaseError.failedToFetch))
//            }
//            else {
//                for orderChild in snapshot.children {
////                    let orderChild = orderChild as! DataSnapshot
//                    guard let userName = orderChild["userName"] as? String else {
//                        return
//                    }
//                    print()
//                    completion(.success(UserSt(UserId: "", Username: userName, Location: "", Email: "", UserImage: "", Gender: "")))
//                }
//            }
//        })
//    }
    
    
    
    public func uploadImagePicture(with token : String , completion : @escaping(Result<String,Error>) -> Void){
        Constants.users_path.child(token).child("UserImage").getData(completion:  { error, snapshot in
            guard error == nil else {
              print(error!.localizedDescription)
              return;
            }
            let UserImage = snapshot?.value as? String ?? "Unknown"
            completion(.success(UserImage))            
          });
    }
    
    public func listenForPostsAdded(with token : String , completion: @escaping (Result<[DBorder],Error>) -> Void) {
        Constants.users_path.child(token).child("Orders").observe(.value, with: { snapshot  in
            
            // SHOWING WHATEVER WAS RECEIVED FROM THE SERVER JUST AS A CONFIRMATION. FEEL FREE TO DELETE THIS LINE.
            var orders:[DBorder] = []
            
            // PROCESSES VALUES RECEIVED FROM SERVER
            if ( snapshot.value is NSNull ) {
                
                // DATA WAS NOT FOUND
                print("– – – Data was not found – – –")
                completion(.failure(DatabaseError.failedToFetch))
                
            } else {
                
                // DATA WAS FOUND
                for order_child in (snapshot.children) {
                    
                    let order_child = order_child as! DataSnapshot
                    let dict = order_child.value as! [String: Any]
                    
                    guard let userId = dict["userId"] as? String,
                          let userName =  dict["userName"] as? String,
                         let  style =  dict["style"] as? String,
                          let region = dict["region"] as? String,
                          let city =  dict["city"] as? String,
                          let buildingArea =  dict["buildingArea"] as? String,
                          let theNumberOfRooms =  dict["theNumberOfRooms"] as? Int,
                          let theNumberOfFloors =  dict["theNumberOfFloors"] as? Int,
                          let ceilingHeight =  dict["ceilingHeight"] as? String,
                          let cost = dict["cost"] as? Int,
                          let chartImage =  dict["chartImage"] as? String
                    else {
                        return
                    }
                    let order = DBorder(userId: userId, userName: userName, style: style, region: region, city: city, buildingArea: buildingArea, theNumberOfRooms: theNumberOfRooms, theNumberOfFloors: theNumberOfFloors, ceilingHeight: ceilingHeight, cost: cost, chartImage: chartImage)
                    orders.append(order)
                }
                completion(.success(orders))
            }
        })}
    
    
    public enum DatabaseError: Error {
        case failedToFetch

        public var localizedDescription: String {
            switch self {
            case .failedToFetch:
                return "This means blah failed"
            }
        }
    }
            
  
    public func register(email: String, password: String, completion: @escaping(String)->Void) {
        
            Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
                if error != nil {
//                    window?.hideIndicator()
//                    if let errCode = error?._code {
//                    }
                    print("!!!!!!!!!!!!!!!!\(error?.localizedDescription)")
                }
            else{
                    completion(user!.user.uid)
                }
            }
        }
    
    //  Sign in
    func logIn(WithEmail Email : String , Password : String , completion : @escaping (_ ErrorMessage : String?,_ userId:String) -> ()) {
        
        Auth.auth().signIn(withEmail: Email, password: Password, completion: { (FIRUser, Error) in
            
            // error
            if let TheErrorCode = Error?._code
            {
                completion(Auth_ErrosManager.shared.TranslateError(WithErrorCode: TheErrorCode),"")
                return
            }
            
            // no errors
            let user_id = FIRUser!.user.uid
            completion(nil,user_id)
        })
    }
    
    
    
    
    }
