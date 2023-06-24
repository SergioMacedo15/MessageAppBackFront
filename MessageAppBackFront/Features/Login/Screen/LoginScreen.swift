//
//  LoginScreen.swift
//  WeatherTrip
//
//  Created by Sergio Silva Macedo on 14/06/23.
//

import UIKit
protocol LoginScreenProtocol : NSObject{
    func tappedLoginButton()
    func tappedRegisterButton()
    func tappedRequestButton()
}

class LoginScreen: UIView {
    
    private weak var delegate : LoginScreenProtocol?
    
    public func delegate(delegate : LoginScreenProtocol?){
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
        label.text = "Login"
        return label
    }()
    
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
        label.text = "Password"
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
    
    lazy var requestPasswordButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Recuperar senhar", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.tintColor = .white
        btn.isEnabled = true
        btn.contentHorizontalAlignment = .right
        btn.addTarget(self, action: #selector(tappedRequestButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func tappedRequestButton(){
        delegate?.tappedRequestButton()
    }
    
    lazy var loginButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Entrar", for: .normal)
        btn.backgroundColor = .black.withAlphaComponent(0.7)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.isEnabled = true
        btn.layer.cornerRadius = 8
        btn.titleLabel?.textAlignment = .center
        btn.addTarget(self, action: #selector(tappedLoginButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func tappedLoginButton(){
        delegate?.tappedLoginButton()
    }
    
    lazy var registerButton : UIButton = {
        let btn = UIButton(type: .system)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("Não tem conta, Cadastre-se", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        btn.tintColor = .white
        btn.clipsToBounds = true
        btn.isEnabled = true
        btn.layer.cornerRadius = 8
        btn.addTarget(self, action: #selector(tappedRegisterButton), for: .touchUpInside)
        return btn
    }()
    
    @objc func tappedRegisterButton(){
        delegate?.tappedRegisterButton()
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
        addSubview(emailLabel)
        addSubview(emailTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(requestPasswordButton)
        addSubview(loginButton)
        addSubview(registerButton)
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
            
            emailLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
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
            
            
            requestPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 10),
            requestPasswordButton.trailingAnchor.constraint(equalTo: passwordLabel.trailingAnchor),
            requestPasswordButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            
            loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 50),
            loginButton.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
            loginButton.trailingAnchor.constraint(equalTo: passwordTextField.trailingAnchor),
            loginButton.heightAnchor.constraint(equalToConstant: 35),
            
    
            registerButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 100),
            registerButton.leadingAnchor.constraint(equalTo: loginButton.leadingAnchor),
            registerButton.trailingAnchor.constraint(equalTo: loginButton.trailingAnchor),
            
            
            
        ])
    }
    
    public func configTextFieldDelegate(delegate : UITextFieldDelegate){
        self.emailTextField.delegate = delegate
        self.passwordTextField.delegate = delegate
    }
    
}
