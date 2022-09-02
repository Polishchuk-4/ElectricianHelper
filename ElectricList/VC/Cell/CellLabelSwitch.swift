//
//  CellLabelSwitch.swift
//  ElectricList
//
//  Created by Denis Polishchuk on 24.07.2022.
//

import UIKit

class CellLabelSwitch: UITableViewCell {
    var label: UILabel!
    var switc_h: UISwitch!
    static let height: CGFloat = 100
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.createLabel()
        self.createSwitch()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createLabel() {
        self.label = UILabel()
        self.label.frame.size.width = UIScreen.main.bounds.width / 3
        self.label.frame.size.height = 50
        self.label.frame.origin.x = CGFloat.offset
        self.label.center.y = CellLabelSwitch.height / 2
        self.label.textAlignment = .left
        self.label.font = UIFont.systemFont(ofSize: 25)
        self.label.text = "Label"
        self.contentView.addSubview(self.label)
    }
    
    private func createSwitch() {
        self.switc_h = UISwitch()
        self.switc_h.frame.origin.x = UIScreen.main.bounds.width - CGFloat.offset * 3 - switc_h.frame.size.width
        self.switc_h.center.y = CellLabelSwitch.height / 2
        self.contentView.addSubview(self.switc_h)
    }
}
