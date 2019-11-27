//
//  ViewUtilities.swift
//  FDDemo
//
//  Created by Mars Geldard on 27/11/19.
//  Copyright © 2019 Mars Geldard. All rights reserved.
//

import UIKit

extension CGRect {
    func centeredOn(_ point: CGPoint) -> CGRect {
        let size = self.size
        let originX = point.x - (self.width / 2.0)
        let originY = point.y - (self.height / 2.0)
        return CGRect(
            x: originX,
            y: originY,
            width: size.width,
            height: size.height
        )
    }
}

extension Array where Element == CGPoint {
    var centerPoint: CGPoint {
        let elements = CGFloat(self.count)
        let totalX = self.reduce(0, { $0 + $1.x })
        let totalY = self.reduce(0, { $0 + $1.y })
        return CGPoint(x: totalX / elements, y: totalY / elements)
    }
}

extension CGPoint {
    func rotationDegreesTo(_ otherPoint: CGPoint) -> CGFloat {
        let originX = otherPoint.x - self.x
        let originY = otherPoint.y - self.y

        let degreesFromX = atan2f(
            Float(originY),
            Float(originX)) * (180 / .pi)

        let degreesFromY = degreesFromX - 90.0
        
        let normalizedDegrees = (degreesFromY + 360.0)
            .truncatingRemainder(dividingBy: 360.0)

        return CGFloat(normalizedDegrees)
    }
}

extension String {
    func image(of size: CGSize, scale: CGFloat = 0.94) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIColor.clear.set()
        let rect = CGRect(origin: .zero, size: size)
        UIRectFill(CGRect(origin: .zero, size: size))
        (self as AnyObject).draw(
            in: rect,
            withAttributes: [
                .font: UIFont.systemFont(ofSize: size.height * scale)
            ]
        )
        
        let image = UIGraphicsGetImageFromCurrentImageContext()

        UIGraphicsEndImageContext()
        
        return image
    }
}

extension UIImage {
    
    var cgImageOrientation: CGImagePropertyOrientation {
        switch self.imageOrientation {
            case .up: return .up
            case .down: return .down
            case .left: return .left
            case .right: return .right
            case .upMirrored: return .upMirrored
            case .downMirrored: return .downMirrored
            case .leftMirrored: return .leftMirrored
            case .rightMirrored: return .rightMirrored
            @unknown default: fatalError()
        }
    }
    
    func fixOrientation() -> UIImage? {
        UIGraphicsBeginImageContext(self.size)
        self.draw(at: .zero)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func rotatedBy(degrees: CGFloat, clockwise: Bool = false) -> UIImage? {
        var radians = (degrees) * (.pi / 180)
        if !clockwise { radians = -radians }
        
        let transform = CGAffineTransform(rotationAngle: CGFloat(radians))
        
        let newSize = CGRect(
            origin: CGPoint.zero,
            size: self.size
            ).applying(transform).size

        let roundedSize = CGSize(
            width: floor(newSize.width),
            height: floor(newSize.height))

        let centredRect = CGRect(
            x: -self.size.width / 2,
            y: -self.size.height / 2,
            width: self.size.width,
            height: self.size.height)
        
        UIGraphicsBeginImageContextWithOptions(
            roundedSize,
            false,
            self.scale)

        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        
        context.translateBy(
            x: roundedSize.width / 2,
            y: roundedSize.height / 2
        )

        context.rotate(by: radians)
        self.draw(in: centredRect)
        
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return result
    }
}
