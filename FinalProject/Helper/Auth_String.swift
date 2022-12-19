//
//  Auth_String.swift

//
//  Created by iosMaher on 4/27/19.
//  Copyright © 2019 iosMaher. All rights reserved.
//

class Auth_Strings {
    
    static var shared = Auth_Strings()
    
    func PleaseVerifyEmail() -> String {
        return "Please Verify Your Email"
    }
    
    func ResetPasswordSuccessfully() -> String {
        return "Your password has been sent to you"
    }
    
    func InvalidEmail() -> String {
        return "Please enter valid email"
    }
    
    func EmailAlreadyInUse() -> String {
        return "Sorry!! This Email is already exist"
    }
    
    func NoInternetConnection() -> String {
        return "Please check your internet connection"
    }
    
    func WeakPassword() -> String {
        return "Weak password was entered .. Password must contains at least 6 Characters"
    }
    
    func UserNotFound() -> String {
        return "Sorry! This account can't be found"
    }
    
    func WrongPassword() -> String {
        return "Sorry! Wrong Password or Email"
    }
    
    func UnKnownProblem() -> String {
        return "An error occur please try again later"
    }
    func InvalidNumber() -> String{
        return "Plase Number Phone is required"
    }
    
    /// Fix Level 5 :: you have to look to this and solve it
    func RequiresRecentLogin() -> String {
        return "you have to login again"
    }
    
    func WeHaveSentYouAnEmailToResetPassword() -> String {
        return "An Email has been sent successfully.."
    }
    
    func EmailIsRequired() -> String
    {
        return "Please E-mail is required"
    }
    
    func PleaseEnterValidEmail() -> String
    {
        return "Please Enter Valid E-mail"
    }
    
    var PasswordChangedSuccessfully = "Password changed successfully"
    var CurrentPasswordWrong = "Current password is wrong"
    var CurrentPasswordisRequired = "Current password is required"
    let NewPasswordisRequired = "New password is required"
    
    
    func PasswordIsRequired() -> String
    {
        return "Password is required"
    }
    
    func PleaseConfirmPassword() -> String
    {
        return "Please Confirm Password is required"
    }
    
    func PasswordAndTheConfirmationAreNotMatched() -> String
    {
        return "Password does not match the confirm password"
    }
    
    func PleaseEnterYourName() -> String
    {
        return "Please Enter Your Name"
    }
    
    func PlaeseEnterYourMessage() -> String
    {
        return "Message is Requierd"
    }
    func MessageSendedSuccessfully() -> String
    {
        return "Message has been sent"
    }
    
    func CreateAccountSuccessfully() -> String {
        return "Your account has been created successfully..\nPlease check your email"
    }
    
    func UpdateAccountSuccessfully() -> String {
        return "Your account has been updated successfully"
    }
    
    func UpdateAccountFailed() -> String {
        return "Your account has not been Updated"
    }
    
    func DisbaledAccount() -> String {
        return "Your account is disabled"
    }
    
    func LocationSavedSuccessfully() -> String {
        return "Location has been saved successfully"
    }

    func VideoAddedSuccessfully() -> String {
        return "Your Video has been added successfully"
    }
    
    func InvalidPortalEmail() -> String {
        return "Invalid email"
    }
    static func Message(_ message: Strings) -> String {
        return message.rawValue.localized
    }
}
