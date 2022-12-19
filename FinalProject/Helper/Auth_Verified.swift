
import UIKit
import Firebase
import FirebaseAuth
class Auth_Verified {
    
    static var shared = Auth_Verified()
    
    // send email verification
    func SendEmailVerification(completion : @escaping (_ ErrorMessage : String?)-> ()){
        if let user = Auth.auth().currentUser {
            
            user.sendEmailVerification(completion: { (Error) in
                
                if let ErrorCode = Error?._code
                {
                    completion(ErrorCode.description)
                    return
                }
                // no errors
                completion(nil)
            })
        }
    }
    
    private var authUser : User? {
        return Auth.auth().currentUser
    }

    public func sendVerificationMail(completion : @escaping (_ ErrorMessage : String?)-> ()) {
        if self.authUser != nil && !self.authUser!.isEmailVerified {
            self.authUser!.sendEmailVerification(completion: { (error) in
                // Notify the user that the mail has sent or couldn't because of an error.
                completion("send Email")
            })
        }
        else {
            // Either the user is not available, or the user is already verified.
            completion("is not availble...")
        }
    }
    
    func IsEmailVerified() -> Bool {
        if let user = Auth.auth().currentUser {
            return user.isEmailVerified
        } else {
            return false
        }
    }
}
