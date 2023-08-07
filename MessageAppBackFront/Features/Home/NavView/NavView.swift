//
//  HomeScreen.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 24/06/23.
//

import UIKit

enum typeScreenHome {
    case Conversation
    case Contact
}

protocol NavigationViewProtocol: AnyObject{
    func typeScreenMessage(type: typeScreenHome)
}


class NavigationView: UIView {
    
    weak var delegate :NavigationViewProtocol?
    
    public func delegate(delegate : NavigationViewProtocol?){
        self.delegate = delegate
    }
    
    lazy var navBackGroundView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
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
    
    lazy var conversationButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .systemPink
        btn.addTarget(self, action: #selector(tappedConversationButton), for: .touchUpInside)
        return btn
    }()
    
    lazy var contactButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "group")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(tappedContactButton), for: .touchUpInside)
        return btn
    }()
    
    let stackButton : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    @objc func tappedConversationButton(){
        conversationButton.tintColor = .systemPink
        contactButton.tintColor = .black
        delegate?.typeScreenMessage(type: .Conversation)
    }
    
    @objc func tappedContactButton(){
        conversationButton.tintColor = .black
        contactButton.tintColor = .systemPink
        delegate?.typeScreenMessage(type: .Contact)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElementes()
        configStackView()
        configContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configStackView(){
        stackButton.addArrangedSubview(conversationButton)
        stackButton.addArrangedSubview(contactButton)
    }
    
    private func addElementes(){
        addSubview(navBackGroundView)
        navBackGroundView.addSubview(navBar)
        navBar.addSubview(searchBar)
        navBar.addSubview(stackButton)
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
            
            searchBar.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
            searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: stackButton.leadingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            stackButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -30),
            stackButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            stackButton.widthAnchor.constraint(equalToConstant: 100),
            stackButton.heightAnchor.constraint(equalToConstant: 30),
            
            searchLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 25),
            searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor,constant:-20),
            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 20),
            searchButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
//
//  HomeScreen.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 24/06/23.
//

import UIKit

enum typeScreen {
    case Conversation
    case Contact
}

protocol navViewProtocol: AnyObject{
    func typeScreenMessage(type: typeScreen)
}


class navView: UIView {
    
    weak var delegate :navViewProtocol?
    
    public func delegate(delegate : navViewProtocol?){
        self.delegate = delegate
    }
    
    lazy var navBackGroundView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 35
        view.layer.maskedCorners = [.layerMaxXMaxYCorner]
        view.layer.shadowColor = UIColor(white: 0, alpha: 0.02).cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 5)
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
    
    lazy var conversationButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "message")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .systemPink
        btn.addTarget(self, action: #selector(tappedConversationButton), for: .touchUpInside)
        return btn
    }()
    
    lazy var contactButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(named: "group")?.withRenderingMode(.alwaysTemplate), for: .normal)
        btn.tintColor = .black
        btn.addTarget(self, action: #selector(tappedContactButton), for: .touchUpInside)
        return btn
    }()
    
    let stackButton : UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.spacing = 10
        return stack
    }()
    
    @objc func tappedConversationButton(){
        conversationButton.tintColor = .systemPink
        contactButton.tintColor = .black
        delegate?.typeScreenMessage(type: .Conversation)
    }
    
    @objc func tappedContactButton(){
        conversationButton.tintColor = .black
        contactButton.tintColor = .systemPink
        delegate?.typeScreenMessage(type: .Contact)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElementes()
        configStackView()
        configContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configStackView(){
        stackButton.addArrangedSubview(conversationButton)
        stackButton.addArrangedSubview(contactButton)
    }
    
    private func addElementes(){
        addSubview(navBackGroundView)
        navBackGroundView.addSubview(navBar)
        navBar.addSubview(searchBar)
        navBar.addSubview(stackButton)
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
            
            searchBar.leadingAnchor.constraint(equalTo: navBar.leadingAnchor, constant: 30),
            searchBar.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            searchBar.trailingAnchor.constraint(equalTo: stackButton.leadingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 55),
            
            stackButton.trailingAnchor.constraint(equalTo: navBar.trailingAnchor, constant: -30),
            stackButton.centerYAnchor.constraint(equalTo: navBar.centerYAnchor),
            stackButton.widthAnchor.constraint(equalToConstant: 100),
            stackButton.heightAnchor.constraint(equalToConstant: 30),
            
            searchLabel.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 25),
            searchLabel.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            
            searchButton.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor,constant:-20),
            searchButton.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 20),
            searchButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
}
