//
//  Extensions.swift
//  Doing
//
//  Created by rotem nevgauker on 2/13/18.
//  Copyright © 2018 rotem nevgauker. All rights reserved.
//

import UIKit


extension Date {
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var tomorrow: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return tomorrow.month != month
    }
}

extension UIImage {
    
    var isPortrait:  Bool    { return size.height > size.width }
    var isLandscape: Bool    { return size.width > size.height }
    var breadth:     CGFloat { return min(size.width, size.height) }
    var breadthSize: CGSize  { return CGSize(width: breadth, height: breadth) }
    var breadthRect: CGRect  { return CGRect(origin: .zero, size: breadthSize) }
    
    var circleMasked: UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(breadthSize, false, scale)
        defer { UIGraphicsEndImageContext() }
        
        guard let cgImage = cgImage?.cropping(to: CGRect(origin:
            CGPoint(
                x: isLandscape ? floor((size.width - size.height) / 2) : 0,
                y: isPortrait  ? floor((size.height - size.width) / 2) : 0),
                                                         size: breadthSize))
            else { return nil }
        
        UIBezierPath(ovalIn: breadthRect).addClip()
        UIImage(cgImage: cgImage, scale: 1, orientation: imageOrientation)
            .draw(in: breadthRect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    // classic 'circleMasked' stackoverflow fragment
    // courtesy Leo Dabius /a/29047372/294884
    class func imageWithColor(color: UIColor, size: CGSize=CGSize(width: 1, height: 1)) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: CGPoint.zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
}


class Extensions: NSObject {

}
