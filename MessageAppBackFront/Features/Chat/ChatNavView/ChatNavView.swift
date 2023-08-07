//
//  ChatNavView.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 25/06/23.
//

import UIKit

class ChatNavView: UIView {

    var controller : ChatVC? {
        didSet{
            self.backButton.addTarget(controller, action: #selector(controller?.tappedBackButton), for: .touchUpInside)
        }
    }
    
    lazy var navBackGroundView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.05).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 10)
        view.layer.shadowOpacity = 1
        view.layer.shadowRadius = 10
        return view
    }()
    
    lazy var navBar : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var searchBar : UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appLight
        view.clipsToBounds = true
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var searchLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Digite aqui"
        label.font = UIFont(name: CustomFont.poppinsMedium, size: 16)
        label.textColor = .lightGray
        return label
    }()
    
    lazy var searchButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "search"), for: .normal)
        return btn
    }()
      
    lazy var backButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        return btn
    }()
    
    lazy var customImage : UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = 26
        image.image = UIImage(named: "perfil-image")
        return image
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
        addSubview(navBackGroundView)
        navBackGroundView.addSubview(navBar)
        navBar.addSubview(searchBar)
        navBar.addSubview(backButton)
        navBar.addSubview(customImage)
        searchBar.addSubview(searchLabel)
        searchBar.addSubview(searchButton)
    }
    
    private func configContraints(){
        NSLayoutConstraint.activate([
            navBackGroundView.topAnchor.constraint(equalTo: topAnchor),
            navBackGroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBackGroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBackGroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            navBar.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            navBar.leadingAnchor.constraint(equalTo: leadingAnchor),
            navBar.trailingAnchor.constraint(equalTo: trailingAnchor),
            navBar.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            backButton.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 50),
            backButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 30),
            backButton.widthAnchor.constraint(equalToConstant: 30),
            
            customImage.leadingAnchor.constraint(equalTo: backButton.trailingAnchor, constant: 20),
            customImage.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            customImage.heightAnchor.constraint(equalToConstant: 55),
            customImage.widthAnchor.constraint(equalToConstant: 55),
            
            searchBar.leadingAnchor.constraint(equalTo: customImage.trailingAnchor, constant: 20),
            searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            searchLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 25),
            searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor,constant:-20),
            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 20),
            searchButton.heightAnchor.constraint(equalToConstant: 20)
            
            
            
            

        ])
    }
}
