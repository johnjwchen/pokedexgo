//
//  PGArrowLabel.swift
//  PokedexGo
//
//  Created by JIAWEI CHEN on 3/10/17.
//  Copyright © 2017 PokGear. All rights reserved.
//

import UIKit

class PGArrowLabel: UILabel {

    let arrowLayer = CAShapeLayer()
    override func awakeFromNib() {
        super.awakeFromNib()
        
        arrowLayer.strokeColor = UIColor.black.cgColor
        arrowLayer.fillColor = UIColor.black.cgColor
        
        self.layer.addSublayer(arrowLayer)
    }
    
    private func arrowPath() -> CGPath {
        let height = self.bounds.size.height / 2 + 14
        let width = self.bounds.size.width
        let arrow = UIBezierPath.arrow(from: CGPoint(x: 0, y: height), to: CGPoint(x: width, y: height),
                                       tailWidth: 1.5, headWidth: 6, headLength: 12)
        return arrow.cgPath
    }
    
    override func layoutSubviews() {
        arrowLayer.path = arrowPath()
        super.layoutSubviews()
    }
    

}

extension UIBezierPath {
    
    class func arrow(from start: CGPoint, to end: CGPoint, tailWidth: CGFloat, headWidth: CGFloat, headLength: CGFloat) -> Self {
        let length = hypot(end.x - start.x, end.y - start.y)
        let tailLength = length - headLength
        
        func p(_ x: CGFloat, _ y: CGFloat) -> CGPoint { return CGPoint(x: x, y: y) }
        let points: [CGPoint] = [
            p(0, tailWidth / 2),
            p(tailLength, tailWidth / 2),
            p(tailLength, headWidth / 2),
            p(length, 0),
            p(tailLength, -headWidth / 2),
            p(tailLength, -tailWidth / 2),
            p(0, -tailWidth / 2)
        ]
        
        let cosine = (end.x - start.x) / length
        let sine = (end.y - start.y) / length
        let transform = CGAffineTransform(a: cosine, b: sine, c: -sine, d: cosine, tx: start.x, ty: start.y)
        
        let path = CGMutablePath()
        path.addLines(between: points, transform: transform)
        path.closeSubpath()
        
        return self.init(cgPath: path)
    }
    
}

