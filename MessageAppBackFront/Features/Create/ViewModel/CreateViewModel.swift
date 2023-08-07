//
//  LoginViewModel.swift
//  WeatherTrip
//
//  Created by Sergio Silva Macedo on 14/06/23.
//

import UIKit
import Firebase

protocol CreateViewModelProtocol: AnyObject {
    func Sucess()
    func Failure(_ mensage: String)
}


class CreateViewModel {
    
    private var auth = Auth.auth()
    private var firestore = Firestore.firestore()
    private var currentUser : [String] = []
    private weak var delegate : CreateViewModelProtocol?
    
    public func delegate(delegate : CreateViewModelProtocol?){
        self.delegate = delegate
    }
    
    public func createAccount(name: String, email: String, password: String){
        auth.createUser(withEmail: email, password: password, completion: { result , Error in
            if Error == nil {
                print(result ?? "")
                if let idUser = result?.user.uid{
                    self.firestore.collection("user").document(idUser).setData([
                        "name": name,
                        "email": email,
                        "id":idUser
                    ])
                }
                self.delegate?.Sucess()
            } else {
                self.delegate?.Failure(Error?.localizedDescription ?? "")
            }
        })
    }
    

    public func validateDataTextField(name: String, email: String, password: String) -> Bool{
        if (email.isEmpty || password.isEmpty || name.isEmpty) {
            return false
        } else {
            return true
        }
    }
    
}
