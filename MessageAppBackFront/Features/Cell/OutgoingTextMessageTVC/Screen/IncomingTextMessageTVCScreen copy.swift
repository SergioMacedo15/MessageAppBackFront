//
//  IncomingTextMessageTVCScreen.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 26/06/23.
//

import UIKit

class IncomingTextMessageTVCScreen: UIView {
    
    lazy var contactMessage:UIView = {
        let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.backgroundColor = UIColor(white: 0, alpha: 0.06)
        bv.layer.cornerRadius = 20
        bv.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMinYCorner , .layerMaxXMinYCorner]
        return bv
    }()
    
    lazy var messageTextLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .darkGray
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 14)
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
        addSubview(contactMessage)
        contactMessage.addSubview(messageTextLabel)
    }
    
    private func configContraints(){
        NSLayoutConstraint.activate([
            
            contactMessage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            contactMessage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            contactMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messageTextLabel.topAnchor.constraint(equalTo: contactMessage.topAnchor, constant:15),
            messageTextLabel.leadingAnchor.constraint(equalTo: contactMessage.leadingAnchor, constant:15),
            messageTextLabel.trailingAnchor.constraint(equalTo: contactMessage.trailingAnchor, constant: -15),
            messageTextLabel.bottomAnchor.constraint(equalTo: contactMessage.bottomAnchor, constant: -15)
        ])
    }
}
