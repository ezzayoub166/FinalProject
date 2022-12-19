//
//  compainesVC.swift
//  FinalProject
//
//  Created by ezz on 02/12/2022.
//

import UIKit

class compainesVC: UIViewController {
    
    private let collectionView : UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 340, height: 100)
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(orderCollectionViewCell.self, forCellWithReuseIdentifier: orderCollectionViewCell.identifier)
        return collectionView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "الشركات"
        navigationItem.leftBarButtonItem?.tintColor = .white
        collectionView.backgroundColor = UIColor(named: "MAIN")
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        view.backgroundColor = UIColor(named: "MAIN")
        tabBarController?.tabBar.backgroundColor = UIColor(named: "MAIN")
        setUpView()
    }
    
    private func setUpView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension compainesVC : UICollectionViewDataSource , UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: orderCollectionViewCell.identifier, for: indexPath) as! orderCollectionViewCell
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        let vc = orderDetailsVC()
//        self.navigationController?.pushViewController(vc, animated: false)
    }
}
