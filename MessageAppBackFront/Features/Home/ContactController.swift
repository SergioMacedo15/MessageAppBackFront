//
//  ContactController.swift
//  MessageAppBackFront
//
//  Created by Sergio Silva Macedo on 25/06/23.
//

import Foundation
import UIKit
import FirebaseFirestore

protocol ContactControllerProtocol:AnyObject{
    func alertStateError(titulo: String, message: String)
    func sucessContact()
}

class ContactController {

    private weak var delegate :ContactControllerProtocol?
    private var firestore = Firestore.firestore()
    
    
    public func delegate(delegate :ContactControllerProtocol?){
        self.delegate = delegate
    }
    
    
    public func addContact(email: String, emailcurrentUser: String, idUser: String){
        if email == emailcurrentUser{
            delegate?.alertStateError(titulo: "Ops, houve um erro", message: "Voce adicionou seu própria email")
            return
        }
        firestore.collection("user").whereField("email", isEqualTo: email).getDocuments(completion: { snapShotResult, error in
            
            if let resultCount = snapShotResult?.count{
                if resultCount == 0 {
                    self.delegate?.alertStateError(titulo: "Ops, houve um erro", message: "Usuário não cadastrado")
                    return
                }else {
                    if let snapShotResult = snapShotResult{
                        for documents in snapShotResult.documents{
                            let dados = documents.data()
                            self.setContactData(userData: dados, UserId: idUser)
                            self.delegate?.sucessContact()
                        }
                    }
                }
            }
        })
    }
    
    
    public func setContactData(userData:Dictionary<String,Any>, UserId: String){
        let contact: Contact =  Contact(dicionary: userData)
        firestore.collection("user").document(UserId).collection("contacts").document(contact.id ?? "").setData(userData){
            error in
            if error == nil {
                
            } else {
                self.delegate?.alertStateError(titulo: "Ops, houve um erro", message: error?.localizedDescription ?? "")
            }
        }
    }
    
    
}
