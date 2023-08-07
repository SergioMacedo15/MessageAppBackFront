//
//  ChatScreen.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 25/06/23.
//

import UIKit
import AVFoundation

protocol ChatScreenProtocol: AnyObject {
    func tappedPushMessage()
}

class ChatScreen: UIView {
    
    private weak var delegate :ChatScreenProtocol?
    private var bottonConstraints:NSLayoutConstraint?
    private var player: AVAudioPlayer?

    public func delegate(delegate :ChatScreenProtocol?){
        self.delegate = delegate
    }
    
    lazy var ChatNav : ChatNavView = {
        let view = ChatNavView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var tableView : UITableView = {
        let tv = UITableView()
        tv.translatesAutoresizingMaskIntoConstraints = false
        //MARK: REGISTER MISSING
        tv.register(OutgoingTextMessageTVC.self, forCellReuseIdentifier: OutgoingTextMessageTVC.identifier)
        tv.register(IncomingTextMessageTVC.self, forCellReuseIdentifier: IncomingTextMessageTVC.identifier)
        tv.backgroundColor = .none
        tv.transform = CGAffineTransform(scaleX: 1, y: -1)
        tv.separatorStyle = .none
        tv.tableFooterView = UIView()
        return tv
    }()
    
    public func configTableViewDelegate(datasource: UITableViewDataSource, delegate: UITableViewDelegate){
        tableView.dataSource = datasource
        tableView.delegate = delegate
    }
    
    public func reloadTableView(){
        tableView.reloadData()
    }
    
    lazy var messageInputView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        return view
    }()
  
    lazy var sendButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = CustomColor.appPink
        btn.layer.cornerRadius = 22.5
        btn.layer.shadowColor = CustomColor.appLight.cgColor
        btn.layer.shadowRadius = 10
        btn.titleLabel?.shadowOffset = CGSize(width: 0, height: 5)
        btn.layer.shadowOpacity = 0.3
        btn.addTarget(self, action: #selector(tappedSendButton), for: .touchUpInside)
        btn.setImage(UIImage(named: "send"), for: .normal)
        return btn
    }()
     
    @objc func tappedSendButton(){
        sendButton.touchAnimation(s: self.sendButton)
        self.playSound()
        self.delegate?.tappedPushMessage()
        initialSendButtonConfig()
    }
    private func initialSendButtonConfig(){
        self.sendButton.isEnabled = false
        self.inputMessageTextField.text = ""
        self.sendButton.layer.opacity = 0.4
        self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
        self.inputMessageTextField.becomeFirstResponder()
    }
    
    lazy var messageBar: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = CustomColor.appLight
        view.layer.cornerRadius = 20
        return view
    }()
    
    lazy var inputMessageTextField: UITextField = {
        let tf = UITextField()
        tf.delegate = self
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.placeholder = "Digite aqui"
        tf.font = UIFont(name: CustomFont.poppinsSemiBold, size: 14)
        tf.textColor = .darkGray
        return tf
    }()
    
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        addElementes()
        configContraints()
        backgroundColor = .white
        animationKeyboard()
        initialConfigsChatView()
        initialSendButtonConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setDelegateChatNavView(controller: ChatVC){
        self.ChatNav.controller = controller
    }
     
    private func initialConfigsChatView(){
        self.inputMessageTextField.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: UIControl.Event.editingChanged)
        self.bottonConstraints = NSLayoutConstraint(item: self.messageInputView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraint(bottonConstraints ?? NSLayoutConstraint())
    }
    
    private func animationKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    private func addElementes(){
        addSubview(ChatNav)
        addSubview(tableView)
        addSubview(messageInputView)
        messageInputView.addSubview(messageBar)
        messageBar.addSubview(inputMessageTextField)
        messageBar.addSubview(sendButton)
    }
    
    private func playSound() {
        guard let url = Bundle.main.url(forResource: "send", withExtension: "wav") else { return }
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
            self.player = try AVAudioPlayer(contentsOf: url, fileTypeHint: AVFileType.wav.rawValue)
            guard let player = self.player else { return }
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func configContraints(){
        NSLayoutConstraint.activate([
            ChatNav.topAnchor.constraint(equalTo: self.topAnchor),
            ChatNav.trailingAnchor.constraint(equalTo: trailingAnchor),
            ChatNav.leadingAnchor.constraint(equalTo: leadingAnchor),
            ChatNav.heightAnchor.constraint(equalToConstant: 140),
            
            tableView.topAnchor.constraint(equalTo: ChatNav.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: messageInputView.topAnchor),
            
            messageInputView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            messageInputView.leadingAnchor.constraint(equalTo: leadingAnchor),
            messageInputView.trailingAnchor.constraint(equalTo: trailingAnchor),
            messageInputView.heightAnchor.constraint(equalToConstant: 80),
            
            messageBar.leadingAnchor.constraint(equalTo: messageInputView.leadingAnchor, constant: 20),
            messageBar.trailingAnchor.constraint(equalTo: messageInputView.trailingAnchor, constant: -20),
            messageBar.heightAnchor.constraint(equalToConstant: 55),
            messageBar.centerYAnchor.constraint(equalTo: messageInputView.centerYAnchor),
            
            sendButton.trailingAnchor.constraint(equalTo: messageBar.trailingAnchor, constant: -15),
            sendButton.heightAnchor.constraint(equalToConstant: 55),
            sendButton.widthAnchor.constraint(equalToConstant: 55),
            sendButton.bottomAnchor.constraint(equalTo: messageBar.bottomAnchor, constant: -10),
            
            inputMessageTextField.leadingAnchor.constraint(equalTo: messageBar.leadingAnchor, constant: 20),
            inputMessageTextField.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: -5),
            inputMessageTextField.heightAnchor.constraint(equalToConstant: 45),
            inputMessageTextField.centerYAnchor.constraint(equalTo: messageBar.centerYAnchor)
            
        ])
    }
}

extension ChatScreen:UITextFieldDelegate {
    
    @objc func handleKeyboardNotification(notification: NSNotification){
        
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            
            let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
            
            self.bottonConstraints?.constant = isKeyboardShowing ? -keyboardHeight : 0
            
            self.tableView.center.y = isKeyboardShowing ? self.tableView.center.y-keyboardHeight : self.tableView.center.y+keyboardHeight
            
            UIView.animate(withDuration:0.1, delay: 0 , options: .curveEaseOut , animations: {
                self.layoutIfNeeded()
            } , completion: {(completed) in
                //Config!!!!!
            })
        }
    }
    
    //MARK:- Animating
    @objc func textFieldDidChange(_ textField: UITextField) {
        if self.inputMessageTextField.text == ""{
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendButton.isEnabled = false
                self.sendButton.layer.opacity = 0.4
                self.sendButton.transform = .init(scaleX: 0.8, y: 0.8)
            }, completion: { _ in
            })
        }
        else {
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                self.sendButton.isEnabled = true
                self.sendButton.layer.opacity = 1
                self.sendButton.transform = .identity
            }, completion: { _ in
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}
