//
//  Alert.swift
//  BF_NFT_App
//
//  Created by Sergio Silva Macedo on 05/06/23.
//

import UIKit

class Alert {
    
    private var controller : UIViewController
    
    init(controller: UIViewController) {
        self.controller = controller
    }
    
    public func showAlertInformation(title: String, message: String , completion: ((_ : Bool) -> Void)? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            completion?(true)
        }
        alertController.addAction(ok)
        self.controller.present(alertController, animated: true)
    }
    
    public func showAlertOption(title: String, message: String, completion : ((Bool)-> Void)? = nil){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "Ok", style: .default) { action in
            completion?(true)
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { action in
            completion?(false)
        }
        alertController.addAction(ok)
        alertController.addAction(cancel)
        self.controller.present(alertController, animated: true)
    }
    
    func addContact(completion:((_ value:String) -> Void)? = nil){
        var _textField:UITextField?
      
        let alert = UIAlertController(title: "Adicionar Usuario", message: "Digite uma email Valido", preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "Adicionar", style: .default) { (acao) in
            completion?(_textField?.text ?? "")
        }
        let cancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
        
        alert.addAction(cancel)
        alert.addAction(ok)
        alert.addTextField(configurationHandler: {(textField: UITextField) in
            _textField = textField
            textField.placeholder = "Email:"
        })
        self.controller.present(alert, animated: true, completion: nil)
    }
}
