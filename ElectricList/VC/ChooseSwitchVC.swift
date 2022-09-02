//
//  ChooseSwitchVC.swift
//  ElectricList
//
//  Created by Denis Polishchuk on 20.08.2022.
//

import UIKit

class ChooseSwitchVC: SwitchesListVC {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelVC))
        self.navigationItem.title = "Choose switch"
    }
    
    @objc private func cancelVC() {
        self.dismiss(animated: true)
    }
}
