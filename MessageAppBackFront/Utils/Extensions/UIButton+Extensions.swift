//
//  UIButton + Extensions.swift
//  WeatherTrip
//
//  Created by Sergio Silva Macedo on 18/06/23.
//

import UIKit

extension UIButton {
  
    func touchAnimation (s: UIButton) {
        UIView.animate(withDuration: 0.1, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options:.curveEaseInOut, animations: {
                    s.transform = CGAffineTransform(scaleX: 0.80, y: 0.80)
                }, completion: { finish in UIButton.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    s.transform = .identity
                })
                })
    }
}

