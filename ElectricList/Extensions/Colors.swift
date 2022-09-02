//
//  Colors.swift
//  ElectricList
//
//  Created by Denis Polishchuk on 19.07.2022.
//

import UIKit

extension UIColor {
    static let myBlue = UIColor(red: 0 / 255, green: 87 / 255, blue: 184 / 255, alpha: 1)
    static let myYellow = UIColor(red: 255 / 255, green: 215 / 255, blue: 0 / 255, alpha: 1)
    static let myRed = UIColor(red: 187 / 255, green: 29 / 255, blue: 36 / 255, alpha: 1)
    
    static var background: UIColor {
        if UserDefaultsManager.shared.isSecondTheme == true {
            return myRed
        } else {
            return myBlue
        }
    }
    
    static var text: UIColor {
        if UserDefaultsManager.shared.isSecondTheme == true {
            return .black
        } else {
            return myYellow
        }
    }
}

