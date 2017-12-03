//
//  BaloonView.swift
//  Age Chart
//
//  Created by 横島健一 on 2017/12/03.
//  Copyright © 2017年 info.tmpla. All rights reserved.
//

import UIKit

class BalloonView: UIView {

//    let triangleSideLength: CGFloat = 20
    let triangleHeight: CGFloat = 10
    var label:UILabel!
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(UIColor.green.cgColor)
            contextBalloonPath(context: context, rect: rect)
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup?()
    }
    
    private lazy var setup: (()->())? = {
        print("MyView: \(#function)")
        // さまざまな初期化のコード
        let frameSize = self.frame.size
        label = UILabel(frame: self.bounds)
        label.bounds.size.height = frameSize.height / 2
        label.bounds.size.width = (frameSize.width / 5) * 4
        label.frame.origin.y = (label.bounds.size.height + triangleHeight) / 2
//        label.frame.origin.x = self.bounds.origin.x
//        label.backgroundColor = UIColor.cyan
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.adjustsFontSizeToFitWidth = true
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        addSubview(label)
        self.backgroundColor = UIColor.clear
        return nil
    }()

    func contextBalloonPath(context: CGContext, rect: CGRect) {
        let size = rect.size
        let triangleWidth = size.width / 10
        let centerPosition = ((size.width + triangleWidth) / 3) * 2
        let triangleRightCorner = CGPoint(x: centerPosition + (triangleWidth / 2), y: triangleHeight)
        let triangleTopCorner = CGPoint(x: centerPosition, y: 0)
        let triangleLeftCorner = CGPoint(x: centerPosition - (triangleWidth / 2), y: triangleHeight)
        context.addRect(CGRect(x: 0, y: triangleHeight, width: size.width, height: size.height - triangleHeight))
        context.fillPath()
        context.move(to: triangleLeftCorner)
        context.addLine(to: triangleTopCorner)
        context.addLine(to: triangleRightCorner)
        context.fillPath()
    }
    
}
