//
//  RoomVC.swift
//  CoreData
//
//  Created by Denis Polishchuk on 19.07.2022.
//

import UIKit

class RoomVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var imgView: UIImageView!
    var buttonCamera: UIButton!
    var buttonLibrary: UIButton!
    var textField: UITextField!
    var collectionVie_w: UICollectionView!
    var labelPoin: UILabel!
    var room: Room!
    var points: [Point] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.background
        self.navigationItem.title = "Details room"
        self.createImgView()
        self.createbuttonLibrary()
        self.createbuttonCamera()
        self.createTextField()
        self.createLabelPoint()
        self.createCollectionVie_w()
        self.collectionVie_w.register(CellImageLabelRoomVC.self, forCellWithReuseIdentifier: CellImageLabelRoomVC.reuseId)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPoint))
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.points = CoreDataManager.shared.getPoints(room: self.room)
        self.collectionVie_w.reloadData()
    }
    
    @objc private func addPoint() {
        let vc = PointVC()
        vc.point = CoreDataManager.shared.createPoint(room: room)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    private func createImgView() {
        self.imgView = UIImageView()
        self.imgView.frame.size.width = UIScreen.main.bounds.width - CGFloat.offset * 2
        self.imgView.frame.size.height = UIScreen.main.bounds.height * 0.22
        self.imgView.frame.origin.x = CGFloat.offset
        self.imgView.frame.origin.y = self.navigationController!.navigationBar.frame.height + 40 + CGFloat.offset
        self.imgView.layer.borderWidth = 3
        self.imgView.layer.borderColor = UIColor.text.cgColor
        if let photoData = room.photo {
            self.imgView.image = UIImage(data: photoData)
            self.imgView.contentMode = .scaleAspectFill
        } else {
            let image = "photo".getSymbol(pointSize: 2, weight: .light)
            self.imgView.image = image
            self.imgView.contentMode = .scaleAspectFit
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
        self.imgView.image = image
        self.imgView.contentMode = .scaleAspectFill
        self.imgView.clipsToBounds = true
        self.room.photo = image?.pngData()
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
        self.textField.text = room.name
    }
    
    private func createLabelPoint() {
        self.labelPoin = UILabel()
        self.labelPoin.frame.size.width = UIScreen.main.bounds.width - CGFloat.offset * 2
        self.labelPoin.frame.size.height = self.textField.frame.height
        self.labelPoin.frame.origin.x = CGFloat.offset
        self.labelPoin.frame.origin.y = self.textField.frame.origin.y + self.textField.frame.height
        self.labelPoin.text = "Electric poin"
        self.labelPoin.textColor = UIColor.text
        self.labelPoin.textAlignment = .center
        self.labelPoin.font = UIFont.systemFont(ofSize: 25)
        self.view.addSubview(self.labelPoin)
    }
    
    private func createCollectionVie_w() {
        self.collectionVie_w = UICollectionView(frame: CGRect(
            x: CGFloat.offset,
            y: self.labelPoin.frame.origin.y + self.labelPoin.frame.height,
            width: UIScreen.main.bounds.width - CGFloat.offset * 2,
            height: UIScreen.main.bounds.height - self.textField.frame.origin.y - self.textField.frame.height - self.navigationController!.navigationBar.frame.height * 3.1),
                                                collectionViewLayout: self.createLoyout())
        self.collectionVie_w.backgroundColor = UIColor.background
        self.collectionVie_w.layer.borderWidth = 3
        self.collectionVie_w.layer.borderColor = UIColor.text.cgColor
        self.view.addSubview(self.collectionVie_w)
        self.collectionVie_w.dataSource = self
        self.collectionVie_w.delegate = self
    }
    
    private func createLoyout() -> UICollectionViewFlowLayout {
        let loyout = UICollectionViewFlowLayout()
        loyout.itemSize = CGSize(width: CellImageLabelRoomVC.width, height: CellImageLabelRoomVC.height)
        loyout.scrollDirection = .vertical
        loyout.minimumLineSpacing = CGFloat.offset
        return loyout
    }
}

//MARK: - TextField -
extension RoomVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        room.name = textField.text
        CoreDataManager.shared.saveContext()
    }
}


//MARK: - UICollectionViewDataSource -
extension RoomVC {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.points.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellImageLabelRoomVC.reuseId, for: indexPath) as! CellImageLabelRoomVC
        let point = self.points[indexPath.row]
        if let photoData = point.photo {
            cell.imgView.image = UIImage(data: photoData)
            cell.imgView.contentMode = .scaleAspectFill
        } else {
            cell.imgView.image = "photo".getSymbol(pointSize: cell.bounds.width, weight: .light)
            cell.imgView.contentMode = .scaleAspectFit
            cell.imgView.tintColor = .text
        }
        cell.label.text = point.name
        return cell
    }
}

//MARK: - UICollectionViewDelegate - {
extension RoomVC {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = PointVC()
        let point = self.points[indexPath.row]
        vc.point = point
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, contextMenuConfigurationForItemAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let actionDelete = UIAction(title: "Delete", image: "trash".getSymbol(pointSize: 20, weight: .light), identifier: .none, discoverabilityTitle: "discoverabilityTitle", attributes: .destructive, state: .on) { action in
            let point = self.points.remove(at: indexPath.row)
            CoreDataManager.shared.delete(point: point)
            collectionView.deleteItems(at: [indexPath])
        }
        let menu = UIMenu(title: "Menu", children: [actionDelete])
        let config = UIContextMenuConfiguration(identifier: nil, previewProvider: nil) { actions in
            return menu
        }
        return config
    }
}
