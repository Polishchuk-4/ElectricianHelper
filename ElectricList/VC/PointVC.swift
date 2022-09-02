//
//  PointVC.swift
//  CoreData
//
//  Created by Denis Polishchuk on 19.07.2022.
//

import UIKit

class PointVC: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, SwitchesListVCDelegate {
    var imgView: UIImageView!
    var buttonCamera: UIButton!
    var buttonLibrary: UIButton!
    var textField: UITextField!
    var point: Point!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.background
        self.createImgView()
        self.createbuttonLibrary()
        self.createbuttonCamera()
        self.createTextField()
        self.createButtonListSwitches()
        self.createButtonShowSwitch()
        self.navigationItem.title = "Point"
    }
    
    private func createImgView() {
        self.imgView = UIImageView()
        self.imgView.frame.size.width = (UIScreen.main.bounds.width - CGFloat.offset * 2) / 2.2
        self.imgView.frame.size.height = (UIScreen.main.bounds.width - CGFloat.offset * 2) / 2.2
        self.imgView.center.x = UIScreen.main.bounds.width / 2
        self.imgView.frame.origin.y = self.navigationController!.navigationBar.frame.height + 40 + CGFloat.offset
        self.imgView.layer.borderWidth = 3
        self.imgView.layer.borderColor = UIColor.text.cgColor
        if let photoData = point.photo {
            self.imgView.image = UIImage(data: photoData)
        } else {
            let image = "photo".getSymbol(pointSize: 2, weight: .light)
            self.imgView.image = image
        }
        self.imgView.tintColor = .text
        self.imgView.clipsToBounds = true
        self.view.addSubview(self.imgView)
    }
    
    private func createbuttonLibrary() {
        self.buttonLibrary = UIButton()
        self.buttonLibrary.frame.size.width = UIScreen.main.bounds.width / 2 - CGFloat.offset * 1.5
        self.buttonLibrary.frame.size.height = 50
        self.buttonLibrary.frame.origin.x = CGFloat.offset
        self.buttonLibrary.frame.origin.y = self.imgView.frame.origin.y + self.imgView.frame.height + CGFloat.offset
        self.buttonLibrary.backgroundColor = UIColor.text
        let image = "photo.on.rectangle".getSymbol(pointSize: 40, weight: .light)
        self.buttonLibrary.setImage(image, for: .normal)
        self.buttonLibrary.tintColor = UIColor.background
        self.view.addSubview(self.buttonLibrary)
        self.buttonLibrary.addTarget(self, action: #selector(addImageLibrary), for: .touchUpInside)
    }
    
    @objc private func addImageLibrary() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    private func createbuttonCamera() {
        self.buttonCamera = UIButton()
        self.buttonCamera.frame.size = self.buttonLibrary.frame.size
        self.buttonCamera.frame.origin.x = UIScreen.main.bounds.width / 2 + CGFloat.offset / 2
        self.buttonCamera.frame.origin.y = self.buttonLibrary.frame.origin.y
        self.buttonCamera.backgroundColor = UIColor.text
        let image = "camera.fill".getSymbol(pointSize: 40, weight: .light)
        self.buttonCamera.setImage(image, for: .normal)
        self.buttonCamera.contentMode = .scaleAspectFill
        self.buttonCamera.tintColor = UIColor.background
        self.view.addSubview(self.buttonCamera)
        self.buttonCamera.addTarget(self, action: #selector(addImageCamera), for: .touchUpInside)
    }
    
    @objc private func addImageCamera() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let key = UIImagePickerController.InfoKey.originalImage
        var image = info[key] as? UIImage
        if image?.imageOrientation != .up {
            image = self.removeOrientationImage(image: image!)
        }
        self.imgView.contentMode = .scaleAspectFill
        self.imgView.image = image
        self.point.photo = image?.pngData()
        CoreDataManager.shared.saveContext()
        dismiss(animated: true)
    }
    
    private func removeOrientationImage(image: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: CGSize(width: image.size.width, height: image.size.height)))
        let imageNormal = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageNormal!
    }
    
    private func createTextField() {
        self.textField = UITextField()
        self.textField.frame.size.width = UIScreen.main.bounds.width - CGFloat.offset * 2
        self.textField.frame.size.height = 50
        self.textField.center.x = UIScreen.main.bounds.width / 2
        self.textField.frame.origin.y = self.buttonLibrary.frame.origin.y + self.buttonLibrary.frame.height + CGFloat.offset
        self.textField.placeholder = "name"
        self.textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: self.textField.frame.height / 2, height: 0))
        self.textField.leftViewMode = .always
        self.textField.backgroundColor = .text
        self.textField.textColor = UIColor.background
        self.textField.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(self.textField)
        self.textField.delegate = self
        self.textField.text = point.name
    }
    
    private func createButtonListSwitches() {
        let button = UIButton()
        button.frame.size = self.buttonLibrary.frame.size
        button.frame.origin.x = CGFloat.offset
        button.frame.origin.y = self.textField.frame.origin.y + self.textField.frame.height + CGFloat.offset
        button.backgroundColor = .text
        button.setTitle("Set switch", for: .normal)
        button.setTitleColor(.background, for: .normal)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(setSwitch), for: .touchUpInside)
    }
    
    @objc private func setSwitch() {
        let vc = ChooseSwitchVC()
        vc.switchesType = .choose
        vc.myDelegate = self
        let navVC = UINavigationController(rootViewController: vc)
        present(navVC, animated: true)
    }
    
    func get(switcher: Switcher) { 
        switcher.addToPoints(self.point)
        CoreDataManager.shared.saveContext()
    }
    
    private func createButtonShowSwitch() {
        let button = UIButton()
        button.frame.size = self.buttonLibrary.frame.size
        button.frame.origin.x = self.buttonCamera.frame.origin.x
        button.frame.origin.y = self.textField.frame.origin.y + self.textField.frame.height + CGFloat.offset
        button.backgroundColor = .text
        button.setTitle("Show switch", for: .normal)
        button.setTitleColor(.background, for: .normal)
        self.view.addSubview(button)
        button.addTarget(self, action: #selector(showSwitch), for: .touchUpInside)
    }
    
    @objc private func showSwitch() {
        if let switcher = point.switcher {
            let vc = ShowSwitcherVC()
            vc.switcher = switcher
            let navVC = UINavigationController(rootViewController: vc)
            self.present(navVC, animated: true)
        } else {
            let alert = UIAlertController(title: "Alert", message: "instal switcher", preferredStyle: .alert)
            let ok = UIAlertAction(title: "Ok", style: .default)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
    }
}

//MARK: - TextFieldDelegate -
extension PointVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.point.name = textField.text
        CoreDataManager.shared.saveContext()
    }
}
