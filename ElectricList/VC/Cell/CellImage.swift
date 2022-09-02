//
//  CellImage.swift
//  ElectricList
//
//  Created by Denis Polishchuk on 28.07.2022.
//

import UIKit

class CellImage: UITableViewCell {
    var imgView: UIImageView!
    static let height: CGFloat = UIScreen.main.bounds.height / 2 + CGFloat.offset
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createImgView()
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createImgView() {
        self.imgView = UIImageView()
        self.imgView.frame.size.height = CellImage.height - CGFloat.offset
        self.imgView.frame.size.width = self.getWidthImgView()
        self.imgView.frame.origin.y = CGFloat.offset
        self.imgView.center.x = UIScreen.main.bounds.width / 2
        self.contentView.addSubview(self.imgView)
        self.imgView.contentMode = .scaleAspectFit
    }
    
    private func getWidthImgView() -> CGFloat {
        let sizeImgViewStr = UserDefaultsManager.shared.sizeImgView
        let components = sizeImgViewStr.components(separatedBy: " ")
        let width = (components[0] as NSString).doubleValue
        let height = (components[1] as NSString).doubleValue
        let ratio = height / width
        let finWidth = self.imgView.frame.height / ratio
        return finWidth
    }
}
