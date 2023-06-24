//
//  ViewController.swift
//  WeatherTrip
//
//  Created by Sergio Silva Macedo on 14/06/23.
//

import UIKit

class LoginVC: UIViewController {

    private var Screen : LoginScreen?
    private var viewModel = LoginViewModel()
    
    override func loadView() {
        Screen = LoginScreen()
        view = Screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Screen?.delegate(delegate: self)
        Screen?.configTextFieldDelegate(delegate: self)
        viewModel.delegate(delegate: self)
        Screen?.emailTextField.text = "Sergio@gmail.com"
        Screen?.passwordTextField.text = "123456"
    }


}

extension LoginVC : LoginScreenProtocol {
    func tappedLoginButton() {
        viewModel.loginAccount(email: Screen?.emailTextField.text ?? " ", password: Screen?.passwordTextField.text ?? "")
    }
    
    func tappedRegisterButton() {
        
    }
    
    func tappedRequestButton() {
        
    }
}

extension LoginVC : UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Screen?.registerButton.isEnabled =  viewModel.validateDataTextField(email: Screen?.emailTextField.text ?? " ", password: Screen?.passwordTextField.text ?? " ")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension LoginVC : LoginViewModelProtocol {
    
    func Sucess() {
    }
    
    func Failure(message : String) {
        Alert(controller: self).showAlertInformation(title: "Ops, Houve um erro", message: message)
    }
}


