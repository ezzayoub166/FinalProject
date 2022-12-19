//
//  Auth_Errors.swift
//  FinalProject
//
//  Created by ezz on 04/12/2022.
//

import Foundation
import FirebaseAuth

class Auth_ErrosManager {
    
    static var shared = Auth_ErrosManager()
    
    func TranslateError(WithErrorCode code : Int) -> String
    {
        if let FIRAuthError = AuthErrorCode.Code.init(rawValue: code){//(rawValue: Code) {
            switch FIRAuthError {
            case .invalidEmail:
                return Auth_Strings.shared.InvalidEmail()
            case .emailAlreadyInUse:
                return Auth_Strings.shared.EmailAlreadyInUse()
            case .networkError:
                return Auth_Strings.shared.NoInternetConnection()
            case .weakPassword:
                return Auth_Strings.shared.WeakPassword()
            case .userNotFound:
                return Auth_Strings.shared.UserNotFound()
            case .wrongPassword:
                return Auth_Strings.shared.WrongPassword()
            case .requiresRecentLogin:
                return Auth_Strings.shared.RequiresRecentLogin()
            default:
                break
            }
        }
        
        return Auth_Strings.shared.UnKnownProblem()
    }
    
}
