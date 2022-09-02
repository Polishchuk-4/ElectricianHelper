//
//  ShowSwitcherVC.swift
//  ElectricList
//
//  Created by Denis Polishchuk on 20.08.2022.
//

import UIKit

class ShowSwitcherVC: UIViewController {
    var imgView: UIImageView!
    var switcher: Switcher!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        self.createImgView()
        self.createDot()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeVC))
        self.navigationItem.title = "Show switch"
    }
    
    @objc private func closeVC() {
        self.dismiss(animated: true)
    }
    
    private func createImgView() {
        self.imgView = UIImageView()
        let size = UserDefaultsManager.shared.sizeImgView
        let components = size.components(separatedBy: " ")
        self.imgView.frame.size.width = (components[0] as NSString).doubleValue
        self.imgView.frame.size.height = (components[1] as NSString).doubleValue
        self.imgView.center = self.view.center
        self.view.addSubview(self.imgView)
        self.imgView.contentMode = .scaleAspectFit
        if let photoData = switcher.photo {
            self.imgView.image = UIImage(data: photoData)
        }
    }
    
    private func createDot() {
        let dot = Dot()
        let position = switcher.centrePoint
        let components = position!.components(separatedBy: " ")
        dot.center.x = (components[0] as NSString).doubleValue
        dot.center.y = (components[1] as NSString).doubleValue
        self.imgView.addSubview(dot)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
}
