//
//  LastetMessageCVC.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 25/06/23.
//

import UIKit

class MessageDetailsCVC: UICollectionViewCell {
    
    static var identifier : String = String(describing: MessageDetailsCVC.self)
    
    lazy var Screen : MessageDetailsCVCScreen = {
        let view = MessageDetailsCVCScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        addSubview(Screen)
    }
    
    private func configContraints(){
        Screen.pin(to: self)
    }
    
    public func setupViewContact(contact : Contact){
        setUserName(userName: contact.name ?? " ")
    }
    
    public func setupViewMessage(conversation: Conversation){
        setUserAttributedText(conversation: conversation)
    }
    
    private func setUserName (userName:String) {
        let attributText = NSMutableAttributedString(
        string: userName,
        attributes:[
                NSAttributedString.Key.font : UIFont (name: CustomFont.poppinsMedium, size: 16) ?? UIFont(),
                NSAttributedString.Key.foregroundColor:UIColor.darkGray
        ])
        self.Screen.userNameLabel.attributedText = attributText
    }
    
    private func setUserAttributedText(conversation: Conversation) {
        let attributText = NSMutableAttributedString(
            string: "\(conversation.name ?? "" )",
            attributes:[
                NSAttributedString.Key.font : UIFont (name: CustomFont.poppinsMedium, size: 16) ?? UIFont(),
                NSAttributedString.Key.foregroundColor:UIColor.darkGray
            ])
        attributText.append(
            NSAttributedString(
                string: "\n\(conversation.lastMessage ?? "")",
                attributes: [
                    NSAttributedString.Key.font : UIFont(name: CustomFont.poppinsMedium, size: 14) ?? UIFont(),
                    NSAttributedString.Key.foregroundColor: UIColor.lightGray
                ]))
        self.Screen.userNameLabel.attributedText = attributText
    }
}
