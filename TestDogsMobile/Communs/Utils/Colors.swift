//
//  Colors.swift
//  TestDogsMobile
//
//  Created by Jose Luis on 16/03/22.
//

import Foundation
import UIKit
extension UIColor {
    convenience init(hex:Int, alpha:CGFloat = 1.0) {
        self.init(
            red:   CGFloat((hex & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((hex & 0x00FF00) >> 8)  / 255.0,
            blue:  CGFloat((hex & 0x0000FF) >> 0)  / 255.0,
            alpha: alpha
        )
    }
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    //Usage UIColor(rgb: 0x00FFFF)
}
extension UIColor{
    class func fontColor1() -> UIColor{
        return UIColor(rgb: 0xF8F8F8)
    }
    class func fontColor2() -> UIColor{
        return UIColor(rgb: 0x666666)
    }
    class func fontColor3() -> UIColor{
        return UIColor(rgb: 0x333333)
    }
}
