//
//  SwitcherVCViewController.swift
//  CoreData
//
//  Created by Denis Polishchuk on 19.07.2022.
//

import UIKit

class SwitcherVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imgView: UIImageView!
    var switcher: Switcher!
    var dot: Dot!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .background
        self.createImgView()
        self.addButtons()
        self.createDot()
        if self.switcher.photo == nil {
            dot.isHidden = true
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if switcher.photo == nil {
            CoreDataManager.shared.delete(swither: switcher)
        } else if switcher.centrePoint == nil {
            switcher.centrePoint = "\(dot.center.x) \(dot.center.y)"
        }
    }
    
    private func createImgView() {
        self.imgView = UIImageView()
        self.imgView.frame.size.width = UIScreen.main.bounds.width
        self.imgView.frame.size.height = UIScreen.main.bounds.height - navigationController!.navigationBar.frame.origin.y - navigationController!.navigationBar.frame.height - navigationController!.tabBarController!.tabBar.frame.height
        self.imgView.frame.origin.y = navigationController!.navigationBar.frame.origin.y + navigationController!.navigationBar.frame.height
        self.imgView.isUserInteractionEnabled = true
        self.imgView.contentMode = .scaleAspectFit
        if let photoData = switcher.photo {
            self.imgView.image = UIImage(data: photoData)
            self.setSizeImgView()
        } else {
            self.imgView.image = "photo".getSymbol(pointSize: 100, weight: .light)
            self.imgView.tintColor = .text
        }
//        self.imgView.backgroundColor = .magenta
        self.view.addSubview(self.imgView)
        
    }
    
    private func addButtons() {
        let buttonLibrary = UIButton()
        buttonLibrary.frame.size = CGSize(width: 30, height: 30)
        let image = "photo".getSymbol(pointSize: 20, weight: .light)
        buttonLibrary.setImage(image, for: .normal)
        buttonLibrary.tintColor = .text
        buttonLibrary.addTarget(self, action: #selector(chooseImage), for: .touchUpInside)
        
        let buttonCamera = UIButton()
        buttonCamera.frame.size = buttonLibrary.frame.size
        let imageCamera = "camera".getSymbol(pointSize: 20, weight: .light)
        buttonCamera.setImage(imageCamera, for: .normal)
        buttonCamera.tintColor = .text
        buttonCamera.addTarget(self, action: #selector(takeImage), for: .touchUpInside)
    
        let finalButtonLibrary = UIBarButtonItem(customView: buttonLibrary)
        let finalButtonCamera = UIBarButtonItem(customView: buttonCamera)
        let spase = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        spase.width = 20
        
        self.navigationItem.rightBarButtonItems = [finalButtonCamera, spase, finalButtonLibrary]
    }
    
    @objc private func chooseImage() {
        let vc = UIImagePickerController()
        vc.sourceType = .photoLibrary
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    @objc private func takeImage() {
        let vc = UIImagePickerController()
        vc.sourceType = .camera
        vc.delegate = self
        self.present(vc, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let key = UIImagePickerController.InfoKey.originalImage
        var image = info[key] as! UIImage
        if image.imageOrientation != .up {
            image = self.removeOrientationImage(image: image)
        }
        self.imgView.image = image
        self.switcher.photo = image.pngData()
        CoreDataManager.shared.saveContext()
        dot.isHidden = false
        self.setSizeImgView()
        dismiss(animated: true)
    }
    
    private func removeOrientationImage(image: UIImage) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(origin: .zero, size: CGSize(width: image.size.width, height: image.size.height)))
        let imageNormal = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return imageNormal!
    }
    
    func createDot() {
        let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.dot = Dot(frame: frame)
        self.imgView.addSubview(dot)
        if let position = switcher.centrePoint {
            let componetsXY = position.components(separatedBy: " ")
            let xStr = componetsXY.first!
            let x = (xStr as NSString).doubleValue
            let yStr = componetsXY.last!
            let y = (yStr as NSString).doubleValue
            dot.center = CGPoint(x: x, y: y)
            
        } else {
            self.setDefaultPositionDot()
        }
        dot.myDelegate = self
        dot.tag = 1
    }
    
    private func setDefaultPositionDot() {
        if dot == nil { return }
        dot.center.x = self.view.center.x
        dot.center.y = self.imgView.frame.height / 2
    }
    
    private func setSizeImgView() {
        let imageRatio = self.imgView.image!.size.height / self.imgView.image!.size.width
        let imgViewRatio = self.imgView.frame.height / self.imgView.frame.width
        if imageRatio > imgViewRatio {
            self.imgView.frame.size.width = self.imgView.frame.height / imageRatio
        } else {
            self.imgView.frame.size.height = self.imgView.frame.width * imageRatio
        }
        self.imgView.center = self.view.center
        self.setDefaultPositionDot()
        if UserDefaultsManager.shared.sizeImgView == "" {
            UserDefaultsManager.shared.sizeImgView = "\(imgView.frame.size.width) \(imgView.frame.size.height)"
        }
    }
}

extension SwitcherVC: DotDelegate {
    func getPositionDot(position: CGPoint) {
        self.switcher.centrePoint = "\(position.x) \(position.y)"
        CoreDataManager.shared.saveContext()
    }
}
