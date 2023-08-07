//
//  LoginViewModel.swift
//  WeatherTrip
//
//  Created by Sergio Silva Macedo on 14/06/23.
//

import UIKit
import FirebaseAuth
import Firebase

protocol LoginViewModelProtocol: AnyObject {
    func Sucess()
    func Failure(message: String)
}


class LoginViewModel {
    
    private var auth = Auth.auth()
    private weak var delegate : LoginViewModelProtocol?
    private var db = Firestore.firestore()
    
    public func delegate(delegate : LoginViewModelProtocol?){
        self.delegate = delegate
    }
    
    public func loginAccount(email: String, password: String){
        auth.signIn(withEmail: email, password: password, completion: { result , Error in
            if Error == nil {
                print(result ?? "")
                self.delegate?.Sucess()
            } else {
                self.delegate?.Failure(message: Error?.localizedDescription ?? " ")
                print(Error ?? "")
            }
        })
    }
    
    public func validateDataTextField(email: String, password: String) -> Bool{
        if (email.isEmpty || password.isEmpty ) {
            return false
        } else {
            return true
        }
    }
    
    // Request Change Password link
    
    
    public func requestPasswordLink(controller: UIViewController){
        auth.sendPasswordReset(withEmail: "Sergios.macedo15@gmail.com") { error in
            if error == nil {
                Alert(controller: controller).showAlertInformation(title: "Envia", message: "Email para resetar sua senha foi envaido, verifique sua caixa de entrada")
            }
        }
    }
    
    
    
}
