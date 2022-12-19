//
//  settingsVC.swift
//  FinalProject
//
//  Created by ezz on 02/12/2022.
//

import UIKit


struct Section {
    let title : String
    let options : [Option]
}
struct Option {
    let title : String
    let handler : () -> Void
}


class settingsVC: UIViewController {

    private var settings : [Section] = []
    
    
    private let  tabelView : UITableView = {
        let tableView  = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setupdata()
    }
    
    private func setUpView(){
        title = "الإعدادات"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = UIColor(named: "MAIN")
        tabelView.backgroundColor = UIColor(named: "MAIN")
        tabelView.dataSource = self
        tabelView.delegate = self
        view.addSubview(tabelView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tabelView.frame = view.bounds
    }
    
    private func setupdata(){
        settings.append(Section(title: "الصفحة الرئيسية", options: [Option(title: "الصفحة الشخصية", handler: {
            self.viewProfile()
        })]))
        settings.append(Section(title: "القيود والأحكام", options: [Option(title: "القيود والأحكام", handler: {
            
        })]))
        settings.append(Section(title: "عن التطبيق", options: [Option(title: "عن التطبيق", handler: {
            
        })]))
        settings.append(Section(title: "تسجيل خروج", options: [Option(title: "تسجيل خروج", handler: {
            self.logout()
        })]))
    }
    
    private func viewProfile(){
        let vc = ProfileViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: false)
        
    }
    
    private func logout(){
        Auth_User.removeUserData()
        let main = LoginVC()
        (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.changeRootViewController(main)
        self.navigationController?.popToRootViewController(animated: true)
    }

}

extension settingsVC : UITableViewDataSource , UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settings.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings[section].options.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = settings[indexPath.section].options[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.title
        cell.backgroundColor = UIColor(named: "MAIN")
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // cell handler for cell
        let model = settings[indexPath.section].options[indexPath.row]
        model.handler()
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let model = settings[section]
        return model.title
    }

}
