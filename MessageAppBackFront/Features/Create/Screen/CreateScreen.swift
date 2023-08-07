//
//  LoginScreen.swift
//  WeatherTrip
//
//  Created by Sergio Silva Macedo on 14/06/23.
//

import UIKit
protocol CreateScreenProtocol : NSObject{
    func tappedCancelButton()
    func tappedRegisterButton()
}

class CreateScreen: UIView {
    
    private weak var delegate : CreateScreenProtocol?
    
    public func delegate(delegate : CreateScreenProtocol?){
        self.delegate = delegate
    }
    
    lazy var backgroundView : UIImageView = {
        let img = UIImageView()
        img.translatesAutoresizingMaskIntoConstraints = false
        img.image = UIImage(named: "BackgroundLogin")
        img.contentMode = .scaleToFill
        return img
    }()
    lazy var titleLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont (ofSize: 50)
        label.textAlignment = .center
        label.text = "Cadastro"
        return label
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont (ofSize: 14)
        label.text = "Nome"
        return label
    }()
    
    lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.attributedPlaceholder = NSAttributedString(string: "Digite seu Nome", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.7)])
        tf.textColor = .black
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        return tf
    }( )
    
    lazy var emailLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont (ofSize: 14)
        label.text = "Email"
        return label
    }()
    
    lazy var emailTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.attributedPlaceholder = NSAttributedString(string: "Digite seu email", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.7)])
        tf.textColor = .black
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        return tf
    }( )
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel ()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont (ofSize: 14)
        label.text = "Senha"
        return label
    }()
    
    lazy var passwordTextField: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.autocorrectionType = .no
        tf.backgroundColor = .white
        tf.borderStyle = .roundedRect
        tf.keyboardType = .emailAddress
        tf.attributedPlaceholder = NSAttributedString(string: "Digite sua senha", attributes: [NSAttributedString.Key.foregroundColor : UIColor.black.withAlphaComponent(0.7)])
        tf.textColor = .black
        tf.isSecureTextEntry = true
        tf.clipsToBounds = true
        tf.layer.cornerRadius = 12
        tf.layer.borderWidth = 1.0
        tf.layer.borderColor = UIColor.gray.withAlphaComponent(0.5).cgColor
        return tf
    }( )
    
    lazy var registerButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Cadastrar", for: .normal)
        btn.backgroundColor = .black.withAlphaComponent(0.7)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.isEnabled = false
        btn.layer.cornerRadius = 8
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func tappedRegisterButton(){
        delegate?.tappedRegisterButton()
    }
    
    lazy var cancelButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Cancelar cadastro", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.isEnabled = true
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(tappedCancelButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func tappedCancelButton(){
        delegate?.tappedCancelButton()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElementes()
        configContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addElementes(){
        addSubview(backgroundView)
        addSubview(titleLabel)
        addSubview(nameLabel)
        addSubview(nameTextField)
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(registerButton)
        addSubview(cancelButton)
    }
    
    private func configContraints(){
        NSLayoutConstraint.activate([
            
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 30),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25),
            
            nameLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            nameTextField.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10),
            nameTextField.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 35),
            
            emailLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 15),
            emailLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            emailLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 10),
            emailTextField.leadingAnchor.constraint(equalTo: emailLabel.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: emailLabel.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 35),
            
            passwordLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 15),
            passwordLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            passwordLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 10),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: passwordLabel.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 35),
            
            
            registerButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            registerButton.trailingAnchor.constraint(equalTo: passwordLabel.trailingAnchor),
            registerButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            registerButton.heightAnchor.constraint(equalToConstant: 35),
            
            cancelButton.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 20),
            cancelButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            cancelButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            cancelButton.heightAnchor.constraint(equalToConstant: 35),
            
            
        ])
    }
    
    public func configTextFieldDelegate(delegate : UITextFieldDelegate){
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    
}
