//
//  ViewController.swift
//  WeatherTrip
//
//  Created by Sergio Silva Macedo on 14/06/23.
//

import UIKit

class CreateVC: UIViewController {

    private var Screen : CreateScreen?
    private var viewModel : CreateViewModel = CreateViewModel()
    
    override func loadView() {
        Screen = CreateScreen()
        view = Screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Screen?.delegate(delegate: self)
        Screen?.configTextFieldDelegate(delegate: self)
        viewModel.delegate(delegate: self)
    }


}

extension CreateVC: CreateViewModelProtocol {
    func Sucess() {
        Alert(controller: self).showAlertInformation(title: "Sucesso", message: "Cadastro realizado com sucesso"){
            result in
            if result {
                self.dismiss(animated: true)
            }
        }
    }
    
    func Failure(_ mensage: String) {
        Alert(controller: self).showAlertInformation(title: "Ops, Houve um erro", message: mensage)
    }

}

extension CreateVC : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Screen?.registerButton.isEnabled =  viewModel.validateDataTextField(name: Screen?.nameTextField.text ?? "" ,email: Screen?.emailTextField.text ?? " ", password: Screen?.passwordTextField.text ?? " ")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
    }
}

extension CreateVC : CreateScreenProtocol {
    func tappedCancelButton() {
        Alert(controller: self).showAlertOption(title: "Cancelar Cadastro", message: "Deseja realmente cancelar o cadastro ?"){ result in
            if result {
                self.dismiss(animated: true)
            }
            
        }
    }
    
    func tappedRegisterButton() {
        viewModel.createAccount(name: Screen?.nameTextField.text ?? "" ,email: Screen?.emailTextField.text ?? " ", password: Screen?.passwordTextField.text ?? " ")
    }
}
