//
//  OnboardingVC.swift
//  FinalProject
//
//  Created by ezz on 03/12/2022.
//

import UIKit

class OnboardingVC: UIViewController {
    
    
    
    private let customerButton : UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("عميل", for: .normal)
        button.backgroundColor = .white
        button.titleLabel?.text = "عميل"
        button.tintColor = .systemRed
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(customerButton)
        applyConstraints()
        customerButton.addTarget(self, action: #selector(GoSeccrenAuth), for: .touchUpInside)
    }
    
    @objc private func GoSeccrenAuth(){
        let vc = RegisterVC()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    private func applyConstraints() {
        let buttonConstraints = [
            customerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            customerButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            customerButton.heightAnchor.constraint(equalToConstant: 50),
            customerButton.widthAnchor.constraint(equalToConstant: 130)
        ]
        
        NSLayoutConstraint.activate(buttonConstraints)
    }

}
