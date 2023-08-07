//
//  HomeVC.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 24/06/23.
//

import UIKit
import Firebase

class HomeVC: UIViewController {
    
    private var auth:Auth = Auth.auth()
    private var db:Firestore = Firestore.firestore()
    
    private var screenContact:Bool? = false
    
    private var currentUserId:String?
    private var currentUseremail: String?
    
    private var alert:Alert?
    
    private var Screen : HomeScreen?
    
    private var contactController: ContactController = ContactController()
    private var contactList: [Contact] = []
    private var conversationList : [Conversation] = []
    private var conversationListener: ListenerRegistration?
    
    
    override func loadView() {
        Screen = HomeScreen()
        view = Screen
        self.navigationController?.navigationBar.isHidden = true
        view.backgroundColor = CustomColor.appLight
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.alert = Alert(controller: self)
        Screen?.configColletionView(datasource: self, delegate: self)
        Screen?.navVIew.delegate(delegate: self)
        contactController.delegate(delegate:self)
        getCurrentUser()
        addlisternerConversation()
        
    }
    
    private func getCurrentUser(){
        if let currentUser = auth.currentUser {
            self.currentUserId = currentUser.uid
            self.currentUseremail = currentUser.email
        }
    }
    
    private func reloadContactList(){
        contactList.removeAll()
        db.collection("user").document(currentUserId ?? "").collection("contacts").getDocuments { snapShotResult, error in
            if error != nil {
                self.alert?.showAlertOption(title: "Ops, houve um erro", message: error?.localizedDescription ?? "")
            }
            if let snapShot = snapShotResult {
                for document in snapShot.documents {
                    let contacts = document.data()
                    self.contactList.append(Contact(dicionary: contacts))
                }
                self.Screen?.reloadData()
            }
        }
    }
    
    private func addlisternerConversation(){
        if let currentUserID = auth.currentUser?.uid {
            self.conversationListener = db.collection("conversation").document(currentUserID).collection("LastConversations").addSnapshotListener(
                {querySnapShot, error in
                    if error == nil {
                        self.conversationList.removeAll()
                        if let snapShot = querySnapShot {
                            for document in snapShot.documents {
                                let data = document.data()
                                self.conversationList.append(Conversation(dicionary: data))
                            }
                            self.Screen?.reloadData()
                        }
                    }
                })
        }
    }
}

extension HomeVC : NavigationViewProtocol {

    func typeScreenMessage(type: typeScreenHome) {
        
        switch type {
        case .Contact:
            self.screenContact = true
            self.reloadContactList()
            self.conversationListener?.remove()
        case .Conversation:
            self.screenContact = false
            addlisternerConversation()
            self.Screen?.reloadData()
        }
    }
}

extension HomeVC : ContactControllerProtocol {
    func alertStateError(titulo: String, message: String) {
        alert?.showAlertOption(title: titulo, message: message)
    }
    
    func sucessContact() {
        alert?.showAlertOption(title: "Sucesso", message: "Usuário Cadastrado"){_ in
            self.reloadContactList()
        }
    }
}


extension HomeVC : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if self.screenContact ?? false {
            return self.contactList.count + 1
        }else {
            return self.conversationList.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if self.screenContact ?? false {
            
            if indexPath.row == self.contactList.count {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastetMessageCVC.identifier, for: indexPath) as?  LastetMessageCVC
                return cell ?? UICollectionViewCell()
                
            }else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailsCVC.identifier, for: indexPath) as?  MessageDetailsCVC
                cell?.setupViewContact(contact: contactList[indexPath.row])
                return  cell ?? UICollectionViewCell()
            }
            
        }else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MessageDetailsCVC.identifier, for: indexPath) as?  MessageDetailsCVC
            cell?.setupViewMessage(conversation: self.conversationList[indexPath.row])
            return cell ?? UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if self.screenContact ?? false {
            if indexPath.row == self.contactList.count {
                self.alert?.addContact(completion:
                                        { value in
                    self.contactController.addContact(email: value, emailcurrentUser: self.currentUseremail ?? "", idUser: self.currentUserId ?? "")
                })
            } else {
                let vc = ChatVC()
                vc.setupContactData(contact: self.contactList[indexPath.row])
                vc.modalPresentationStyle = .fullScreen
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }else {
            let vc = ChatVC()
            let data = self.conversationList[indexPath.row]
            let contact = Contact(id: data.idDestiny ?? "", name: data.name ?? "")
            vc.setupContactData(contact: contact)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
