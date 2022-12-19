//
//  EditOrderVC.swift
//  FinalProject
//
//  Created by ezz on 04/12/2022.
//

import UIKit
import iOSDropDown
import FirebaseStorage
import Firebase
import SDWebImage
class EditOrderVC: UIViewController {
    
    
    //MARK: Vars
    
    

    let  dropDown = DropDown() // set frame

    private let storage = Storage.storage().reference()
    
    private var imageURL : String?
    
    private var company : String?

    
    //MARK: let for UI
    private let chooseTypetxt : UITextField = {
       let filed = UITextField()
        filed.attributedPlaceholder = NSAttributedString(string: "اختيار الطراز" , attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray])
        filed.backgroundColor = .white
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16 , weight: .thin)
        filed.layer.cornerRadius = 5
        filed.layer.masksToBounds = true
        filed.clipsToBounds = false
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let areatxt : UITextField = {
     let filed = UITextField()
        filed.attributedPlaceholder = NSAttributedString(string: "المنطقة" , attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGray])
        filed.backgroundColor = .white
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.layer.cornerRadius = 5
        filed.layer.masksToBounds = true
        filed.clipsToBounds = false
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let citytxt : UITextField = {
     let filed = UITextField()
        filed.attributedPlaceholder = NSAttributedString(string: "المدينة" , attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGray])
        filed.backgroundColor = .white
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.layer.cornerRadius = 5
        filed.layer.masksToBounds = true
        filed.clipsToBounds = false
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let spacetxt : UITextField = {
     let filed = UITextField()
        filed.attributedPlaceholder = NSAttributedString(string: "مساحة البناء(متر)" , attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGray])
        filed.backgroundColor = .white
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.layer.cornerRadius = 5
        filed.layer.masksToBounds = true
        filed.clipsToBounds = false
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    

    private let numberofFloorsttxt : UITextField = {
     let filed = UITextField()
        filed.attributedPlaceholder = NSAttributedString(string: "عدد الطوابق" , attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGray])
        filed.backgroundColor = .white
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.layer.cornerRadius = 5
        filed.layer.masksToBounds = true
        filed.clipsToBounds = false
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let numberofRoomstxt : UITextField = {
     let filed = UITextField()
        filed.attributedPlaceholder = NSAttributedString(string: "عدد الغرف" , attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGray])
        filed.backgroundColor = .white
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.layer.cornerRadius = 5
        filed.layer.masksToBounds = true
        filed.clipsToBounds = false
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let heighttxt : UITextField = {
     let filed = UITextField()
        filed.attributedPlaceholder = NSAttributedString(string: "ارتفاع السقف(متر)" , attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGray])
        filed.backgroundColor = .white
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.layer.cornerRadius = 5
        filed.layer.masksToBounds = true
        filed.clipsToBounds = false
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let costtxt : UITextField = {
     let filed = UITextField()
        filed.attributedPlaceholder = NSAttributedString(string: "التكلفة(درهم)" , attributes: [NSAttributedString.Key.foregroundColor :UIColor.lightGray])
        filed.backgroundColor = .white
        filed.textAlignment = .center
        filed.font = .systemFont(ofSize: 16, weight: .thin)
        filed.layer.cornerRadius = 5
        filed.layer.masksToBounds = true
        filed.clipsToBounds = false
        filed.translatesAutoresizingMaskIntoConstraints = false
        return filed
    }()
    
    private let choseComapnyButton : UIButton = {
     let button = UIButton()
        button.setTitle("اختيار الشركة" , for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .thin)
        button.titleLabel?.textColor = .secondaryLabel
        button.layer.cornerRadius = 5
        button.titleLabel?.textAlignment = .center
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let imageForPlan : UIButton = {
     let button = UIButton()
        button.setTitle("صورة المخطط", for: .normal)
        button.backgroundColor = .lightGray
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .thin)
        button.titleLabel?.textColor = .secondaryLabel
        button.layer.cornerRadius = 5
        button.titleLabel?.textAlignment = .center
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let orderbtn : UIButton = {
       let button = UIButton()
        button.setTitle("طلب", for: .normal)
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.textColor = .systemTeal
        button.backgroundColor = .secondaryLabel
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.clipsToBounds = false
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    
    private func createDropDown(){
        // The list of array to display. Can be changed dynamicall
         dropDown.optionArray = ["فيلا", "منزل", "شقة"]
        dropDown.backgroundColor = .white
        
        // Its Id Values and its optional
        dropDown.optionIds = [1,23,54,22]
    
        // The the Closure returns Selected Index and String
        dropDown.didSelect{(selectedText , index ,id) in
            self.chooseTypetxt.text = "\(selectedText)"
            }
        
        dropDown.translatesAutoresizingMaskIntoConstraints = false
        dropDown.layer.cornerRadius = 5
        dropDown.layer.masksToBounds = true
        dropDown.clipsToBounds = false
        dropDown.text = "الطراز"
        }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        applyConstraints()
        createDropDown()
        title = "طلب سعر"
        navigationController?.navigationBar.prefersLargeTitles = false
        orderbtn.addTarget(self, action: #selector(didTapDone), for: .touchUpInside)
        imageForPlan.addTarget(self, action: #selector(AddPicture), for: .touchUpInside)
        choseComapnyButton.addTarget(self, action: #selector(didTapChooseCompany), for: .touchUpInside)
        
    }
    
    @objc public func AddPicture(){
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc private func didTapDone(){
        guard let style = dropDown.text , !style.isEmptyStr else {
            return
        }
        guard let region = areatxt.text , !region.isEmptyStr else {
            return
        }
        guard let city = citytxt.text , !city.isEmptyStr else {
            return
        }
        guard let numberOfFloors = numberofFloorsttxt.text , !numberOfFloors.isEmptyStr else{
            return
        }
        guard let numberOfRooms = numberofRoomstxt.text , !numberOfRooms.isEmptyStr else {
            return
        }
        guard let buildingArea = spacetxt.text , !buildingArea.isEmptyStr else {
            return
        }
        guard let height = heighttxt.text , !height.isEmptyStr else {
            return
        }
        guard let cost = costtxt.text , !cost.isEmptyStr  else  {
            return
        }
        let order = Order(userId: Auth_User._Token, userName: Auth_User._userName, style: style, region: region, city: city, buildingArea:buildingArea , theNumberOfRooms: (numberOfRooms as NSString).integerValue, theNumberOfFloors: (numberOfFloors as NSString).integerValue, ceilingHeight: height, cost: (cost as NSString).integerValue, chartImage: imageURL ?? "")
        
        DataBaseManager.shared.addOrder(with: Auth_User._Token, order: order) { result in
            self.dropDown.text = "طلب الطراز"
            self.areatxt.text = ""
            self.spacetxt.text = ""
            self.citytxt.text = ""
            self.costtxt.text = ""
            self.heighttxt.text = ""
            self.numberofFloorsttxt.text = ""
            self.numberofRoomstxt.text = ""
            
        }
    }
    
    //MARK: Constraint
    
    private func applyConstraints(){
        
        let choseTybetxtConstraints = [
            dropDown.topAnchor.constraint(equalTo: view.topAnchor, constant: 160),
            dropDown.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            dropDown.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            dropDown.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let areatxtConstraints = [
            areatxt.topAnchor.constraint(equalTo: dropDown.bottomAnchor, constant: 10),
            areatxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            areatxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            areatxt.heightAnchor.constraint(equalToConstant: 40)
        
        ]
        
        let citytxtConstraints = [
            citytxt.topAnchor.constraint(equalTo: areatxt.bottomAnchor, constant: 10),
            citytxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            citytxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            citytxt.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let choseComapnyButtonConstraints = [
            choseComapnyButton.topAnchor.constraint(equalTo: citytxt.bottomAnchor, constant: 10),
            choseComapnyButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            choseComapnyButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            choseComapnyButton.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let spacetxtConstraints = [
            spacetxt.topAnchor.constraint(equalTo: choseComapnyButton.bottomAnchor, constant: 10),
            spacetxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            spacetxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            spacetxt.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let numberofdepartmnttxtConstraints = [
            numberofFloorsttxt.topAnchor.constraint(equalTo: spacetxt.bottomAnchor, constant: 10),
            numberofFloorsttxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            numberofFloorsttxt.heightAnchor.constraint(equalToConstant: 40),
            numberofFloorsttxt.widthAnchor.constraint(equalToConstant: 120)
        ]
        
        let numberofRoomstxtConstraints = [
            numberofRoomstxt.topAnchor.constraint(equalTo: spacetxt.bottomAnchor , constant: 10),
            numberofRoomstxt.leadingAnchor.constraint(equalTo: numberofFloorsttxt.trailingAnchor, constant: 10),
            numberofRoomstxt.heightAnchor.constraint(equalTo: numberofFloorsttxt.heightAnchor),
            numberofRoomstxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            numberofRoomstxt.widthAnchor.constraint(equalToConstant: 100)
        ]
        
        let heighttxtConstraints = [
            heighttxt.topAnchor.constraint(equalTo: numberofFloorsttxt.bottomAnchor, constant: 10),
            heighttxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            heighttxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            heighttxt.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let costtxtConstraints = [
            costtxt.topAnchor.constraint(equalTo: heighttxt.bottomAnchor, constant: 10),
            costtxt.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            costtxt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            costtxt.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        let imageForPlanConstraints = [
            imageForPlan.topAnchor.constraint(equalTo: costtxt.bottomAnchor, constant: 10),
            imageForPlan.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            imageForPlan.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            imageForPlan.heightAnchor.constraint(equalToConstant: 40)
        ]
        
        
        let orderbtnConstraints = [
            orderbtn.heightAnchor.constraint(equalToConstant: 40),
            orderbtn.widthAnchor.constraint(equalToConstant: 100),
            orderbtn.topAnchor.constraint(equalTo: imageForPlan.bottomAnchor, constant: 20),
            orderbtn.centerXAnchor.constraint(equalTo: imageForPlan.centerXAnchor)
        ]

        
        NSLayoutConstraint.activate(choseTybetxtConstraints)
        NSLayoutConstraint.activate(areatxtConstraints)
        NSLayoutConstraint.activate(citytxtConstraints)
        NSLayoutConstraint.activate(spacetxtConstraints)
        NSLayoutConstraint.activate(numberofdepartmnttxtConstraints)
        NSLayoutConstraint.activate(numberofRoomstxtConstraints)
        NSLayoutConstraint.activate(heighttxtConstraints)
        NSLayoutConstraint.activate(costtxtConstraints)
        NSLayoutConstraint.activate(imageForPlanConstraints)
        NSLayoutConstraint.activate(orderbtnConstraints)
        NSLayoutConstraint.activate(choseComapnyButtonConstraints)
    }
    
    @objc private func didTapChooseCompany(){
        let vc = compainesVC()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    private func addSubViews(){
        view.addSubview(dropDown)
        view.addSubview(areatxt)
        view.addSubview(citytxt)
        view.addSubview(spacetxt)
        view.addSubview(numberofFloorsttxt)
        view.addSubview(numberofRoomstxt)
        view.addSubview(heighttxt)
        view.addSubview(costtxt)
        view.addSubview(imageForPlan)
        view.addSubview(orderbtn)
        view.addSubview(choseComapnyButton)
    }
    



}
extension EditOrderVC :  UIImagePickerControllerDelegate , UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        picker.dismiss(animated: true)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let imageDate = image.pngData() else {return}
        let fileName = "OrderImage_\(UUID().uuidString)"
        let path = "images/" + fileName
        
        let ref = storage.child(path)

        ref.putData(imageDate, metadata: nil) { metaData , error in
            
            guard error == nil else {
                print("Failed to upload")
                return
            }

            ref.downloadURL { url, error in
                guard error == nil else { return }
                
                if let imageURL = url?.absoluteString {
                    self.imageURL = imageURL
                    self.imageForPlan.setTitle( "تم رفع الصورة", for: .normal)
                }
            }
   
        }
    }

   func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
       self.dismiss(animated: true)
   }
}
