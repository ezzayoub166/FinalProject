//
//  CompinesCollectionViewCell.swift
//  FinalProject
//
//  Created by ezz on 02/12/2022.
//

import UIKit

class orderCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CompinesCollectionViewCell"
    
    private let imageViewRequest : UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 15
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private var typelabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "قيبلا"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16 , weight: .bold)
        label.textColor = .label
        return label
    }()
    
    private var Addresslabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "الظهرة , بلوك 2"
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16 , weight: .thin)
        label.textColor = .darkGray
        return label
    }()
    
    private var pricelabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "4000$"
        label.textColor = .red
        label.textAlignment = .right
        label.font = .systemFont(ofSize: 16 , weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageViewRequest)
        contentView.addSubview(typelabel)
        contentView.addSubview(pricelabel)
        contentView.addSubview(Addresslabel)
        contentView.backgroundColor = .white
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 10
        applyConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model : DBorder){
        self.Addresslabel.text = "\(model.city),\(model.region)"
        self.pricelabel.text = String(model.cost) + "درهم "
        self.typelabel.text = model.style
        self.imageViewRequest.sd_setImage(with: URL(string: model.chartImage))
    }
    
    private func applyConstraints(){
        let imageViewRequestConstraints = [
            imageViewRequest.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            imageViewRequest.heightAnchor.constraint(equalToConstant: 100),
            imageViewRequest.widthAnchor.constraint(equalToConstant: 100),
            imageViewRequest.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            imageViewRequest.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5)
        ]
  
        let typelabelConstraints = [
            typelabel.topAnchor.constraint(equalTo: imageViewRequest.topAnchor),
            typelabel.trailingAnchor.constraint(equalTo: imageViewRequest.leadingAnchor , constant: -20)
        ]
        let addressLabelConstraints = [
            Addresslabel.topAnchor.constraint(equalTo: typelabel.bottomAnchor , constant: 5),
            Addresslabel.trailingAnchor.constraint(equalTo: typelabel.trailingAnchor)
        ]
        let priceLabelConstraints = [
            pricelabel.topAnchor.constraint(equalTo: Addresslabel.bottomAnchor, constant: 5),
            pricelabel.trailingAnchor.constraint(equalTo: typelabel.trailingAnchor)
        ]
        NSLayoutConstraint.activate(imageViewRequestConstraints)
        NSLayoutConstraint.activate(typelabelConstraints)
        NSLayoutConstraint.activate(addressLabelConstraints)
        NSLayoutConstraint.activate(priceLabelConstraints)

    }

}
