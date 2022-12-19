//
//  RequestVC.swift
//  FinalProject
//
//  Created by ezz on 02/12/2022.
//

import UIKit

class oredersVC: UIViewController {
    
    private var orders : [DBorder] = []
    
    private let collectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 340, height: 100)
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(orderCollectionViewCell.self, forCellWithReuseIdentifier: orderCollectionViewCell.identifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    override func viewDidLoad(){
        super.viewDidLoad()
        title = "الطلبات"
        applyNav()
        setUpView()
        applyCostraints()
        getOrder()
        
    }
    private func getOrder(){
        DataBaseManager.shared.listenForPostsAdded(with: Auth_User._Token) { result in
            switch result {
            case .success(let orders):
                DispatchQueue.main.async {
                    self.orders = orders
                    self.collectionView.reloadData()
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func applyCostraints(){
        let collectionViewConstraints = [
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor , constant: 10),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor , constant: -10 ),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor , constant: 10),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ]
        NSLayoutConstraint.activate(collectionViewConstraints)
    }
}

extension oredersVC {
    private func applyNav(){
        collectionView.backgroundColor = UIColor(named: "MAIN")
        view.backgroundColor = UIColor(named: "MAIN")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"), style: .plain, target: self, action: #selector(didTapAddReq))
        navigationItem.leftBarButtonItem?.tintColor = .white
        navigationController?.navigationBar.backgroundColor = UIColor(named: "MAIN")
        
    }
    
    @objc private func didTapAddReq(){
        let vc = EditOrderVC()
        vc.modalTransitionStyle = .coverVertical
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: false)
    }

    private func  setUpView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
}
extension oredersVC :  UICollectionViewDataSource , UICollectionViewDelegate  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return orders.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: orderCollectionViewCell.identifier, for: indexPath) as! orderCollectionViewCell
        let model = orders[indexPath.row]
        cell.configure(with: model)
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = orderDetailsVC()
        vc.object = orders[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: false)
    }
}
