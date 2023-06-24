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
}
