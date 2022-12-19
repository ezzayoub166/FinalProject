//
//  ProfileViewController.swift
//  FinalProject
//
//  Created by ezz on 10/12/2022.
//
enum ProfileViewModelType {
    case info, logout
}

struct ProfileViewModel {
    let viewModelType: ProfileViewModelType
    let title: String
    let handler: (() -> Void)?
}
import UIKit
import FirebaseAuth
import SDWebImage
import FirebaseStorage

final class ProfileViewController: UIViewController {

    private let tableView : UITableView = {
       let tableView = UITableView()
        tableView.register(ProfileTableViewCell.self,
                           forCellReuseIdentifier: ProfileTableViewCell.identifier)
        return tableView
    }()
    
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 2
        imageView.layer.cornerRadius = 50
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        return imageView
    }()
    
    private let storage = Storage.storage().reference()

    var data = [ProfileViewModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageView)
        view.addSubview(tableView)
        tableView.backgroundColor = UIColor(named: "MAIN")
        let user = Auth_User.UserInfo
        data.append(ProfileViewModel(viewModelType: .info,
                                     title: "Name: \(user.Username)",handler: nil))
        data.append(ProfileViewModel(viewModelType: .info,
                                     title: "Email: \(user.Email)" as String ,
                                     handler: nil))
        data.append(ProfileViewModel(viewModelType: .logout, title: "Log Out", handler: { [weak self] in

            guard let strongSelf = self else {
                return
            }

            let actionSheet = UIAlertController(title: "",
                                          message: "",
                                          preferredStyle: .actionSheet)
            actionSheet.addAction(UIAlertAction(title: "Log Out",
                                          style: .destructive,
                                          handler: { [weak self] _ in

                                            guard let strongSelf = self else {
                                                return
                                            }

            }))

            actionSheet.addAction(UIAlertAction(title: "Cancel",
                                                style: .cancel,
                                                handler: nil))

            strongSelf.present(actionSheet, animated: true)
        }))

        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
//        tableView.tableHeaderView = createTableHeader()
        
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self,
                                                action: #selector(didTapChangeProfilePic))
        imageView.addGestureRecognizer(gesture)
        applayConstraints()
        
        DataBaseManager.shared.uploadImagePicture(with: Auth_User._Token) { result in
            switch result {
            case .success(let url):
                DispatchQueue.main.async {
                    self.imageView.sd_setImage(with: URL(string: url))
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    private func applayConstraints(){
        imageView.translatesAutoresizingMaskIntoConstraints = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
    }
    
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//        tableView.frame = view.safeAreaLayoutGuide.layoutFrame
//    }
    
    @objc private func didTapChangeProfilePic() {
         presentPhotoActionSheet()
     }
    
    
    

//    func createTableHeader() -> UIView? {
//        guard let email = UserDefaults.standard.value(forKey: "email") as? String else {
//            return nil
//        }
//        let headerView = UIView(frame: CGRect(x: 0,
//                                        y: 0,
//                                              width: self.view.frame.width,
//                                        height: 300))
//
//        headerView.backgroundColor = .link
//
//        let imageView = UIImageView(frame: CGRect(x: (headerView.frame.width-150) / 2,
//                                                  y: 75,
//                                                  width: 150,
//                                                  height: 150))
//        imageView.contentMode = .scaleAspectFill
//        imageView.backgroundColor = .white
//        imageView.layer.borderColor = UIColor.white.cgColor
//        imageView.layer.borderWidth = 3
//        imageView.layer.masksToBounds = true
//        imageView.layer.cornerRadius = imageView.frame.width/2
//        imageView.image = UIImage(named: "user2")
//        imageView.backgroundColor = .black
//        headerView.addSubview(imageView)
//
//
//        return headerView
//    }

}

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let viewModel = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileTableViewCell.identifier,
                                                 for: indexPath) as! ProfileTableViewCell
        cell.backgroundColor = UIColor(named: "MAIN")
        cell.setUp(with: viewModel)
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        data[indexPath.row].handler?()
    }
}

class ProfileTableViewCell: UITableViewCell {

    static let identifier = "ProfileTableViewCell"

    public func setUp(with viewModel: ProfileViewModel) {
        self.textLabel?.text = viewModel.title
        switch viewModel.viewModelType {
        case .info:
            textLabel?.textAlignment = .left
            selectionStyle = .none
        case .logout:
            textLabel?.textColor = .red
            textLabel?.textAlignment = .center
        }
    }

}
extension ProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func presentPhotoActionSheet() {
        let actionSheet = UIAlertController(title: "Profile Picture",
                                            message: "How would you like to select a picture?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel,
                                            handler: nil))
        actionSheet.addAction(UIAlertAction(title: "Take Photo",
                                            style: .default,
                                            handler: { [weak self] _ in

                                                self?.presentCamera()

        }))
        actionSheet.addAction(UIAlertAction(title: "Chose Photo",
                                            style: .default,
                                            handler: { [weak self] _ in

                                                self?.presentPhotoPicker()
        }))

        present(actionSheet, animated: true)
    }

    func presentCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    func presentPhotoPicker() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        vc.allowsEditing = true
        present(vc, animated: true)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {return}
        guard let imageDate = image.pngData() else {return}
        let fileName = "userImage_\(Auth_User._Token)_\(UUID().uuidString)"
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
                    self.imageView.sd_setImage(with: URL(string: imageURL))
                    DataBaseManager.shared.updateUserPic(imageURL) { sucess in
                        print("sucess")
                    }
                    self.showToast("تم تحميل الصورة")
                }
            }
   
        }
    }
    

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }

}
