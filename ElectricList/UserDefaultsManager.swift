//
//  UserDefaultsManager.swift
//  ElectricList
//
//  Created by Denis Polishchuk on 19.07.2022.
//

import UIKit

class UserDefaultsManager {
    static let shared = UserDefaultsManager()
    
    private var userNameKey = ""
    var userName: String {
        get {
            return UserDefaults.standard.string(forKey: userNameKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: userNameKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    private let isSecondThemeKey = "isSecondTheme"
    var isSecondTheme: Bool {
        get {
            return UserDefaults.standard.bool(forKey: isSecondThemeKey)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isSecondThemeKey)
            UserDefaults.standard.synchronize()
        }
    }
    
    private let sizeImgViewKey = "sizeImgView"
    var sizeImgView: String {
        get {
            return UserDefaults.standard.string(forKey: sizeImgViewKey) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: sizeImgViewKey)
            UserDefaults.standard.synchronize()
        }
    }
}

