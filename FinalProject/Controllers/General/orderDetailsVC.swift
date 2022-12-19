//
//  orderDetailsVC.swift
//  FinalProject
//
//  Created by ezz on 06/12/2022.
//

import UIKit

class orderDetailsVC: UIViewController {
    
    var object : DBorder?
    
    
    private let orderImageView : UIImageView = {
       let imageView = UIImageView()
        let image = UIImage(named: "ez")
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
        
    }()
    
    private let styleLabel : UILabel = {
        let label = UILabel()
        label.text = "الطراز:"
        label.textColor =  .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stayleValueLabel : UILabel = {
        let label = UILabel()
        label.text = "شقة"
        label.textColor =  .white
//        label.textAlignment = .left
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let spaceLabel : UILabel = {
        let label = UILabel()
        label.text = "المساحة:"
        label.textColor =  .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let spaceValueLabel : UILabel = {
        let label = UILabel()
        label.text = "200"
        label.textColor =  .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityLabel : UILabel = {
        let label = UILabel()
        label.text = "المدينة:"
        label.textColor =  .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let cityValueLabel : UILabel = {
        let label = UILabel()
        label.text = "غزة"
        label.textColor =  .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let regionLabel : UILabel = {
        let label = UILabel()
        label.text = "المنطقة:"
        label.textColor =  .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let regionValueLabel : UILabel = {
        let label = UILabel()
        label.text  = "خانيونس"
        label.textColor =  .white
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let  numberOfRoomsLabel : UILabel = {
       let label = UILabel()
        label.text = ":عدد الغرف"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfRoomsValueLable : UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let  numberOfFloorsLabel : UILabel = {
       let label = UILabel()
        label.text = "عدد الطوابق:"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let numberOfFloorsValueLabel : UILabel = {
        let label = UILabel()
        label.text = "5"
        label.font = .systemFont(ofSize: 16, weight: .thin)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ceilingHeightLabel : UILabel = {
        let label = UILabel()
        label.text = "ارتفاع السقف:200"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.textAlignment = .center
        label.sizeToFit()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let costLable : UILabel = {
        let label = UILabel()
        label.text = "التكلفة:4000"
        label.sizeToFit()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private var stackView : UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    
    private var secondstackView : UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private var thirdtackView : UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    private func configure(with model : DBorder){
        self.costLable.text = " التكلفة: \(model.cost)درهم"
        self.ceilingHeightLabel.text = " الارتفاع: \(model.ceilingHeight)متر"
        self.orderImageView.sd_setImage(with: URL(string : model.chartImage))
        self.stayleValueLabel.text = model.style
        self.spaceValueLabel.text = model.buildingArea
        self.regionValueLabel.text = model.region
        self.cityValueLabel.text = model.city
        self.numberOfFloorsValueLabel.text = String(model.theNumberOfFloors)
        self.numberOfRoomsValueLable.text = String(model.theNumberOfRooms)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        applyConstraints()
        addToStackView()
        guard let object = object else {
            return
        }
        configure(with: object)
        print(object)

    }
    
    private func addToStackView(){
        stackView.addArrangedSubview(spaceValueLabel)
        stackView.addArrangedSubview(spaceLabel)
        stackView.addArrangedSubview(stayleValueLabel)
        stackView.addArrangedSubview(styleLabel)
        secondstackView.addArrangedSubview(cityValueLabel)
        secondstackView.addArrangedSubview(cityLabel)
        secondstackView.addArrangedSubview(regionValueLabel)
        secondstackView.addArrangedSubview(regionLabel)
        thirdtackView.addArrangedSubview(numberOfRoomsValueLable)
        thirdtackView.addArrangedSubview(numberOfRoomsLabel)
        thirdtackView.addArrangedSubview(numberOfFloorsValueLabel)
        thirdtackView.addArrangedSubview(numberOfFloorsLabel)
    }
    private func addSubViews(){
        view.addSubview(orderImageView)
        view.addSubview(stackView)
        view.addSubview(secondstackView)
        view.addSubview(thirdtackView)
        view.addSubview(ceilingHeightLabel)
        view.addSubview(costLable)

        
    
    }
    private func applyConstraints(){
        
        
            orderImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150).isActive = true
            orderImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
            orderImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.topAnchor.constraint(equalTo: orderImageView.bottomAnchor, constant: 20).isActive = true
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
            secondstackView.translatesAutoresizingMaskIntoConstraints = false
            secondstackView.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
            secondstackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
            secondstackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
            thirdtackView.translatesAutoresizingMaskIntoConstraints = false
            thirdtackView.topAnchor.constraint(equalTo: secondstackView.bottomAnchor, constant: 20).isActive = true
            thirdtackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
            thirdtackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
            ceilingHeightLabel.topAnchor.constraint(equalTo: thirdtackView.bottomAnchor, constant: 10).isActive = true
            ceilingHeightLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
            ceilingHeightLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
            costLable.topAnchor.constraint(equalTo: ceilingHeightLabel.bottomAnchor, constant: 10).isActive = true
            costLable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40).isActive = true
            costLable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40).isActive = true
        
    }

}
