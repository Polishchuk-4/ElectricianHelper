//
//  CellImageLabelRoomVC.swift
//  ElectricList
//
//  Created by Denis Polishchuk on 21.07.2022.
//

import UIKit

class CellImageLabelRoomVC: UICollectionViewCell {
    var imgView: UIImageView!
    var label: UILabel!
    static let reuseId = "CellImageLabelRoomVC"
    static let width = (UIScreen.main.bounds.width - CGFloat.offset * 3) / 2
    private static var heightLabel = CellImageLabelRoomVC.width * 0.2
    static var height: CGFloat {
        return CellImageLabelRoomVC.width + CellImageLabelRoomVC.heightLabel
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createImgView()
        self.createLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createImgView() {
        self.imgView = UIImageView()
        self.imgView.frame.size.width = CellImageLabelRoomVC.width - CGFloat.offset * 2
        self.imgView.frame.size.height = self.imgView.frame.size.width
        self.imgView.frame.origin = CGPoint(x: CGFloat.offset, y: CGFloat.offset)
        self.imgView.backgroundColor = .background
        self.imgView.clipsToBounds = true
        self.contentView.addSubview(self.imgView)
    }
    
    private func createLabel() {
        self.label = UILabel()
        self.label.frame.size.width = self.imgView.frame.width
        self.label.frame.size.height = CellImageLabelRoomVC.heightLabel
        self.label.frame.origin.x = CGFloat.offset
        self.label.frame.origin.y = self.imgView.frame.origin.y + self.imgView.frame.height
        self.label.textColor = .white
        self.label.textAlignment = .center
        self.contentView.addSubview(self.label)
    }
}
