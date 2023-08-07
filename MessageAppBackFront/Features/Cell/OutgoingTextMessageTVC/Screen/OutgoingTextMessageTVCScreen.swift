//
//  IncomingTextMessageTVCScreen.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 26/06/23.
//

import UIKit

class OutgoingTextMessageTVCScreen: UIView {
    
    lazy var myMessage:UIView = {
        let bv = UIView()
        bv.translatesAutoresizingMaskIntoConstraints = false
        bv.backgroundColor = CustomColor.appPurple
        bv.layer.cornerRadius = 20
        bv.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return bv
    }()
    
    lazy var messageTextLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
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
        addSubview(myMessage)
        myMessage.addSubview(messageTextLabel)
    }
    
    private func configContraints(){
        NSLayoutConstraint.activate([
            
            myMessage.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            myMessage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            myMessage.widthAnchor.constraint(lessThanOrEqualToConstant: 250),
            
            messageTextLabel.topAnchor.constraint(equalTo: myMessage.topAnchor, constant:15),
            messageTextLabel.leadingAnchor.constraint(equalTo: myMessage.leadingAnchor, constant:15),
            messageTextLabel.trailingAnchor.constraint(equalTo: myMessage.trailingAnchor, constant: -15),
            messageTextLabel.bottomAnchor.constraint(equalTo: myMessage.bottomAnchor, constant: -15)
        ])
    }
}
