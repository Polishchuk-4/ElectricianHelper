//
//  Rect.swift
//  ElectricList
//
//  Created by Denis Polishchuk on 27.07.2022.
//

import UIKit

protocol DotDelegate {
    func getPositionDot(position: CGPoint)
}

class Dot: UIView {
    
    var myDelegate: DotDelegate!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.createColotCircle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func createColotCircle() {
        let view = UIView()
        view.frame.size = CGSize(width: 10, height: 10)
        view.layer.cornerRadius = view.frame.height / 2
        view.center.x = self.frame.width / 2
        view.center.y = self.frame.height / 2
        view.backgroundColor = .magenta
        self.addSubview(view)
    }
}

//MARK: - Touch -
extension Dot {
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first!
        let location = touch.location(in: superview!)
        self.center = location
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.myDelegate.getPositionDot(position: self.center)
    }
}
