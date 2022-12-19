//
//  RegisterVC.swift
//  FinalProject
//
//  Created by ezz on 01/12/2022.
//

import UIKit
import FirebaseAuth

class RegisterVC: UIViewController {
    
    var delegate: ((String)->())?
    
    private let registerbtn : UIButton = {
       let button = UIButton()
        button.setTitle("تسجيل", for: .normal)
        button.titleLabel?.textColor = .black
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private let _switch : UISwitch = {
        let _switch  = UISwitch()
        _switch.translatesAutoresizingMaskIntoConstraints = false
        _switch.isOn = true
        return _switch
    }()
    
    
    private let label : UILabel = {
        let label = UILabel()
        label.text = "الموافقة على الشروط والأحكام"
        label.textColor =  .black
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let imageLogo : UIImageView = {
       let imageView = UIImageView()
       let image = UIImage(named: "user1")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
       imageView.image = image
         return imageView
    }()
    
    private let userNametxt : UITextField = {
       let filed = UITextField()
        filed.backgroundColor = .white
        filed.attributedPlaceholder = NSAttributedString(string: "اسم المتسخدم ", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let emailtxt : UITextField = {
     let filed = UITextField()
        filed.backgroundColor = .white
        filed.attributedPlaceholder = NSAttributedString(string: "البريد الإكتروني" , attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGray])
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    
    private let phoneNumbertxt : UITextField = {
       let filed = UITextField()
        filed.backgroundColor = .white
        filed.attributedPlaceholder = NSAttributedString(string: "رقم الموبايل" , attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let passwordtxt : UITextField = {
     let filed = UITextField()
        filed.backgroundColor = .white
        filed.attributedPlaceholder = NSAttributedString(string: "كلمة المرور" , attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGray])
        filed.textAlignment = .center
        filed.isSecureTextEntry = true
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let confirmpasswordtxt : UITextField = {
     let filed = UITextField()
        filed.backgroundColor = .white
        filed.attributedPlaceholder = NSAttributedString(string: "تأكيد كلمة المرور" , attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGray])
        filed.textAlignment = .center
        filed.isSecureTextEntry = true
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageLogo)
        view.addSubview(userNametxt)
        view.addSubview(emailtxt)
        view.addSubview(passwordtxt)
        view.addSubview(confirmpasswordtxt)
        view.addSubview(phoneNumbertxt)
        view.addSubview(label)
        view.addSubview(_switch)
        view.addSubview(registerbtn)
        view.backgroundColor = UIColor(named: "MAIN")
        registerbtn.addTarget(self, action: #selector(didTapRegiset), for: .touchUpInside)
        applyConstraints()e
    }
    
    @objc private func didTapRegiset(){
        
        guard let Name = userNametxt.text, !Name.TrimWhiteSpaces.isEmpty else {
            self.showToast(Auth_Strings.Message(.NameRequired))
            return
        }
        
        guard let Email = emailtxt.text, !Email.TrimWhiteSpaces.isEmpty else {
            self.showToast(Auth_Strings.Message(.EmailRequired))
            return
        }
        
        guard let PhoneNumber = phoneNumbertxt.text , !PhoneNumber.TrimWhiteSpaces.isEmpty , PhoneNumber.isValidPhone else {
            self.showToast(Auth_Strings.Message(.PhotoRequired))
            return
        }
        
        guard Email.isEmailValid else {
            self.showToast(Auth_Strings.Message(.InvalidEmail))
            return
        }
        
        guard let Password = passwordtxt.text, !Password.TrimWhiteSpaces.isEmpty else {
            self.showToast(Auth_Strings.Message(.PasswordRequired))
            return
        }
        
        guard let ConfirmPassword = confirmpasswordtxt.text, !ConfirmPassword.TrimWhiteSpaces.isEmpty else {
            self.showToast(Auth_Strings.Message(.ConfirmPasswordRequired))
            return
        }
        
        guard Password == ConfirmPassword else {
            self.showToast(Auth_Strings.Message(.PasswordAndConfirmationNotMatch))
            return
        }
        guard  _switch.isOn == true else {
            self.showToast("الرجاء الموافقة على الشروط والأحكام")
            return
        }
        
        
        DataBaseManager.shared.register(email: Email, password: Password) { userid in
            Auth_Verified.shared.sendVerificationMail(completion:
             { ErrorMessage in
               
                let user_obj = UserSt(UserId: userid,
                                      Username: Name,
                                      Location: PhoneNumber ,
                                      Email: Email,
                                      UserImage: "",
                                      Gender: "")
                
                Auth_User._Token = user_obj.UserId
                Constants.users_path.child(userid).updateChildValues(user_obj.toDic()) { error, data in
                    if error != nil {
                        self.showOkAlert(message: error!.localizedDescription)
                    }else {
                        self.showOkAlertWithComp(title: "", message: Auth_Strings.Message(.CreateAccountSuccessfully)) { action in
                            let main = LoginVC()
                            (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(main)
                        }
                    }

                }
            })
        }
    }
    
    private func applyConstraints(){
        let imageLogoConstraints = [
            imageLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            imageLogo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            imageLogo.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            imageLogo.heightAnchor.constraint(equalToConstant: 100),
            imageLogo.widthAnchor.constraint(equalToConstant: 100)
        ]
        let usernametxtConstraints = [
            userNametxt.topAnchor.constraint(equalTo: imageLogo.bottomAnchor, constant: 20),
            userNametxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNametxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNametxt.heightAnchor.constraint(equalToConstant: 40)
        
        ]
        
        let emailtxtConstrains = [
            emailtxt.topAnchor.constraint(equalTo: userNametxt.bottomAnchor, constant: 10),
            emailtxt.leadingAnchor.constraint(equalTo: userNametxt.leadingAnchor),
            emailtxt.trailingAnchor.constraint(equalTo: userNametxt.trailingAnchor),
            emailtxt.heightAnchor.constraint(equalToConstant: 40)
        
        ]
        let phoneNumberConstrains = [
            phoneNumbertxt.topAnchor.constraint(equalTo: emailtxt.bottomAnchor, constant: 10),
            phoneNumbertxt.leadingAnchor.constraint(equalTo: userNametxt.leadingAnchor),
            phoneNumbertxt.trailingAnchor.constraint(equalTo: userNametxt.trailingAnchor),
            phoneNumbertxt.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let passwordtxtConstraints = [
            passwordtxt.topAnchor.constraint(equalTo: phoneNumbertxt.bottomAnchor, constant: 10),
            passwordtxt.leadingAnchor.constraint(equalTo: userNametxt.leadingAnchor),
            passwordtxt.trailingAnchor.constraint(equalTo: userNametxt.trailingAnchor),
            passwordtxt.heightAnchor.constraint(equalToConstant: 40)
        
        ]
        
        let confirmpasswordtxtConstraints = [
            confirmpasswordtxt.topAnchor.constraint(equalTo: passwordtxt.bottomAnchor, constant: 10),
            confirmpasswordtxt.leadingAnchor.constraint(equalTo: userNametxt.leadingAnchor),
            confirmpasswordtxt.trailingAnchor.constraint(equalTo: userNametxt.trailingAnchor),
            confirmpasswordtxt.heightAnchor.constraint(equalToConstant: 40)
        
        ]
        
        
        let _switchConstraints = [
            _switch.trailingAnchor.constraint(equalTo: label.leadingAnchor , constant: -7),
            _switch.topAnchor.constraint(equalTo: confirmpasswordtxt.bottomAnchor, constant: 10),
        ]
        
        let labelAcceptOnReqConstraints = [
            label.topAnchor.constraint(equalTo: confirmpasswordtxt.bottomAnchor, constant: 10),
//            label.leadingAnchor.constraint(equalTo: _switch.trailingAnchor, constant: 10),
            label.centerXAnchor.constraint(equalTo: confirmpasswordtxt.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: _switch.centerYAnchor)
        ]
        
        let registerBtnConstraints = [

            registerbtn.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 40),
            registerbtn.heightAnchor.constraint(equalToConstant: 40),
            registerbtn.centerXAnchor.constraint(equalTo: label.centerXAnchor),
            registerbtn.widthAnchor.constraint(equalToConstant: 130)
        ]
        NSLayoutConstraint.activate(imageLogoConstraints)
        NSLayoutConstraint.activate(usernametxtConstraints)
        NSLayoutConstraint.activate(emailtxtConstrains)
        NSLayoutConstraint.activate(phoneNumberConstrains)
        NSLayoutConstraint.activate(passwordtxtConstraints)
        NSLayoutConstraint.activate(confirmpasswordtxtConstraints)
        NSLayoutConstraint.activate(_switchConstraints)
        NSLayoutConstraint.activate(labelAcceptOnReqConstraints)
        NSLayoutConstraint.activate(registerBtnConstraints)
    }

}
