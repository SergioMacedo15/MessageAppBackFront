//
//  IncomingTextMessageTVC.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 26/06/23.
//

import UIKit

class OutgoingTextMessageTVC: UITableViewCell {

    static var identifier : String = String(describing: OutgoingTextMessageTVC.self)
    
    lazy var Screen : OutgoingTextMessageTVCScreen = {
        let view = OutgoingTextMessageTVCScreen()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addElementes()
        configContraints()
        self.isSelected = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElementes(){
        contentView.addSubview(Screen)
    }
    
    private func configContraints(){
        NSLayoutConstraint.activate([
            Screen.topAnchor.constraint(equalTo: topAnchor),
            Screen.leadingAnchor.constraint(equalTo: leadingAnchor),
            Screen.trailingAnchor.constraint(equalTo: trailingAnchor),
            Screen.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
    public func setupCell(message: Message?){
        self.Screen.messageTextLabel.text = message?.message ?? ""
    }

}
