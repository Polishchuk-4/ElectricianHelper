//
//  CellImageLabel.swift
//  ElectricList
//
//  Created by Denis Polishchuk on 21.07.2022.
//

import UIKit

class CellImageLabelRoomListVC: UITableViewCell {
    var imgView: UIImageView!
    var label: UILabel!
    private static let heightImgView: CGFloat = UIScreen.main.bounds.height * 0.22
    private static let heightLabel: CGFloat = 50
    static var height: CGFloat {
        return CellImageLabelRoomListVC.heightImgView + CellImageLabelRoomListVC.heightLabel + CGFloat.offset * 3
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createImgView()
        self.createLabel()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createImgView() {
        self.imgView = UIImageView()
        self.imgView.frame.size.width = UIScreen.main.bounds.width - CGFloat.offset * 2
        self.imgView.frame.size.height = CellImageLabelRoomListVC.heightImgView
        self.imgView.center.x = UIScreen.main.bounds.width / 2
        self.imgView.frame.origin.y = 15
        self.imgView.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.imgView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.imgView.tintColor = .text
    }
    
    private func createLabel() {
        self.label = UILabel()
        self.label.frame.size.width = UIScreen.main.bounds.width * 0.8
        self.label.frame.size.height = CellImageLabelRoomListVC.heightLabel
        self.label.center.x = UIScreen.main.bounds.width / 2
        self.label.frame.origin.y = CellImageLabelRoomListVC.heightImgView + CGFloat.offset * 2
        self.label.textColor = UIColor.text
        self.label.textAlignment = .center
        self.label.font = UIFont.systemFont(ofSize: 25)
        self.contentView.addSubview(self.label)
    }
}
