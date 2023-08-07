//
//  ChatVC.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 25/06/23.
//

import UIKit
import Firebase
import AVFoundation

class ChatVC: UIViewController {
    
    private var Screen : ChatScreen?
    private var currentUserID : String?
    private var currentUserName : String?
    private var contact : Contact?
    private var messageList : [Message] = []
    private var messageListener : ListenerRegistration?
    private var auth = Auth.auth()
    private var db = Firestore.firestore()
    private var contactName : String?
    
    override func viewWillAppear(_ animated: Bool) {
        addListenerRequestMessage()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.messageListener?.remove()
    }
    
    override func loadView() {
        Screen = ChatScreen()
        view = Screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Screen?.configTableViewDelegate(datasource: self, delegate: self)
        Screen?.setDelegateChatNavView(controller: self)
        Screen?.delegate(delegate: self)
        requestCurrentUserData()
    }
    
    @objc func tappedBackButton(){
        self.navigationController?.popToRootViewController(animated: true)
        Screen?.inputMessageTextField.resignFirstResponder()
    }
    
    private func saveMessage(DestinyID: String, SenderID: String, message : Dictionary<String,Any>){
        self.db.collection("message").document(DestinyID).collection(SenderID).addDocument(data: message)
        
    }
    
    private func saveConversation(SenderID: String, DestinyID: String, conversation: [String :Any]) {
        self.db.collection("conversation").document(SenderID).collection("LastConversations").document(DestinyID).setData(conversation)
    }
    
    func addListenerRequestMessage(){ 
        if let DestinyID = self.contact?.id{
            self.messageListener = db.collection("message").document(self.currentUserID ?? "").collection(DestinyID).order(by: "data", descending: true).addSnapshotListener({ querySnapShot, error in
                self.messageList.removeAll()
                if let snapShot = querySnapShot {
                    for document in snapShot.documents{
                        let data = document.data()
                        self.messageList.append(Message(dicionary: data) )
                    }
                    self.Screen?.reloadTableView()
                }
            })
        }
    }
    
    private func requestCurrentUserData(){
        if let id = auth.currentUser?.uid {
            self.currentUserID = id
        }
        
        let user =  db.collection("user").document(self.currentUserID ?? "")
        user.getDocument { snapShotData, error in
            if error == nil{
                let data : Contact = Contact(dicionary: snapShotData?.data() ?? [:])
                self.currentUserName = data.name ?? ""
            }
        }
        
        if let name = self.contact?.name{
            self.contactName = name
        }
        
    }
    
    public func setupContactData(contact: Contact){
        self.contact = contact
    }
    
    
}

extension ChatVC : ChatScreenProtocol {
    func tappedPushMessage() {
        let messageText = self.Screen?.inputMessageTextField.text ?? ""
        if let destinyID = self.contact?.id {
            let message : Dictionary<String,Any> = [
                "UserId" : self.currentUserID ?? "",
                "text" :messageText,
                "data" : FieldValue.serverTimestamp()
            ]
            self.saveMessage(DestinyID: destinyID, SenderID: self.currentUserID ?? " ", message: message)
            self.saveMessage(DestinyID: self.currentUserID ?? "", SenderID: destinyID, message: message)
            
            var conversation : [String:Any] = ["last_Message":messageText]

            conversation["SenderID"] = currentUserID ?? ""
            conversation[ "DestinyID"] = destinyID
            conversation["userName"] = self.contactName ?? ""
            self.saveConversation(SenderID: self.currentUserID ?? "" , DestinyID: destinyID, conversation: conversation)
           
            conversation["SenderID"] = destinyID
            conversation[ "DestinyID"] = self.currentUserID ?? ""
            conversation["userName"] = self.currentUserName ?? ""
            self.saveConversation(SenderID: destinyID, DestinyID: self.currentUserID ?? "", conversation: conversation)
        }
        
    }
    
    
}

extension ChatVC : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.messageList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          
        let indice = indexPath.row
        let data = self.messageList[indice]
        let destinyID = data.idUser ?? ""
        
        if self.currentUserID != destinyID{
            let cell = tableView.dequeueReusableCell(withIdentifier: IncomingTextMessageTVC.identifier, for: indexPath) as? IncomingTextMessageTVC
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)
            cell?.selectionStyle = .none
            cell?.setupCell(message: data)
            return cell ?? UITableViewCell()
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: OutgoingTextMessageTVC.identifier, for: indexPath) as? OutgoingTextMessageTVC
            cell?.setupCell(message: data)
            cell?.transform = CGAffineTransform(scaleX: 1, y: -1)

            cell?.selectionStyle = .none
            return cell ?? UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let desc : String = self.messageList[indexPath.row].message ?? ""
        let font = UIFont(name: CustomFont.poppinsSemiBold, size: 14) ?? UIFont()
        let estimetedHeight = desc.heightwithConstrainedWidth(width: 220, font: font)
        return 65 + estimetedHeight
    }
    
    
}
