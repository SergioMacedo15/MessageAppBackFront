//
//  LastetMessageCVCScreen.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 25/06/23.
//

import UIKit

class LastetMessageCVCScreen: UIView {

    
    lazy var ImageView : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "person.badge.plus")
        image.clipsToBounds = true
        image.contentMode = .scaleToFill
        return image
    }()
    
    lazy var userNameLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.text = "Adicione um novo Contato"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addElementes()
        configContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElementes(){
        addSubview(ImageView)
        addSubview(userNameLabel)
    }
    
    private func configContraints(){
        NSLayoutConstraint.activate([
            ImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 30),
            ImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            ImageView.widthAnchor.constraint(equalToConstant: 55),
            ImageView.heightAnchor.constraint(equalToConstant: 55),
            
            userNameLabel.leadingAnchor.constraint(equalTo: ImageView.trailingAnchor, constant: 15),
            userNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            userNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }

}
