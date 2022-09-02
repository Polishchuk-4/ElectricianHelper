//
//  UserInfoVC.swift
//  ElectricList
//
//  Created by Denis Polishchuk on 23.07.2022.
//

import UIKit

class SettingUser: UIViewController {
    var aboveNameLabel: UILabel!
    var nameTextField: UITextField!
    var backgroundColorLabel: UILabel!
    var colorLabel: UILabel!
    var switc_h: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.createAboveNameLabel()
        self.createNameTextField()
        self.createBackgroundColorLabel()
        self.createColorLabel()
        self.createSwitc_h()
    }
    
    private func createAboveNameLabel() {
        self.aboveNameLabel = UILabel()
        self.aboveNameLabel.frame.size = CGSize(width: 100, height: 30)
        self.aboveNameLabel.frame.origin = CGPoint(x: CGFloat.offset, y: 50)
        self.aboveNameLabel.text = "User name"
        self.aboveNameLabel.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        self.aboveNameLabel.textAlignment = .left
        self.view.addSubview(self.aboveNameLabel)
    }
    
    private func createNameTextField() {
        self.nameTextField = UITextField()
        self.nameTextField.frame.size = CGSize(width: UIScreen.main.bounds.width - CGFloat.offset * 2, height: 50)
        self.nameTextField.frame.origin.x = CGFloat.offset
        self.nameTextField.frame.origin.y = self.aboveNameLabel.frame.origin.y + self.aboveNameLabel.frame.height
        self.nameTextField.layer.borderWidth = 3
        self.nameTextField.layer.borderColor = UIColor.black.cgColor
        self.nameTextField.placeholder = "..."
        self.nameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: self.nameTextField.frame.height / 2, height: 0))
        self.nameTextField.leftViewMode = .always
        self.view.addSubview(self.nameTextField)
        self.nameTextField.delegate = self
        self.nameTextField.text = UserDefaultsManager.shared.userName
    }
    
    private func createBackgroundColorLabel() {
        self.backgroundColorLabel = UILabel()
        self.backgroundColorLabel.frame.size = CGSize(width: 150, height: 30)
        self.backgroundColorLabel.frame.origin.x = CGFloat.offset
        self.backgroundColorLabel.frame.origin.y = self.nameTextField.frame.origin.y + self.nameTextField.frame.height
        self.backgroundColorLabel.text = "Bacground color"
        self.backgroundColorLabel.font = self.aboveNameLabel.font
        self.view.addSubview(self.backgroundColorLabel)
    }
    
    private func createColorLabel() {
        self.colorLabel = UILabel()
        self.colorLabel.frame.size = CGSize(width: 200, height: 50)
        self.colorLabel.frame.origin.x = CGFloat.offset
        self.colorLabel.frame.origin.y = self.backgroundColorLabel.frame.origin.y + self.backgroundColorLabel.frame.height
        self.colorLabel.text = "Ukraine/OUN"
        self.colorLabel.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(self.colorLabel)
    }
    
    private func createSwitc_h() {
        self.switc_h = UISwitch()
        self.switc_h.frame.origin.x = self.view.frame.width - self.switc_h.frame.width - CGFloat.offset
        self.switc_h.frame.origin.y = self.colorLabel.frame.origin.y + 10
        self.view.addSubview(self.switc_h)
        self.switc_h.isOn = UserDefaultsManager.shared.isSecondTheme
        self.switc_h.addTarget(self, action: #selector(changeTheme), for: .touchUpInside)
    }
    
    @objc private func changeTheme() {
        if UserDefaultsManager.shared.isSecondTheme == false {
            UserDefaultsManager.shared.isSecondTheme = true
        } else {
            UserDefaultsManager.shared.isSecondTheme = false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.dismiss(animated: true)
    }
}

//MARK: - TextFieldDelegate -
extension SettingUser: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        UserDefaultsManager.shared.userName = textField.text!
    }
}
