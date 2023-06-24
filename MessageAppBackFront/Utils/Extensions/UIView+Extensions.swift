//
//  UIView + Extensions.swift
//  WeatherTrip
//
//  Created by Sergio Silva Macedo on 17/06/23.
//

import UIKit

extension UIView {
    
    func pin(to superView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.topAnchor.constraint (equalTo: superView.topAnchor),
            self.leadingAnchor.constraint (equalTo: superView.leadingAnchor),
            self.bottomAnchor.constraint(equalTo:superView.bottomAnchor),
            self.trailingAnchor.constraint(equalTo:superView.trailingAnchor)
        ])
        
    }
}
